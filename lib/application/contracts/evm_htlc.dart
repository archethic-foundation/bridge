/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/bridge_ae_process_mixin.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/webthree.dart';

class EVMHTLC with EVMBridgeProcessMixin, ArchethicBridgeProcessMixin {
  EVMHTLC(
    this.providerEndpoint,
    this.htlcContractAddressEVM,
    this.chainId,
  ) {
    web3Client = Web3Client(providerEndpoint!, Client());
  }

  final String? providerEndpoint;
  final String htlcContractAddressEVM;
  Web3Client? web3Client;
  Web3Client? web3ClientProvided;
  final int chainId;

  Future<aedappfm.Result<String, aedappfm.Failure>> refund(
    WidgetRef ref,
    bool isERC20,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();

        final contractHTLC = await getDeployedContract(
          isERC20
              ? contractNameChargeableHTLCERC
              : contractNameChargeableHTLCETH,
          htlcContractAddressEVM,
        );

        final transactionRefund = Transaction.callContract(
          contract: contractHTLC,
          function: contractHTLC.function('refund'),
          maxGas: 1500000,
          parameters: [],
        );

        var refundTx = '';
        late StreamSubscription<FilterEvent> subscription;
        final refundNotifier = ref.read(RefundFormProvider.refundForm.notifier);
        try {
          final completer = Completer<void>();
          subscription = web3Client!
              .events(
                FilterOptions.events(
                  contract: contractHTLC,
                  event: contractHTLC.event('Refunded'),
                ),
              )
              .take(1)
              .listen(
            (event) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    'Event ContractMinted = $event',
                    level: aedappfm.LogLevel.debug,
                    name: 'EVMHTLC - refund',
                  );
              if (!completer.isCompleted) {
                completer.complete();
              }
            },
          );

          refundNotifier.setWalletConfirmation(WalletConfirmationRefund.evm);
          refundTx = await sendTransactionWithErrorManagement(
            web3Client!,
            evmWalletProvider.credentials!,
            transactionRefund,
            chainId,
          );

