/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';

import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/lp_erc_contract.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/model/secret.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/util/date_util.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeArchethicToEVMUseCase {
  Future<void> run(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    final session = ref.read(SessionProviders.session);
    final walletFrom = session.walletFrom;

    // 1) Deploy Archethic HTLC Contract
    bridgeNotifier.setCurrentStep(1);
    var endTime =
        DateTime.now().add(const Duration(minutes: 720)).millisecondsSinceEpoch;
    endTime = DateUtil().roundToNearestMinute(endTime) ~/ 1000;

    bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    final archethicHTLCAddress = await ArchethicContract().deploySignedHTLC(
      bridge.tokenToBridge!.poolAddressFrom,
      walletFrom!.genesisAddress,
      endTime,
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridge!.tokenAddress,
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);

    debugPrint('htlc contract: $archethicHTLCAddress');

    // 2) Provision Archethic HTLC Contract
    bridgeNotifier
      ..setCurrentStep(2)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    await ArchethicContract().provisionSignedHTLC(
      archethicHTLCAddress!,
      bridge.tokenToBridgeAmount,
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);

    // 3) Get Secret Hash from API

    // ignore: cascade_invocations
    bridgeNotifier
      ..setCurrentStep(3)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    final secretHashFromFct =
        await sl.get<archethic.ApiService>().callSCFunction(
              jsonRPCRequest: archethic.SCCallFunctionRequest(
                method: 'contract_fun',
                params: archethic.SCCallFunctionParams(
                  contract: archethicHTLCAddress,
                  function: 'get_secret_hash',
                  args: [],
                ),
              ),
            );
    bridgeNotifier.setWaitForWalletConfirmation(null);
    debugPrint('secretHashFromFct: $secretHashFromFct');
    final secretHashMap = jsonDecode(secretHashFromFct);
    final secretHash = SecretHash(
      secretHash: secretHashMap['secret_hash'],
      secretHashSignature: SecretHashSignature(
        r: secretHashMap['secret_hash_signature']['r'],
        s: secretHashMap['secret_hash_signature']['s'],
        v: secretHashMap['secret_hash_signature']['v'],
      ),
    );

    // 4) Deploy EVM HTLC Contract + Provision
    bridgeNotifier.setCurrentStep(4);
    final lpercContract = LPERCContract(bridge.blockchainTo!.providerEndpoint);
    debugPrint(
      'bridge.blockchainTo!.providerEndpoint ${bridge.blockchainTo!.providerEndpoint}',
    );
    debugPrint(
      'bridge.tokenToBridge!.poolAddressTo: ${bridge.tokenToBridge!.poolAddressTo}',
    );
    debugPrint('bridge.blockchainTo!.chainId: ${bridge.blockchainTo!.chainId}');

    bridgeNotifier.setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    late String htlcEVMContract;
    final resultDeployAndProvision =
        await lpercContract.deployAndProvisionSignedHTLC(
      bridge.tokenToBridge!.poolAddressTo,
      secretHash,
      BigInt.from(bridge.tokenToBridgeAmount),
      chainId: bridge.blockchainTo!.chainId,
    );
    resultDeployAndProvision.map(
      success: (success) {
        htlcEVMContract = success;
      },
      failure: (failure) {
        bridgeNotifier
          ..setError(Failure.getErrorMessage(failure))
          ..setTransferInProgress(false);
        return;
      },
    );

    bridgeNotifier.setWaitForWalletConfirmation(null);

    // 5) Request Secret from Archethic LP
    // ignore: cascade_invocations
    bridgeNotifier
      ..setCurrentStep(5)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    await ArchethicContract().requestSecretFromSignedHTLC(
      walletFrom.nameAccount,
      archethicHTLCAddress,
      bridge.tokenToBridge!.poolAddressFrom,
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);

    // 6) Reveal Secret
    // ignore: cascade_invocations
    bridgeNotifier.setCurrentStep(6);
    final secretFromFct = await sl.get<archethic.ApiService>().callSCFunction(
          jsonRPCRequest: archethic.SCCallFunctionRequest(
            method: 'contract_fun',
            params: archethic.SCCallFunctionParams(
              contract: archethicHTLCAddress,
              function: 'get_secret',
              args: [],
            ),
          ),
        );
    debugPrint('secret: $secretFromFct');
    final secretMap = jsonDecode(secretFromFct);
    debugPrint(
      'secret without archethic prefix ${secretMap["secret"].toString().substring(4)}',
    );
    final secret = Secret(
      secret: '0x${secretMap['secret'].toString().substring(4)}',
      secretSignature: SecretSignature(
        r: '0x${secretMap["secret_signature"]["r"]}',
        s: '0x${secretMap["secret_signature"]["s"]}',
        v: secretMap['secret_signature']['v'],
      ),
    );

    // 7) Reveal Secret EVM (Withdraw)
    bridgeNotifier
      ..setCurrentStep(7)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final resultWithdraw = await lpercContract.signedWithdraw(
      htlcEVMContract,
      secret,
      chainId: bridge.blockchainFrom!.chainId,
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);
    resultWithdraw.map(
      success: (success) {
        htlcEVMContract = success;
        bridgeNotifier
          ..setCurrentStep(8)
          ..setWaitForWalletConfirmation(null)
          ..setTransferInProgress(false);
      },
      failure: (failure) {
        bridgeNotifier
          ..setError(Failure.getErrorMessage(failure))
          ..setTransferInProgress(false);
        return;
      },
    );
  }
}
