/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/lp_erc_contract.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/model/secret.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/util/date_util.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ArchethicBridgeProcessMixin {
  String getAEStepLabel(
    BuildContext context,
    int step,
  ) {
    switch (step) {
      case 1:
        return AppLocalizations.of(context)!.aeBridgeProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.aeBridgeProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.aeBridgeProcessStep3;
      case 4:
        return AppLocalizations.of(context)!.aeBridgeProcessStep4;
      case 5:
        return AppLocalizations.of(context)!.aeBridgeProcessStep5;
      case 6:
        return AppLocalizations.of(context)!.aeBridgeProcessStep6;
      case 7:
        return AppLocalizations.of(context)!.aeBridgeProcessStep7;
      default:
        return AppLocalizations.of(context)!.aeBridgeProcessStep0;
    }
  }

  Future<String> deployAESignedHTLC(WidgetRef ref) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(1);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);

    var endTime =
        DateTime.now().add(const Duration(minutes: 720)).millisecondsSinceEpoch;
    endTime = DateUtil().roundToNearestMinute(endTime) ~/ 1000;

    final session = ref.read(SessionProviders.session);
    final walletFrom = session.walletFrom;

    late String archethicHTLCAddress;
    final resultDeploySignedHTLC = await ArchethicContract().deploySignedHTLC(
      bridge.blockchainFrom!.archethicFactoryAddress!,
      bridge.tokenToBridge!.poolAddressFrom,
      walletFrom!.genesisAddress,
      endTime,
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridge!.tokenAddress,
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    await resultDeploySignedHTLC.map(
      success: (success) {
        archethicHTLCAddress = success;
        debugPrint('htlc: $archethicHTLCAddress');
      },
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
    return archethicHTLCAddress;
  }

  Future<String> deployAEChargeableHTLC(
    WidgetRef ref,
    Digest secretHash,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(3);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    var endTime =
        DateTime.now().add(const Duration(minutes: 720)).millisecondsSinceEpoch;
    endTime = DateUtil().roundToNearestMinute(endTime) ~/ 1000;

    late String htlcAddress;
    final resultDeployChargeableHTLCAE =
        await ArchethicContract().deployChargeableHTLC(
      bridge.blockchainTo!.archethicFactoryAddress!,
      bridge.tokenToBridge!.poolAddressTo,
      bridge.targetAddress,
      endTime,
      bridge.tokenToBridgeAmount,
      '',
      archethic.uint8ListToHex(
        Uint8List.fromList(secretHash.bytes),
      ),
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    await resultDeployChargeableHTLCAE.map(
      success: (success) {
        htlcAddress = success;
      },
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
    return htlcAddress;
  }

  Future<String> provisionAEHTLC(
    WidgetRef ref,
    String archethicHTLCAddress,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(2);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    late String txAddress;
    final resultProvisionSignedHTLC =
        await ArchethicContract().provisionSignedHTLC(
      archethicHTLCAddress,
      bridge.tokenToBridgeAmount,
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    await resultProvisionSignedHTLC.map(
      success: (success) {
        txAddress = success;
      },
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
    return txAddress;
  }

  Future<SecretHash> getAESecretHash(
    WidgetRef ref,
    String archethicHTLCAddress,
  ) async {
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(3);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
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
    await bridgeNotifier.setWaitForWalletConfirmation(null);
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
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(5);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    final session = ref.read(SessionProviders.session);
    final walletFrom = session.walletFrom;

    final resultRequestSecretFromSignedHTLC =
        await ArchethicContract().requestSecretFromSignedHTLC(
      walletFrom!.nameAccount,
      htlcAddress,
      bridge.tokenToBridge!.poolAddressFrom,
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    await resultRequestSecretFromSignedHTLC.map(
      success: (success) {},
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
  }

  Future<Secret> revealAESecret(WidgetRef ref, String htlcAddress) async {
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(6);
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
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(7);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final lpercContract = LPERCContract(bridge.blockchainTo!.providerEndpoint);
    final resultSignedWithdraw = await lpercContract.signedWithdraw(
      htlc,
      secret,
      chainId: bridge.blockchainFrom!.chainId,
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    late String txAddress;
    await resultSignedWithdraw.map(
      success: (success) async {
        await bridgeNotifier.setCurrentStep(8);
        await bridgeNotifier.setWaitForWalletConfirmation(null);
        await bridgeNotifier.setTransferInProgress(false);
        txAddress = success;
      },
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
    return txAddress;
  }
}
