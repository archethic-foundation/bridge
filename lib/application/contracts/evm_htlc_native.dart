import 'dart:async';

import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/util/custom_logs.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
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

  Future<Result<void, Failure>> provisionChargeableHTLC(
    WidgetRef ref,
    double amount,
  ) async {
    return Result.guard(() async {
      final evmWalletProvider = sl.get<EVMWalletProvider>();
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
          sl.get<LogManager>().log(
                'Event FundsReceived = $event',
                level: LogLevel.debug,
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
            gasPrice: EtherAmount.fromInt(EtherUnit.gwei, 20),
            maxGas: 1500000,
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
        sl.get<LogManager>().log(
              'e $e',
              stackTrace: stackTrace,
              level: LogLevel.error,
              name: 'EVMHTLCNative - provisionChargeableHTLC',
            );
        await subscription.cancel();
        rethrow;
      }
      if (timeout) {
        throw const Failure.timeout();
      }
    });
  }

  Future<Result<String, Failure>> signedWithdraw(
    WidgetRef ref,
    Secret secret,
  ) async {
    return Result.guard(
      () async {
        final evmWalletProvider = sl.get<EVMWalletProvider>();

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
            sl.get<LogManager>().log(
                  'Event Withdrawn = $event',
                  level: LogLevel.debug,
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
          sl.get<LogManager>().log(
                'e $e',
                stackTrace: stackTrace,
                level: LogLevel.error,
                name: 'EVMHTLCNative - signedWithdraw',
              );
          await subscription.cancel();
          rethrow;
        }
        if (timeout) {
          throw const Failure.timeout();
        }
        return withdrawTx;
      },
    );
  }

  Future<Result<double, Failure>> getFee() async {
    return Result.guard(
      () async {
        try {
          final contractHTLC = await getDeployedContract(
            contractNameChargeableHTLCERC,
            htlcContractAddress,
          );

          final feeMap = await web3Client!.call(
            contract: contractHTLC,
            function: contractHTLC.function('fee'),
            params: [],
          );

          final BigInt fee = feeMap[0];
          final etherAmount = EtherAmount.fromBigInt(EtherUnit.wei, fee);
          return etherAmount.getValueInUnit(EtherUnit.ether);
        } catch (e) {
          throw const Failure.notHTLC();
        }
      },
    );
  }
}