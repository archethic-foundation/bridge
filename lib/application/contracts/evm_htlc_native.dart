import 'dart:async';

import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/webthree.dart';

class EVMHTLCNative with EVMBridgeProcessMixin {
  EVMHTLCNative(
    this.providerEndpoint,
    this.htlcContractAddress,
    this.chainId,
  ) {
    web3Client = Web3Client(providerEndpoint, Client());
  }
  final String providerEndpoint;
  final String htlcContractAddress;
  Web3Client? web3Client;
  final int chainId;

  Future<aedappfm.Result<void, aedappfm.Failure>> provisionChargeableHTLC(
    WidgetRef ref,
    double amount,
  ) async {
    return aedappfm.Result.guard(() async {
      final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
      final ethAmount = EtherAmount.fromDouble(EtherUnit.ether, amount);

      var timeout = false;
      late StreamSubscription<FilterEvent> subscription;
      try {
        final contract =
            await getDeployedContract(contractNameHTLCETH, htlcContractAddress);

        subscription = web3Client!
            .events(
              FilterOptions.events(
                contract: contract,
                event: contract.event('FundsReceived'),
              ),
            )
            .take(1)
            .listen((event) {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'Event FundsReceived = $event',
                level: aedappfm.LogLevel.debug,
                name: 'EVMHTLCNative - provisionChargeableHTLC',
              );
        });

        final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
        await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
        await sendTransactionWithErrorManagement(
          web3Client!,
          evmWalletProvider.credentials!,
          Transaction(
            to: EthereumAddress.fromHex(htlcContractAddress),
            value: ethAmount,
          ),
          chainId,
        );
        await bridgeNotifier.setWalletConfirmation(null);

        await subscription.asFuture().timeout(
          const Duration(seconds: 240),
          onTimeout: () {
            return timeout = true;
          },
        );
        await subscription.cancel();
      } catch (e, stackTrace) {
        if (e != const aedappfm.Failure.userRejected()) {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'e $e',
                stackTrace: stackTrace,
                level: aedappfm.LogLevel.error,
                name: 'EVMHTLCNative - provisionChargeableHTLC',
              );
        }
        await subscription.cancel();
        rethrow;
      }
      if (timeout) {
        throw const aedappfm.Failure.timeout();
      }
    });
  }

  Future<aedappfm.Result<String, aedappfm.Failure>> signedWithdraw(
    WidgetRef ref,
    Secret secret,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();

        final contractHTLCETH = await getDeployedContract(
          contractNameSignedHTLCETH,
          htlcContractAddress,
        );

        final transactionWithdraw = Transaction.callContract(
          contract: contractHTLCETH,
          function: contractHTLCETH.findFunctionByNameAndNbOfParameters(
            'withdraw',
            4,
          ),
          parameters: [
            hexToBytes(secret.secret!),
            hexToBytes(secret.secretSignature!.r!),
            hexToBytes(secret.secretSignature!.s!),
            BigInt.from(secret.secretSignature!.v!),
          ],
          maxGas: 1500000,
        );

        var withdrawTx = '';
        var timeout = false;
        late StreamSubscription<FilterEvent> subscription;
        try {
          subscription = web3Client!
              .events(
                FilterOptions.events(
                  contract: contractHTLCETH,
                  event: contractHTLCETH.event('Withdrawn'),
                ),
              )
              .take(1)
              .listen((event) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Event Withdrawn = $event',
                  level: aedappfm.LogLevel.debug,
                  name: 'EVMHTLCNative - signedWithdraw',
                );
          });

          final bridgeNotifier =
              ref.read(BridgeFormProvider.bridgeForm.notifier);
          await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
          withdrawTx = await sendTransactionWithErrorManagement(
            web3Client!,
            evmWalletProvider.credentials!,
            transactionWithdraw,
            chainId,
          );
          await bridgeNotifier.setWalletConfirmation(null);

          await subscription.asFuture().timeout(
            const Duration(seconds: 240),
            onTimeout: () {
              return timeout = true;
            },
          );
          await subscription.cancel();
        } catch (e, stackTrace) {
          if (e != const aedappfm.Failure.userRejected()) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'e $e',
                  stackTrace: stackTrace,
                  level: aedappfm.LogLevel.error,
                  name: 'EVMHTLCNative - signedWithdraw',
                );
          }
          await subscription.cancel();
          rethrow;
        }
        if (timeout) {
          throw const aedappfm.Failure.timeout();
        }
        return withdrawTx;
      },
    );
  }

  Future<aedappfm.Result<({double fee, bool? isChargeable}), aedappfm.Failure>>
      getFee() async {
    return aedappfm.Result.guard(
      () async {
        try {
          final contractHTLC = await getDeployedContract(
            contractNameChargeableHTLCETH,
            htlcContractAddress,
          );

          final feeMap = await web3Client!.call(
            contract: contractHTLC,
            function: contractHTLC.function('fee'),
            params: [],
          );

          final BigInt fee = feeMap[0];
          final etherAmount = EtherAmount.fromBigInt(EtherUnit.wei, fee);
          return (
            fee: etherAmount.getValueInUnit(EtherUnit.ether),
            isChargeable: true,
          );
        } catch (e) {
          return (
            fee: 0.0,
            isChargeable: false,
          );
        }
      },
    );
  }
}
