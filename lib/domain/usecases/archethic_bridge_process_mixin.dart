/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ArchethicBridgeProcessMixin {
  Future<String> deployAESignedHTLC(WidgetRef ref) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier)
      ..setCurrentStep(1)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);

    var endTime =
        DateTime.now().add(const Duration(minutes: 720)).millisecondsSinceEpoch;
    endTime = DateUtil().roundToNearestMinute(endTime) ~/ 1000;

    final session = ref.read(SessionProviders.session);
    final walletFrom = session.walletFrom;

    late String archethicHTLCAddress;
    final resultDeploySignedHTLC = await ArchethicContract().deploySignedHTLC(
      bridge.tokenToBridge!.poolAddressFrom,
      walletFrom!.genesisAddress,
      endTime,
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridge!.tokenAddress,
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);
    resultDeploySignedHTLC.map(
      success: (success) {
        archethicHTLCAddress = success;
        debugPrint('htlc: $archethicHTLCAddress');
      },
      failure: (failure) {
        bridgeNotifier
          ..setError(Failure.getErrorMessage(failure))
          ..setTransferInProgress(false);
        return;
      },
    );
    return archethicHTLCAddress;
  }

  Future<String> deployAEChargeableHTLC(
    WidgetRef ref,
    Digest secretHash,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier)
      ..setCurrentStep(3)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    var endTime =
        DateTime.now().add(const Duration(minutes: 720)).millisecondsSinceEpoch;
    endTime = DateUtil().roundToNearestMinute(endTime) ~/ 1000;

    late String htlcAddress;
    final resultDeployChargeableHTLCAE =
        await ArchethicContract().deployChargeableHTLC(
      bridge.tokenToBridge!.poolAddressTo,
      bridge.targetAddress,
      endTime,
      bridge.tokenToBridgeAmount,
      '',
      archethic.uint8ListToHex(
        Uint8List.fromList(secretHash.bytes),
      ),
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);
    resultDeployChargeableHTLCAE.map(
      success: (success) {
        htlcAddress = success;
      },
      failure: (failure) {
        bridgeNotifier
          ..setError(Failure.getErrorMessage(failure))
          ..setTransferInProgress(false);
        return;
      },
    );
    return htlcAddress;
  }

  Future<String> provisionAEHTLC(
    WidgetRef ref,
    String archethicHTLCAddress,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier)
      ..setCurrentStep(2)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    late String txAddress;
    final resultProvisionSignedHTLC =
        await ArchethicContract().provisionSignedHTLC(
      archethicHTLCAddress,
      bridge.tokenToBridgeAmount,
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);
    resultProvisionSignedHTLC.map(
      success: (success) {
        txAddress = success;
      },
      failure: (failure) {
        bridgeNotifier
          ..setError(Failure.getErrorMessage(failure))
          ..setTransferInProgress(false);
        return;
      },
    );
    return txAddress;
  }

  Future<SecretHash> getAESecretHash(
    WidgetRef ref,
    String archethicHTLCAddress,
  ) async {
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier)
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
    return SecretHash(
      secretHash: secretHashMap['secret_hash'],
      secretHashSignature: SecretHashSignature(
        r: secretHashMap['secret_hash_signature']['r'],
        s: secretHashMap['secret_hash_signature']['s'],
        v: secretHashMap['secret_hash_signature']['v'],
      ),
    );
  }

  Future<void> requestAESecretFromLP(WidgetRef ref, String htlcAddress) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier)
      ..setCurrentStep(5)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    final session = ref.read(SessionProviders.session);
    final walletFrom = session.walletFrom;

    final resultRequestSecretFromSignedHTLC =
        await ArchethicContract().requestSecretFromSignedHTLC(
      walletFrom!.nameAccount,
      htlcAddress,
      bridge.tokenToBridge!.poolAddressFrom,
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);
    resultRequestSecretFromSignedHTLC.map(
      success: (success) {},
      failure: (failure) {
        bridgeNotifier
          ..setError(Failure.getErrorMessage(failure))
          ..setTransferInProgress(false);
        return;
      },
    );
  }

  Future<Secret> revealAESecret(WidgetRef ref, String htlcAddress) async {
    ref.read(BridgeFormProvider.bridgeForm.notifier).setCurrentStep(6);
    final secretFromFct = await sl.get<archethic.ApiService>().callSCFunction(
          jsonRPCRequest: archethic.SCCallFunctionRequest(
            method: 'contract_fun',
            params: archethic.SCCallFunctionParams(
              contract: htlcAddress,
              function: 'get_secret',
              args: [],
            ),
          ),
        );
    debugPrint('secret: $secretFromFct');
    final secretMap = jsonDecode(secretFromFct);
    debugPrint(
      'secret without archethic prefix ${secretMap["secret"]}',
    );
    return Secret(
      secret: '0x${secretMap['secret']}',
      secretSignature: SecretSignature(
        r: '0x${secretMap["secret_signature"]["r"]}',
        s: '0x${secretMap["secret_signature"]["s"]}',
        v: secretMap['secret_signature']['v'],
      ),
    );
  }

  Future<String> withdrawAE(WidgetRef ref, String htlc, Secret secret) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier)
      ..setCurrentStep(7)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final lpercContract = LPERCContract(bridge.blockchainTo!.providerEndpoint);
    final resultSignedWithdraw = await lpercContract.signedWithdraw(
      htlc,
      secret,
      chainId: bridge.blockchainFrom!.chainId,
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);
    late String txAddress;
    resultSignedWithdraw.map(
      success: (success) {
        bridgeNotifier
          ..setCurrentStep(8)
          ..setWaitForWalletConfirmation(null)
          ..setTransferInProgress(false);
        txAddress = success;
      },
      failure: (failure) {
        bridgeNotifier
          ..setError(Failure.getErrorMessage(failure))
          ..setTransferInProgress(false);
        return;
      },
    );
    return txAddress;
  }
}
