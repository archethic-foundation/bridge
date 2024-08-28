import 'dart:async';

import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
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
    web3Client = Web3Client(
      providerEndpoint,
      Client(),
      customFilterPingInterval: const Duration(
        seconds: 5,
      ),
    );
  }
  final String providerEndpoint;
  final String htlcContractAddress;
  late final Web3Client web3Client;
  final int chainId;

  Future<aedappfm.Result<void, aedappfm.Failure>> approveChargeableHTLC(
    WidgetRef ref,
    double amount,
    String tokenAddress,
    String poolAddress,
    String userAddress,
    int decimal,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
        final contract =
            await getDeployedContract(contractNameIERC20, tokenAddress);

        final tokenUnits = (Decimal.parse('$amount') *
                Decimal.fromBigInt(BigInt.from(10).pow(decimal)))
            .toBigInt();
        final transactionTransfer = Transaction.callContract(
          contract: contract,
          function: contract.function('approve'),
          parameters: [
            EthereumAddress.fromHex(poolAddress),
            tokenUnits,
          ],
          maxGas: 1500000,
        );

        try {
          final completer = Completer<void>();

          final eventStream = web3Client
              .events(
                FilterOptions(
                  address: contract.address,
                  topics: [
                    [
                      bytesToHex(
                        contract.event('Approval').signature,
                        padToEvenLength: true,
                        include0x: true,
                      ),
                      userAddress.padRight(66, '0'),
                      poolAddress.padRight(66, '0'),
                    ]
                  ],
                  fromBlock: const BlockNum.current(),
                ),
              )
              .asBroadcastStream();

          final bridgeNotifier =
              ref.read(BridgeFormProvider.bridgeForm.notifier);
          await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
          final txHash = await sendTransactionWithErrorManagement(
            web3Client,
            evmWalletProvider.credentials!,
            transactionTransfer,
            chainId,
          );
          await bridgeNotifier.setWalletConfirmation(null);

          unawaited(
            eventStream
                .firstWhere((event) => event.transactionHash == txHash)
                .then<void>(
              (event) {
                aedappfm.sl.get<aedappfm.LogManager>().log(
                      'Event Approval received : $event',
                      name: 'EVMHTLCERC - approveChargeableHTLC',
                    );

                if (!completer.isCompleted) {
                  completer.complete();
                }
              },
            ).catchError(completer.completeError),
          );
          await completer.future.timeout(const Duration(seconds: 360));
        } catch (e, stackTrace) {
          if (e is TimeoutException) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Timeout occurred',
                  level: aedappfm.LogLevel.error,
                  name: 'EVMHTLCERC - approveChargeableHTLC',
                );
            throw const aedappfm.Failure.timeout();
          } else {
            if (e != const aedappfm.Failure.userRejected()) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    'e $e',
                    stackTrace: stackTrace,
                    level: aedappfm.LogLevel.error,
                    name: 'EVMHTLCERC - approveChargeableHTLC',
                  );
            }
          }
          rethrow;
        } finally {
          await web3Client.dispose();
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

        String? withdrawTx;
        try {
          final completer = Completer<void>();

          final eventStream = web3Client
              .events(
                FilterOptions.events(
                  contract: contractHTLCERC,
                  event: contractHTLCERC.event('Withdrawn'),
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
                      name: 'EVMHTLCERC - signedWithdraw',
                    );

                if (!completer.isCompleted) {
                  completer.complete();
                }
              },
            ).catchError(completer.completeError),
          );

          await completer.future.timeout(const Duration(seconds: 360));
        } catch (e, stackTrace) {
          if (e is TimeoutException) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Timeout occurred',
                  level: aedappfm.LogLevel.error,
                  name: 'EVMHTLCERC - signedWithdraw',
                );
            throw const aedappfm.Failure.timeout();
          } else {
            if (e != const aedappfm.Failure.userRejected()) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    'e $e',
                    stackTrace: stackTrace,
                    level: aedappfm.LogLevel.error,
                    name: 'EVMHTLCERC - signedWithdraw',
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

  Future<aedappfm.Result<double, aedappfm.Failure>> getFee(int decimal) async {
    return aedappfm.Result.guard(
      () async {
        try {
          final contractHTLC = await getDeployedContract(
            contractNameChargeableHTLCERC,
            htlcContractAddress,
          );

          final feeMap = await web3Client.call(
            contract: contractHTLC,
            function: contractHTLC.function('fee'),
            params: [],
          );

          final BigInt fee = feeMap[0];
          final convertedFee = (Decimal.parse('$fee') /
                  Decimal.fromBigInt(BigInt.from(10).pow(decimal)))
              .toDouble();

          return convertedFee;
        } catch (e) {
          return 0.0;
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

        final decimalsMap = await web3Client.call(
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
