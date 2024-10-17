/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/bridge_ae_process_mixin.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

class EVMHTLC with EVMBridgeProcessMixin, ArchethicBridgeProcessMixin {
  EVMHTLC(
    this.htlcContractAddressEVM,
  );

  final String htlcContractAddressEVM;

  Future<aedappfm.Result<String, aedappfm.Failure>> refund(
    WidgetRef ref,
    bool isERC20,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final refundNotifier = ref.read(RefundFormProvider.refundForm.notifier)
          ..setRequestTooLong(false);

        final contractAbi = await loadAbi(
          isERC20
              ? contractNameChargeableHTLCERC
              : contractNameChargeableHTLCETH,
        );

        late String? refundTx;

        try {
          refundNotifier.setWalletConfirmation(WalletConfirmationRefund.evm);
          refundTx = await writeContractWithErrorManagement(
            parameters: wagmi.WriteContractParameters.eip1559(
              abi: contractAbi,
              address: htlcContractAddressEVM,
              functionName: 'refund',
              //    feeValues: await FeeValuesUtils.defaultEIP1559FeeValues(chainId),
            ),
            fromMethod: 'EVMHTLC - refund',
            ref: ref,
            evmBridgeProcess: EVMBridgeProcess.refund,
          );

          refundNotifier.setWalletConfirmation(null);
        } catch (e, stackTrace) {
          if (e is TimeoutException) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Timeout occurred (htlcContractAddressEVM: $htlcContractAddressEVM, chainId: ${evmWalletProvider.requestedChainId})',
                  level: aedappfm.LogLevel.error,
                  name: 'EVMHTLC - refund',
                );
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
          dateLockTime: await _getLockTime(),
          canRefund: await _isCanRefund(),
        );
      },
    );
  }

  Future<aedappfm.Result<int, aedappfm.Failure>> getHTLCLockTime() async {
    return aedappfm.Result.guard(
      () async {
        return _getLockTime();
      },
    );
  }

  Future<int> _getLockTime() async {
    final abi = await loadAbi(contractNameHTLCBase);
    final params = wagmi.ReadContractParameters(
      abi: abi,
      address: htlcContractAddressEVM,
      functionName: 'lockTime',
      args: [],
    );
    final response = await readContract(
      params,
    );
    final BigInt lockTime = response;

    return lockTime.toInt();
  }

  Future<aedappfm.Result<double, aedappfm.Failure>> getAmount(
    int decimal,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final abi = await loadAbi(contractNameHTLCBase);

        final params = wagmi.ReadContractParameters(
          abi: abi,
          address: htlcContractAddressEVM,
          functionName: 'amount',
          args: [],
        );
        final response = await readContract(
          params,
        );
        final BigInt amount = response;
        final convertedAmount = (Decimal.parse('$amount') /
                Decimal.fromBigInt(BigInt.from(10).pow(decimal)))
            .toDouble();
        return convertedAmount;
      },
    );
  }

  Future<
      aedappfm.Result<({String symbol, bool isERC20, String? tokenAddress}),
          aedappfm.Failure>> getSymbol(
    String nativeCurrency,
  ) async {
    return aedappfm.Result.guard(() async {
      var _isERC20 = false;
      var currency = nativeCurrency;
      String? tokenAddress;
      try {
        final abi = await loadAbi(contractNameHTLCERC);
        final params = wagmi.ReadContractParameters(
          abi: abi,
          address: htlcContractAddressEVM,
          functionName: 'token',
          args: [],
        );
        tokenAddress = await readContract(
          params,
        );
        if (tokenAddress != null && tokenAddress.isNotEmpty) {
          final token = await getToken(
            address: tokenAddress,
          );

          final symbol = token.symbol ?? '';

          if (symbol.isNotEmpty) {
            currency = symbol;
            _isERC20 = true;
          }
        }
      } catch (e) {
        return (symbol: currency, isERC20: false, tokenAddress: tokenAddress);
      }

      return (symbol: currency, isERC20: _isERC20, tokenAddress: tokenAddress);
    });
  }

  Future<bool> _isCanRefund() async {
    final abi = await loadAbi(contractNameHTLCBase);
    final params = wagmi.ReadContractParameters(
      abi: abi,
      address: htlcContractAddressEVM,
      functionName: 'canRefund',
      args: [
        BigInt.from(DateTime.now().millisecondsSinceEpoch ~/ 1000),
      ],
    );
    final response = await readContract(
      params,
    );
    final bool canRefund = response;
    return canRefund;
  }

  Future<int> getStatus({int? chainId}) async {
    final abi = await loadAbi(contractNameHTLCBase);

    if (chainId == null) {
      return await readContract(
        wagmi.ReadContractParameters(
          abi: abi,
          address: htlcContractAddressEVM,
          functionName: 'status',
          args: [],
        ),
      );
    }

    return await wagmi.Core.readContract(
      wagmi.ReadContractParameters(
        abi: abi,
        address: htlcContractAddressEVM,
        functionName: 'status',
        args: [],
        chainId: chainId,
      ),
    );
  }

  Future<aedappfm.Result<String, aedappfm.Failure>> withdraw(
    WidgetRef ref,
    String secret,
    String contract,
    SecretSignature signatureAEHTLC,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier)
          ..setRequestTooLong(false);
        final contractAbi = await loadAbi(
          contract,
        );

        late String? withdrawTx;

        try {
          await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);

          withdrawTx = await writeContractWithErrorManagement(
            parameters: wagmi.WriteContractParametersEIP1559(
              abi: contractAbi,
              address: htlcContractAddressEVM,
              functionName: 'withdraw',
              args: [
                secret.toBytes,
                signatureAEHTLC.r!.toBytes,
                signatureAEHTLC.s!.toBytes,
                BigInt.from(signatureAEHTLC.v!),
              ],
              //    feeValues: await FeeValuesUtils.defaultEIP1559FeeValues(chainId),
            ),
            fromMethod: 'EVMHTLC - withdraw',
            ref: ref,
            evmBridgeProcess: EVMBridgeProcess.bridge,
          );

          await bridgeNotifier.setWalletConfirmation(null);
        } catch (e, stackTrace) {
          if (e is TimeoutException) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Timeout occurred (htlcContractAddressEVM: $htlcContractAddressEVM, chainId: ${evmWalletProvider.requestedChainId})',
                  level: aedappfm.LogLevel.error,
                  name: 'EVMHTLC - withdraw',
                );
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
          rethrow;
        }
        return withdrawTx;
      },
    );
  }
}
