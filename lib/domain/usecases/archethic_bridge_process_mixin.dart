/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:typed_data';
import 'package:aebridge/application/contracts/archethic_contract_chargeable.dart';
import 'package:aebridge/application/contracts/archethic_contract_signed.dart';
import 'package:aebridge/application/contracts/evm_lp_erc.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
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

  Future<String> deployAESignedHTLC(
    WidgetRef ref,
    String htlcAEAddress,
    String seedHTLC,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(1);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);

    final session = ref.read(SessionProviders.session);
    final walletFrom = session.walletFrom;

    late String archethicHTLCAddress;
    final resultDeploySignedHTLC =
        await ArchethicContractSigned().deploySignedHTLC(
      htlcAEAddress,
      seedHTLC,
      bridge.blockchainFrom!.archethicFactoryAddress!,
      bridge.tokenToBridge!.poolAddressFrom,
      walletFrom!.genesisAddress,
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridge!.tokenAddressSource,
      bridge.blockchainTo!.chainId,
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
    double amount,
    int endTime,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(3);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);

    late String htlcAddress;
    final resultDeployChargeableHTLCAE =
        await ArchethicContractChargeable().deployChargeableHTLC(
      bridge.blockchainTo!.archethicFactoryAddress!,
      bridge.tokenToBridge!.poolAddressTo,
      bridge.targetAddress,
      endTime,
      amount,
      bridge.tokenToBridge!.tokenAddressTarget,
      archethic.uint8ListToHex(
        Uint8List.fromList(secretHash.bytes),
      ),
      bridge.blockchainFrom!.chainId,
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

  Future<void> provisionAEHTLC(
    WidgetRef ref,
    String htlcGenesisAddress,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(2);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);

    final session = ref.read(SessionProviders.session);
    final walletFrom = session.walletFrom;

    final resultProvisionSignedHTLC =
        await ArchethicContractSigned().provisionSignedHTLC(
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridge!.tokenAddressSource,
      bridge.tokenToBridge!.poolAddressFrom,
      htlcGenesisAddress,
      walletFrom!.genesisAddress,
      bridge.blockchainTo!.chainId,
    );

    await bridgeNotifier.setWaitForWalletConfirmation(null);
    await resultProvisionSignedHTLC.map(
      success: (success) {},
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
    return;
  }

  Future<({SecretHash secretHash, int endTime})> getAESecretHash(
    WidgetRef ref,
    String archethicHTLCAddress,
  ) async {
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(3);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    final secretHashMap = await sl.get<archethic.ApiService>().callSCFunction(
          jsonRPCRequest: archethic.SCCallFunctionRequest(
            method: 'contract_fun',
            params: archethic.SCCallFunctionParams(
              contract: archethicHTLCAddress,
              function: 'get_htlc_data',
              args: [],
            ),
          ),
          resultMap: true,
        ) as Map<String, dynamic>;
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    debugPrint('secretHashMap: $secretHashMap');
    return (
      secretHash: SecretHash(
        secretHash: secretHashMap['secret_hash'],
        secretHashSignature: SecretHashSignature(
          r: secretHashMap['secret_hash_signature']['r'],
          s: secretHashMap['secret_hash_signature']['s'],
          v: secretHashMap['secret_hash_signature']['v'],
        ),
      ),
      endTime: secretHashMap['end_time'] as int,
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
        await ArchethicContractSigned().requestSecretFromSignedHTLC(
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
    final secretMap = await sl.get<archethic.ApiService>().callSCFunction(
          jsonRPCRequest: archethic.SCCallFunctionRequest(
            method: 'contract_fun',
            params: archethic.SCCallFunctionParams(
              contract: htlcAddress,
              function: 'get_secret',
              args: [],
            ),
          ),
          resultMap: true,
        ) as Map<String, dynamic>;
    debugPrint('secret: $secretMap');
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
    final evmLPERC = EVMLPERC(
      bridge.blockchainTo!.providerEndpoint,
      htlc,
      bridge.blockchainFrom!.chainId,
    );
    final resultSignedWithdraw = await evmLPERC.signedWithdraw(
      secret,
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
