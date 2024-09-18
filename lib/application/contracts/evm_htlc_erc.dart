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
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

class EVMHTLCERC with EVMBridgeProcessMixin {
  EVMHTLCERC(
    this.htlcContractAddress,
    this.chainId,
  );
  final String htlcContractAddress;
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
        ref.read(bridgeFormNotifierProvider.notifier).setRequestTooLong(false);

        final tokenUnits = (Decimal.parse('$amount') *
                Decimal.fromBigInt(BigInt.from(10).pow(decimal)))
            .toBigInt();

        final contractAbi = await loadAbi(
          contractNameIERC20,
        );

        try {
          final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);

          await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);

          await writeContractWithErrorManagement(
            parameters: wagmi.WriteContractParameters.eip1559(
              abi: contractAbi,
              address: tokenAddress,
              functionName: 'approve',
              chainId: chainId,
              args: [
                poolAddress,
                tokenUnits,
              ],
              feeValues: await FeeValuesUtils.defaultEIP1559FeeValues(chainId),
            ),
            fromMethod: 'EVMHTLCERC - approveChargeableHTLC',
            ref: ref,
            evmBridgeProcess: EVMBridgeProcess.bridge,
            chainId: chainId,
          );
          await bridgeNotifier.setWalletConfirmation(null);
        } catch (e, stackTrace) {
          if (e is TimeoutException) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Timeout occurred (htlcContractAddress: $htlcContractAddress, chainId: $chainId, userAddress: $userAddress, poolAddress: $poolAddress, tokenAddress: $tokenAddress, amount: $amount)',
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
        final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier)
          ..setRequestTooLong(false);
        late String? withdrawTx;

        try {
          await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);

          final contractAbi = await loadAbi(
            contractNameSignedHTLCERC,
          );

          withdrawTx = await writeContractWithErrorManagement(
            parameters: wagmi.WriteContractParameters.eip1559(
              abi: contractAbi,
              address: htlcContractAddress,
              functionName: 'withdraw',
              chainId: chainId,
              args: [
                secret.secret!.toBytes,
                secret.secretSignature!.r!.toBytes,
                secret.secretSignature!.s!.toBytes,
                BigInt.from(secret.secretSignature!.v!),
              ],
              feeValues: await FeeValuesUtils.defaultEIP1559FeeValues(chainId),
            ),
            fromMethod: 'EVMHTLCERC - signedWithdraw',
            ref: ref,
            evmBridgeProcess: EVMBridgeProcess.bridge,
            chainId: chainId,
          );

          await bridgeNotifier.setWalletConfirmation(null);
        } catch (e, stackTrace) {
          if (e is TimeoutException) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Timeout occurred (htlcContractAddress: $htlcContractAddress, chainId: $chainId)',
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
        }
        return withdrawTx;
      },
    );
  }

  Future<aedappfm.Result<int, aedappfm.Failure>> getTokenNbOfDecimal(
    String tokenAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final contractHTLC = await loadAbi(contractNameIERC20);

        final decimalsMap = await wagmi.Core.readContract(
          aedappfm.sl.get<EVMWalletProvider>().wagmiConfig!,
          wagmi.ReadContractParameters(
            abi: contractHTLC,
            address: tokenAddress,
            functionName: 'decimals',
          ),
        );

        final int decimals = decimalsMap[0].toInt();
        return decimals;
      },
    );
  }
}
