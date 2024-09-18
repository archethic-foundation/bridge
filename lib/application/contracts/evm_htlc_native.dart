import 'dart:async';

import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

class EVMHTLCNative with EVMBridgeProcessMixin {
  EVMHTLCNative(
    this.htlcContractAddress,
    this.chainId,
  );

  final String htlcContractAddress;
  final int chainId;

  Future<aedappfm.Result<String, aedappfm.Failure>> signedWithdraw(
    WidgetRef ref,
    Secret secret,
  ) async {
    return aedappfm.Result.guard(
      () async {
        ref.read(bridgeFormNotifierProvider.notifier).setRequestTooLong(false);

        final contractAbi = await loadAbi(
          contractNameSignedHTLCETH,
        );

        late String? withdrawTx;
        try {
          final latestBlockNumber = await wagmi.Core.getBlockNumber(
            aedappfm.sl.get<EVMWalletProvider>().wagmiConfig!,
            wagmi.GetBlockNumberParameters(),
          );
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'latestBlockNumber: $latestBlockNumber',
                name: 'EVMHTLCNative - signedWithdraw',
              );

          final bridgeNotifier = ref.read(
            bridgeFormNotifierProvider.notifier,
          );
          await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
          withdrawTx = await writeContractWithErrorManagement(
            parameters: wagmi.WriteContractParameters.eip1559(
              abi: contractAbi,
              address: htlcContractAddress,
              chainId: chainId,
              functionName: 'withdraw',
              args: [
                secret.secret!.toBytes,
                secret.secretSignature!.r!.toBytes,
                secret.secretSignature!.s!.toBytes,
                BigInt.from(secret.secretSignature!.v!),
              ],
              feeValues: await FeeValuesUtils.defaultEIP1559FeeValues(chainId),
            ),
            fromMethod: 'EVMHTLCNative - signedWithdraw',
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
        }
        return withdrawTx;
      },
    );
  }

  Future<aedappfm.Result<double, aedappfm.Failure>> getFee() async {
    return aedappfm.Result.guard(
      () async {
        try {
          final abi = await loadAbi(contractNameChargeableHTLCETH);
          final params = wagmi.ReadContractParameters(
            abi: abi,
            address: htlcContractAddress,
            functionName: 'fee',
            args: [],
          );
          final response = await wagmi.Core.readContract(
            aedappfm.sl.get<EVMWalletProvider>().wagmiConfig!,
            params,
          );

          final BigInt fee = response;
          final etherAmount =
              wagmi.EtherAmount.fromBigInt(wagmi.EtherUnit.wei, fee);
          return etherAmount.getValueInUnit(wagmi.EtherUnit.ether);
        } catch (e) {
          return 0.0;
        }
      },
    );
  }
}
