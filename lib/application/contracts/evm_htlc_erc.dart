import 'dart:async';

import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/webthree.dart';

class EVMHTLCERC with EVMBridgeProcessMixin {
  EVMHTLCERC(
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
    String tokenAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
        final contract =
            await getDeployedContract(contractNameIERC20, tokenAddress);

        final ethAmount = EtherAmount.fromDouble(EtherUnit.ether, amount);
        final transactionTransfer = Transaction.callContract(
          contract: contract,
          function: contract.function('transfer'),
          parameters: [
            EthereumAddress.fromHex(htlcContractAddress),
            ethAmount.getInWei,
          ],
          maxGas: 1500000,
        );

        var timeout = false;
        late StreamSubscription<FilterEvent> subscription;
        try {
          subscription = web3Client!
              .events(
                FilterOptions.events(
                  contract: contract,
                  event: contract.event('Transfer'),
                ),
              )
              .take(1)
              .listen(
            (event) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    'Event Transfer = $event',
                    level: aedappfm.LogLevel.debug,
                    name: 'EVMHTLCERC - provisionChargeableHTLC',
                  );
            },
          );
          final bridgeNotifier =
              ref.read(BridgeFormProvider.bridgeForm.notifier);
          await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
          await sendTransactionWithErrorManagement(
            web3Client!,
            evmWalletProvider.credentials!,
            transactionTransfer,
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
                  name: 'EVMHTLCERC - provisionChargeableHTLC',
                );
          }
          await subscription.cancel();
          rethrow;
        }
        if (timeout) {
          throw const aedappfm.Failure.timeout();
        }
      },
    );
  }

  Future<aedappfm.Result<String, aedappfm.Failure>> signedWithdraw(
    WidgetRef ref,
    Secret secret,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();

        final contractHTLCERC = await getDeployedContract(
          contractNameSignedHTLCERC,
          htlcContractAddress,
        );

        final transactionWithdraw = Transaction.callContract(
          contract: contractHTLCERC,
          function: contractHTLCERC.findFunctionByNameAndNbOfParameters(
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
                  contract: contractHTLCERC,
                  event: contractHTLCERC.event('Withdrawn'),
                ),
              )
              .take(1)
              .listen((event) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Event Withdrawn = $event',
                  level: aedappfm.LogLevel.debug,
                  name: 'EVMHTLCERC - signedWithdraw',
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
                  name: 'EVMHTLCERC - signedWithdraw',
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

  Future<aedappfm.Result<double, aedappfm.Failure>> getFee() async {
    return aedappfm.Result.guard(
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
          throw const aedappfm.Failure.notHTLC();
        }
      },
    );
  }

  Future<aedappfm.Result<int, aedappfm.Failure>> getTokenNbOfDecimal(
    String tokenAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final contractHTLC = await getDeployedContract(
          contractNameIERC20,
          tokenAddress,
        );

        final decimalsMap = await web3Client!.call(
          contract: contractHTLC,
          function: contractHTLC.function('decimals'),
          params: [],
        );

        final int decimals = decimalsMap[0].toInt();
        return decimals;
      },
    );
  }
}
