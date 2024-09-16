import 'dart:async';

import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;
import 'package:webthree/webthree.dart';

class EVMHTLCNative with EVMBridgeProcessMixin {
  EVMHTLCNative(
    this.providerEndpoint,
    this.htlcContractAddress,
    this.chainId,
  ) {
    web3Client = Web3Client(
      providerEndpoint,
      Client(),
      customFilterPingInterval: Duration(
        // Ethereum is too long to validate a txn...
        seconds: chainId == 1 ? 20 : 5,
      ),
    );
  }
  final String providerEndpoint;
  final String htlcContractAddress;
  late final Web3Client web3Client;
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
            ),
            fromMethod: 'EVMHTLCNative - signedWithdraw',
            ref: ref,
            evmBridgeProcess: EVMBridgeProcess.bridge,
            chainId: chainId,
            web3Client: web3Client,
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