          refundNotifier.setWalletConfirmation(null);
          await completer.future.timeout(const Duration(seconds: 240));
          await subscription.cancel();
        } catch (e, stackTrace) {
          if (e is TimeoutException) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Timeout occurred',
                  level: aedappfm.LogLevel.error,
                  name: 'EVMHTLC - refund',
                );
            await subscription.cancel();
            throw const aedappfm.Failure.timeout();
          } else {
            if (e != const aedappfm.Failure.userRejected()) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    'e $e',
                    stackTrace: stackTrace,
                    level: aedappfm.LogLevel.error,
                    name: 'EVMHTLC - refund',
                  );
            }
            await subscription.cancel();
            refundNotifier.setWalletConfirmation(null);
            rethrow;
          }
        }
        return refundTx;
      },
    );
  }

  Future<
          aedappfm
          .Result<({int dateLockTime, bool canRefund}), aedappfm.Failure>>
      getHTLCLockTimeAndRefundState() async {
    return aedappfm.Result.guard(
      () async {
        return (
          dateLockTime: await _getDateLockTime(),
          canRefund: await _isCanRefund(),
        );
      },
    );
  }

  Future<aedappfm.Result<int, aedappfm.Failure>> getHTLCLockTime() async {
    return aedappfm.Result.guard(
      () async {
        return _getDateLockTime();
      },
    );
  }

  Future<int> _getLockTime(
    DeployedContract contract,
  ) async {
    final lockTimeMap = await web3Client!.call(
      contract: contract,
      function: contract.function('lockTime'),
      params: [],
    );

    final BigInt lockTime = lockTimeMap[0];
    return lockTime.toInt();
  }

  Future<aedappfm.Result<double, aedappfm.Failure>> getAmount() async {
    return aedappfm.Result.guard(
      () async {
        final contractHTLC = await getDeployedContract(
          contractNameHTLCBase,
          htlcContractAddressEVM,
        );

        final amountMap = await web3Client!.call(
          contract: contractHTLC,
          function: contractHTLC.function('amount'),
          params: [],
        );

        final BigInt amount = amountMap[0];
        final etherAmount = EtherAmount.fromBigInt(EtherUnit.wei, amount);
        return etherAmount.getValueInUnit(EtherUnit.ether);
      },
    );
  }

  Future<aedappfm.Result<({String symbol, bool isERC20}), aedappfm.Failure>>
      getSymbol(
    String nativeCurrency,
  ) async {
    return aedappfm.Result.guard(() async {
      var _isERC20 = false;
      final contractHTLCERC = await getDeployedContract(
        contractNameHTLCERC,
        htlcContractAddressEVM,
      );
      var currency = nativeCurrency;
      try {
        final addressToken = await web3Client!.call(
          contract: contractHTLCERC,
          function: contractHTLCERC.function('token'),
          params: [],
        );

        if (addressToken.isNotEmpty) {
          final contratERC20 = await getDeployedContract(
            contractNameERC20,
            (addressToken[0] as EthereumAddress).hex,
          );

          final symbol = await web3Client!.call(
            contract: contratERC20,
            function: contratERC20.function('symbol'),
            params: [],
          );

          if (symbol.isNotEmpty) {
            currency = symbol[0];
            _isERC20 = true;
          }
        }
      } catch (e) {
        return (symbol: currency, isERC20: false);
      }

      return (symbol: currency, isERC20: _isERC20);
    });
  }

  Future<int> _getDateLockTime() async {
    final contract =
        await getDeployedContract(contractNameHTLCBase, htlcContractAddressEVM);
    return _getLockTime(contract);
  }

  Future<bool> _isCanRefund() async {
    final contract =
        await getDeployedContract(contractNameHTLCBase, htlcContractAddressEVM);
    final canRefundMap = await web3Client!.call(
      contract: contract,
      function: contract.function('canRefund'),
      params: [
        BigInt.from(DateTime.now().millisecondsSinceEpoch ~/ 1000),
      ],
    );

    final bool canRefund = canRefundMap[0];
    return canRefund;
  }

  Future<int> getStatus() async {
    final contractHTLC =
        await getDeployedContract(contractNameHTLCBase, htlcContractAddressEVM);

    final statusResult = await web3Client!.call(
      contract: contractHTLC,
      function: contractHTLC.function('status'),
      params: [],
    );

    final BigInt status = statusResult[0];
    return status.toInt();
  }

  Future<aedappfm.Result<String, aedappfm.Failure>> withdraw(
    WidgetRef ref,
    String secret,
    String contract,
    SecretSignature signatureAEHTLC,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();

        final contractHTLC = await getDeployedContract(
          contract,
          htlcContractAddressEVM,
        );

        final transactionWithdraw = Transaction.callContract(
          contract: contractHTLC,
          function:
              contractHTLC.findFunctionByNameAndNbOfParameters('withdraw', 4),
          parameters: [
            hexToBytes(secret),
            hexToBytes(signatureAEHTLC.r!),
            hexToBytes(signatureAEHTLC.s!),
            BigInt.from(signatureAEHTLC.v!),
          ],
          maxGas: 1500000,
        );

        var withdrawTx = '';
        late StreamSubscription<FilterEvent> subscription;
        try {
          final completer = Completer<void>();
          subscription = web3Client!
              .events(
                FilterOptions.events(
                  contract: contractHTLC,
                  event: contractHTLC.event('Withdrawn'),
                ),
              )
              .take(1)
              .listen(
            (event) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    'Event Withdrawn = $event',
                    level: aedappfm.LogLevel.debug,
                    name: 'EVMHTLC - withdraw',
                  );
              if (!completer.isCompleted) {
                completer.complete();
              }
            },
          );
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
          await completer.future.timeout(const Duration(seconds: 240));
          await subscription.cancel();
        } catch (e, stackTrace) {
          if (e is TimeoutException) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Timeout occurred',
                  level: aedappfm.LogLevel.error,
                  name: 'EVMHTLC - withdraw',
                );
            await subscription.cancel();
            throw const aedappfm.Failure.timeout();
          } else {
            if (e != const aedappfm.Failure.userRejected()) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    '$e',
                    stackTrace: stackTrace,
                    level: aedappfm.LogLevel.error,
                    name: 'EVMHTLC - withdraw',
                  );
            }
          }
          await subscription.cancel();
          rethrow;
        }
        return withdrawTx;
      },
    );
  }
}
