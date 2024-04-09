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
    this.htlcContractAddress,
    this.chainId,
  ) {
    web3Client = Web3Client(providerEndpoint!, Client());
  }

  final String? providerEndpoint;
  final String htlcContractAddress;
  Web3Client? web3Client;
  Web3Client? web3ClientProvided;
  final int chainId;

  Future<aedappfm.Result<String, aedappfm.Failure>> refund(
    WidgetRef ref,
    ProcessRefund processRefund,
    bool isERC,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();

        final contractHTLC = await getDeployedContract(
          processRefund == ProcessRefund.chargeable
              ? isERC
                  ? contractNameChargeableHTLCERC
                  : contractNameChargeableHTLCETH
              : isERC
                  ? contractNameSignedHTLCERC
                  : contractNameSignedHTLCETH,
          htlcContractAddress,
        );

        late Transaction transactionRefund;
        if (DateTime.now().isAfter(DateTime(2024, 2, 20))) {
          if (processRefund == ProcessRefund.chargeable) {
            transactionRefund = Transaction.callContract(
              contract: contractHTLC,
              function: contractHTLC.function('refund'),
              maxGas: 1500000,
              parameters: [],
            );
          } else {
            final secret = await revealAESecret(htlcContractAddress);

            transactionRefund = Transaction.callContract(
              contract: contractHTLC,
              function:
                  contractHTLC.findFunctionByNameAndNbOfParameters('refund', 4),
              maxGas: 1500000,
              parameters: [
                hexToBytes(secret.secret!),
                hexToBytes(secret.secretSignature!.r!),
                hexToBytes(secret.secretSignature!.s!),
                BigInt.from(secret.secretSignature!.v!),
              ],
            );
          }
        } else {
          // Refund contract from bridge one way
          transactionRefund = Transaction.callContract(
            contract: contractHTLC,
            function: contractHTLC.function('refund'),
            maxGas: 1500000,
            parameters: [],
          );
        }

        var refundTx = '';
        var timeout = false;
        late StreamSubscription<FilterEvent> subscription;
        final refundNotifier = ref.read(RefundFormProvider.refundForm.notifier);
        try {
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
                  name: 'EVMHTLC - refund',
                );
          }
          await subscription.cancel();
          refundNotifier.setWalletConfirmation(null);
          rethrow;
        }
        if (timeout) {
          refundNotifier.setWalletConfirmation(null);
          throw const aedappfm.Failure.timeout();
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
          htlcContractAddress,
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
      final contractHTLCERC =
          await getDeployedContract(contractNameHTLCERC, htlcContractAddress);
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
      } catch (e, stackTrace) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              '$e',
              stackTrace: stackTrace,
              level: aedappfm.LogLevel.error,
              name: 'EVMHTLC - getAmountCurrency',
            );
      }

      return (symbol: currency, isERC20: _isERC20);
    });
  }

  Future<int> _getDateLockTime() async {
    final contract =
        await getDeployedContract(contractNameHTLCBase, htlcContractAddress);
    return _getLockTime(contract);
  }

  Future<bool> _isCanRefund() async {
    final contract =
        await getDeployedContract(contractNameHTLCBase, htlcContractAddress);
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

  Future<String> getTxRefund() async {
    /*final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
    await evmWalletProvider.eth!.rawRequest(
      'eth_getFilterLogs',
      params: [
        htlcContractAddress,
        JSrawRequestParams(chainId: '0x${chainId.toRadixString(16)}'),
      ],
    );

    final contractHTLC =
        await getDeployedContract(contractNameHTLCBase, htlcContractAddress);

    final events = await web3Client!.getLogs(
      FilterOptions.events(
        contract: contractHTLC,
        event: contractHTLC.event('Refunded'),
      ),
    );
    if (events.isEmpty || events[0].address == null) {
      return '';
    }

    return events[0].address!.hex;*/
    return '';
  }

  Future<int> getStatus() async {
    final contractHTLC =
        await getDeployedContract(contractNameHTLCBase, htlcContractAddress);

    final statusResult = await web3Client!.call(
      contract: contractHTLC,
      function: contractHTLC.function('status'),
      params: [],
    );

    final BigInt status = statusResult[0];
    return status.toInt();
  }

  Future<bool?> isChargeable(String userAddress) async {
    bool _isChargeable;
    final contractHTLC =
        await getDeployedContract(contractNameHTLCBase, htlcContractAddress);

    final result = await web3Client!.call(
      contract: contractHTLC,
      function: contractHTLC.function('from'),
      params: [],
    );

    final addressFrom = (result[0] as EthereumAddress).hex;
    if (addressFrom.toUpperCase() == userAddress.toUpperCase()) {
      _isChargeable = true;
    } else {
      _isChargeable = false;
    }
    return _isChargeable;
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
          htlcContractAddress,
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
        var timeout = false;
        late StreamSubscription<FilterEvent> subscription;
        try {
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
                  '$e',
                  stackTrace: stackTrace,
                  level: aedappfm.LogLevel.error,
                  name: 'EVMHTLC - withdraw',
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
}
