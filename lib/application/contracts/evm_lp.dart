/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/models/swap.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

class EVMLP with EVMBridgeProcessMixin {
  EVMLP();

  Future<
      aedappfm.Result<({String htlcContractAddress, String txAddress}),
          aedappfm.Failure>> deployChargeableHTLC(
    WidgetRef ref,
    String poolAddress,
    String hash,
    double amount,
    int decimal,
    bool isWrapped,
  ) async {
    return aedappfm.Result.guard(() async {
      final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier)
        ..setRequestTooLong(false);

      final contractAbi = await loadAbi(
        contractNameIPool,
      );

      late String? txAddress;

      try {
        await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);

        final scaledAmount = (Decimal.parse('$amount') *
                Decimal.fromBigInt(BigInt.from(10).pow(decimal)))
            .toBigInt();

        txAddress = await writeContractWithErrorManagement(
          parameters: wagmi.WriteContractParameters.eip1559(
            abi: contractAbi,
            address: poolAddress,
            functionName: 'mintHTLC',
            args: [
              hash.toBytes,
              scaledAmount,
            ],
            //   feeValues: await FeeValuesUtils.defaultEIP1559FeeValues(chainId),
            value: isWrapped == false ? scaledAmount : null,
          ),
          fromMethod: 'EVMLP - deployChargeableHTLC',
          ref: ref,
          evmBridgeProcess: EVMBridgeProcess.bridge,
        );

        await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
        await bridgeNotifier.setWalletConfirmation(null);
      } catch (e, stackTrace) {
        if (e is TimeoutException) {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'Timeout occurred (poolAddress: $poolAddress, chainId: ${evmWalletProvider.requestedChainId}, address: ${evmWalletProvider.currentAddress})',
                level: aedappfm.LogLevel.error,
                name: 'EVMLP - deployChargeableHTLC',
              );
          throw const aedappfm.Failure.timeout();
        } else {
          if (e != const aedappfm.Failure.userRejected()) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  '$e',
                  stackTrace: stackTrace,
                  level: aedappfm.LogLevel.error,
                  name: 'EVMLP - deployChargeableHTLC',
                );
          }
        }
        rethrow;
      }

      // Get HTLC address
      final String htlcContractAddress = await readContract(
        wagmi.ReadContractParameters(
          abi: contractAbi,
          address: poolAddress,
          functionName: 'mintedSwap',
          args: [
            hash.toBytes,
          ],
        ),
      );
      return (htlcContractAddress: htlcContractAddress, txAddress: txAddress);
    });
  }

  Future<
      aedappfm.Result<({String htlcContractAddressEVM, String txAddress}),
          aedappfm.Failure>> deployAndProvisionSignedHTLC(
    WidgetRef ref,
    String poolAddress,
    String htlcContractAddressAE,
    SecretHash secretHash,
    double amount,
    int decimal,
    int endTime,
    int chainId,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier)
          ..setRequestTooLong(false);

        final bigIntValue = Decimal.parse(amount.toString()) *
            Decimal.fromBigInt(BigInt.from(10).pow(decimal));
        final ethAmount = wagmi.EtherAmount.fromBigInt(
          wagmi.EtherUnit.wei,
          bigIntValue.toBigInt(),
        );

        final contractAbi = await loadAbi(
          contractNameIPool,
        );

        late String? txAddress;
        try {
          await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
          txAddress = await writeContractWithErrorManagement(
            parameters: wagmi.WriteContractParameters.eip1559(
              abi: contractAbi,
              address: poolAddress,
              chainId: chainId,
              functionName: 'provisionHTLC',
              args: [
                secretHash.secretHash!.toBytes,
                ethAmount.getInWei,
                BigInt.from(endTime),
                htlcContractAddressAE.toBytes,
                secretHash.secretHashSignature!.r!.toBytes,
                secretHash.secretHashSignature!.s!.toBytes,
                BigInt.from(secretHash.secretHashSignature!.v!),
              ],
              //      feeValues: await FeeValuesUtils.defaultEIP1559FeeValues(chainId),
            ),
            fromMethod: 'EVMLP - deployAndProvisionSignedHTLC',
            ref: ref,
            evmBridgeProcess: EVMBridgeProcess.bridge,
          );
          await bridgeNotifier.setWalletConfirmation(null);
        } catch (e, stackTrace) {
          if (e is TimeoutException) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Timeout occurred (poolAddress: $poolAddress, chainId: $chainId, htlcContractAddressAE: $htlcContractAddressAE, address: ${evmWalletProvider.currentAddress}, amount: $amount, endTime: $endTime)',
                  level: aedappfm.LogLevel.error,
                  name: 'EVMLP - deployAndProvisionSignedHTLC',
                );
            throw const aedappfm.Failure.timeout();
          } else {
            if (e != const aedappfm.Failure.userRejected()) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    '$e',
                    stackTrace: stackTrace,
                    level: aedappfm.LogLevel.error,
                    name: 'EVMLP - deployAndProvisionSignedHTLC',
                  );
            }
          }

          rethrow;
        }

        // Get HTLC address
        final String htlcContractAddressEVM = await readContract(
          wagmi.ReadContractParameters(
            abi: contractAbi,
            address: poolAddress,
            chainId: chainId,
            functionName: 'provisionedSwap',
            args: [
              secretHash.secretHash!.toBytes,
            ],
          ),
        );

        if (htlcContractAddressEVM ==
            '0x0000000000000000000000000000000000000000') {
          throw const aedappfm.Failure.insufficientPoolFunds();
        }

        return (
          htlcContractAddressEVM: htlcContractAddressEVM,
          txAddress: txAddress
        );
      },
    );
  }

  Future<aedappfm.Result<List<Swap>, aedappfm.Failure>> getSwapsByOwner(
    String poolAddress,
    String ownerAddress,
    int chainId,
  ) async {
    return aedappfm.Result.guard(() async {
      final swapList = <Swap>[];

      final contractLP = await loadAbi(contractNameIPool);

      final resultMap = await readContract(
        wagmi.ReadContractParameters(
          abi: contractLP,
          address: poolAddress,
          chainId: chainId,
          functionName: 'getSwapsByOwner',
          args: [
            ownerAddress.toBytes,
          ],
        ),
      );

      for (final swaps in resultMap as List) {
        swapList.add(
          Swap(
            htlcContractAddressEVM: swaps['evmAddress'] ?? '',
            htlcContractAddressAE: swaps['archethicAddress'] ?? '',
            swapProcess: swaps['swapType'] == 0
                ? SwapProcess.chargeable
                : swaps['swapType'] == 1
                    ? SwapProcess.signed
                    : null,
          ),
        );
      }
      return swapList;
    });
  }
}
