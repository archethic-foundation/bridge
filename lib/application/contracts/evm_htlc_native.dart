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
  late final Web3Client web3Client;
  final int chainId;

  /// TODO(reddwarf03): This is never used
  Future<aedappfm.Result<void, aedappfm.Failure>> provisionChargeableHTLC(
    WidgetRef ref,
    double amount,
  ) async {
    return aedappfm.Result.guard(() async {
      final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
      final ethAmount = EtherAmount.fromDouble(EtherUnit.ether, amount);

      try {
        final completer = Completer<void>();
        final contract =
            await getDeployedContract(contractNameHTLCETH, htlcContractAddress);

        final eventStream = web3Client
            .events(
              FilterOptions.events(
                contract: contract,
                event: contract.event('FundsReceived'),
                fromBlock: const BlockNum.current(),
              ),
            )
            .asBroadcastStream();
        final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
        await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
        final txHash = await sendTransactionWithErrorManagement(
          web3Client,
          evmWalletProvider.credentials!,
          Transaction(
            to: EthereumAddress.fromHex(htlcContractAddress),
            value: ethAmount,
          ),
          chainId,
        );
        await bridgeNotifier.setWalletConfirmation(null);

        unawaited(
          eventStream
              .firstWhere((event) => event.transactionHash == txHash)
              .then(
            (event) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    'Event FundsReceived = $event',
                    name: 'EVMHTLCNative - provisionChargeableHTLC',
                  );
              if (!completer.isCompleted) {
                completer.complete();
              }
            },
          ),
        );

        await completer.future.timeout(const Duration(seconds: 240));
      } catch (e, stackTrace) {
        if (e is TimeoutException) {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'Timeout occurred',
                level: aedappfm.LogLevel.error,
                name: 'EVMHTLCNative - provisionChargeableHTLC',
              );
          throw const aedappfm.Failure.timeout();
        } else {
          if (e != const aedappfm.Failure.userRejected()) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'e $e',
                  stackTrace: stackTrace,
                  level: aedappfm.LogLevel.error,
                  name: 'EVMHTLCNative - provisionChargeableHTLC',
                );
          }
        }
        rethrow;
      } finally {
        await web3Client.dispose();
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

        String? withdrawTx;
        try {
          final completer = Completer<void>();

          final eventStream = web3Client
              .events(
                FilterOptions.events(
                  contract: contractHTLCETH,
                  event: contractHTLCETH.event('Withdrawn'),
                  fromBlock: const BlockNum.current(),
                ),
              )
              .asBroadcastStream();
          final bridgeNotifier =
              ref.read(BridgeFormProvider.bridgeForm.notifier);
          await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
          withdrawTx = await sendTransactionWithErrorManagement(
            web3Client,
            evmWalletProvider.credentials!,
            transactionWithdraw,
            chainId,
          );
          await bridgeNotifier.setWalletConfirmation(null);

          unawaited(
            eventStream
                .firstWhere((event) => event.transactionHash == withdrawTx)
                .then<void>(
              (event) {
                aedappfm.sl.get<aedappfm.LogManager>().log(
                      'Event Withdrawn = $event',
                      name: 'EVMHTLCNative - signedWithdraw',
                    );
                if (!completer.isCompleted) {
                  completer.complete();
                }
              },
            ).catchError(completer.completeError),
          );

          await completer.future.timeout(const Duration(seconds: 240));
        } catch (e, stackTrace) {
          if (e is TimeoutException) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Timeout occurred',
                  level: aedappfm.LogLevel.error,
                  name: 'EVMHTLCNative - signedWithdraw',
                );
            throw const aedappfm.Failure.timeout();
          } else {
            if (e != const aedappfm.Failure.userRejected()) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    'e $e',
                    stackTrace: stackTrace,
                    level: aedappfm.LogLevel.error,
                    name: 'EVMHTLCNative - signedWithdraw',
                  );
            }
          }
          rethrow;
        } finally {
          await web3Client.dispose();
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
            contractNameChargeableHTLCETH,
            htlcContractAddress,
          );

          final feeMap = await web3Client.call(
            contract: contractHTLC,
            function: contractHTLC.function('fee'),
            params: [],
          );

          final BigInt fee = feeMap[0];
          final etherAmount = EtherAmount.fromBigInt(EtherUnit.wei, fee);
          return etherAmount.getValueInUnit(EtherUnit.ether);
        } catch (e) {
          return 0.0;
        }
      },
    );
  }
}
