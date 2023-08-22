/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/lp_erc_contract.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/model/secret.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webthree/crypto.dart';

mixin EVMBridgeProcessMixin {
  Future<String> deployEVMHTCLAndProvision(
    WidgetRef ref,
    SecretHash secretHash,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier)
      ..setCurrentStep(4);
    final lpercContract = LPERCContract(bridge.blockchainTo!.providerEndpoint);
    debugPrint(
      'bridge.blockchainTo!.providerEndpoint ${bridge.blockchainTo!.providerEndpoint}',
    );
    debugPrint(
      'bridge.tokenToBridge!.poolAddressTo: ${bridge.tokenToBridge!.poolAddressTo}',
    );
    debugPrint('bridge.blockchainTo!.chainId: ${bridge.blockchainTo!.chainId}');

    bridgeNotifier.setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final resultDeployAndProvisionSignedHTLC =
        await lpercContract.deployAndProvisionSignedHTLC(
      bridge.tokenToBridge!.poolAddressTo,
      secretHash,
      BigInt.from(bridge.tokenToBridgeAmount),
      chainId: bridge.blockchainTo!.chainId,
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);
    late String htlcAddress;
    resultDeployAndProvisionSignedHTLC.map(
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

  (Uint8List secret, Digest secretHash) generateRandomSecret() {
    final secret = Uint8List.fromList(
      List<int>.generate(
        32,
        (int i) => Random.secure().nextInt(256),
      ),
    );

    final secretHash = sha256.convert(
      secret,
    );
    return (secret, secretHash);
  }

  Future<String> deployEVMHTLC(WidgetRef ref, Digest secretHash) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier)
      ..setCurrentStep(1)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final lpercContract =
        LPERCContract(bridge.blockchainFrom!.providerEndpoint);
    final resultDeployChargeableHTLCEVM =
        await lpercContract.deployChargeableHTLC(
      bridge.tokenToBridge!.poolAddressFrom,
      secretHash.toString(),
      BigInt.from(bridge.tokenToBridgeAmount),
      chainId: bridge.blockchainFrom!.chainId,
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);
    late String htlcAddress;
    resultDeployChargeableHTLCEVM.map(
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

  Future<void> provisionEVMHTLC(WidgetRef ref, String htlcAddress) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier)
      ..setCurrentStep(2)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final lpercContract =
        LPERCContract(bridge.blockchainFrom!.providerEndpoint);
    final resultProvisionChargeableHTLC =
        await lpercContract.provisionChargeableHTLC(
      BigInt.from(bridge.tokenToBridgeAmount),
      htlcAddress,
      bridge.tokenToBridge!.tokenAddress,
      chainId: bridge.blockchainFrom!.chainId,
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);
    resultProvisionChargeableHTLC.map(
      success: (success) {},
      failure: (failure) {
        bridgeNotifier
          ..setError(Failure.getErrorMessage(failure))
          ..setTransferInProgress(false);
        return;
      },
    );
  }

  Future<void> withdrawEVM(
    WidgetRef ref,
    String htlcAddress,
    Uint8List secret,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier)
      ..setCurrentStep(4)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final lpercContract =
        LPERCContract(bridge.blockchainFrom!.providerEndpoint);

    final resultWithdraw = await lpercContract.withdraw(
      htlcAddress,
      '0x${bytesToHex(secret)}',
      chainId: bridge.blockchainFrom!.chainId,
    );
    bridgeNotifier.setWaitForWalletConfirmation(null);
    resultWithdraw.map(
      success: (success) {
        return;
      },
      failure: (failure) {
        bridgeNotifier
          ..setError(Failure.getErrorMessage(failure))
          ..setTransferInProgress(false);
        return;
      },
    );
  }

  Future<void> revealEVMSecret(
    WidgetRef ref,
    String htlcAddress,
    Uint8List secret,
  ) async {
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier)
      ..setCurrentStep(5)
      ..setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    final session = ref.read(SessionProviders.session);
    final walletTo = session.walletTo;
    final resultRevealSecretToChargeableHTLC =
        await ArchethicContract().revealSecretToChargeableHTLC(
      walletTo!.genesisAddress,
      walletTo.nameAccount,
      htlcAddress,
      bytesToHex(secret),
    );
    bridgeNotifier
      ..setWaitForWalletConfirmation(null)
      ..setTransferInProgress(false);
    resultRevealSecretToChargeableHTLC.map(
      success: (success) {
        bridgeNotifier.setCurrentStep(6);
        return;
      },
      failure: (failure) {
        bridgeNotifier.setError(Failure.getErrorMessage(failure));
        return;
      },
    );
  }
}
