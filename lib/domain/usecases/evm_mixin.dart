/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
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
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/json_rpc.dart';
import 'package:webthree/webthree.dart';

enum EVMBridgeProcessStep { none, deploy }

mixin EVMBridgeProcessMixin {
  String getEVMStepLabel(
    BuildContext context,
    int step,
  ) {
    switch (step) {
      case 1:
        return AppLocalizations.of(context)!.evmBridgeProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.evmBridgeProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.evmBridgeProcessStep3;
      case 4:
        return AppLocalizations.of(context)!.evmBridgeProcessStep4;
      case 5:
        return AppLocalizations.of(context)!.evmBridgeProcessStep5;
      case 6:
        return AppLocalizations.of(context)!.evmBridgeProcessStep6;
      default:
        return AppLocalizations.of(context)!.evmBridgeProcessStep0;
    }
  }

  Future<String> deployEVMHTCLAndProvision(
    WidgetRef ref,
    SecretHash secretHash,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(4);
    final lpercContract = LPERCContract(bridge.blockchainTo!.providerEndpoint);
    debugPrint(
      'bridge.blockchainTo!.providerEndpoint ${bridge.blockchainTo!.providerEndpoint}',
    );
    debugPrint(
      'bridge.tokenToBridge!.poolAddressTo: ${bridge.tokenToBridge!.poolAddressTo}',
    );
    debugPrint('bridge.blockchainTo!.chainId: ${bridge.blockchainTo!.chainId}');

    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final resultDeployAndProvisionSignedHTLC =
        await lpercContract.deployAndProvisionSignedHTLC(
      bridge.tokenToBridge!.poolAddressTo,
      secretHash,
      BigInt.from(bridge.tokenToBridgeAmount),
      chainId: bridge.blockchainTo!.chainId,
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    late String htlcAddress;
    await resultDeployAndProvisionSignedHTLC.map(
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

  Uint8List generateRandomSecret() {
    final secret = Uint8List.fromList(
      List<int>.generate(
        32,
        (int i) => Random.secure().nextInt(256),
      ),
    );
    return secret;
  }

  Future<String> deployEVMHTLC(WidgetRef ref, Digest secretHash) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(1);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final lpercContract =
        LPERCContract(bridge.blockchainFrom!.providerEndpoint);
    final resultDeployChargeableHTLCEVM =
        await lpercContract.deployChargeableHTLC(
      bridge.tokenToBridge!.poolAddressFrom,
      secretHash.toString(),
      BigInt.from(bridge.tokenToBridgeAmount),
      chainId: bridge.blockchainFrom!.chainId,
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    late String htlcAddress;
    await resultDeployChargeableHTLCEVM.map(
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

  Future<void> provisionEVMHTLC(WidgetRef ref, String htlcAddress) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(2);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final lpercContract =
        LPERCContract(bridge.blockchainFrom!.providerEndpoint);
    final resultProvisionChargeableHTLC =
        await lpercContract.provisionChargeableHTLC(
      BigInt.from(bridge.tokenToBridgeAmount),
      htlcAddress,
      bridge.tokenToBridge!.tokenAddress,
      chainId: bridge.blockchainFrom!.chainId,
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    await resultProvisionChargeableHTLC.map(
      success: (success) {},
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
  }

  Future<void> withdrawEVM(
    WidgetRef ref,
    String htlcAddress,
    Uint8List secret,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(4);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final lpercContract =
        LPERCContract(bridge.blockchainFrom!.providerEndpoint);

    final resultWithdraw = await lpercContract.withdraw(
      htlcAddress,
      '0x${bytesToHex(secret)}',
      chainId: bridge.blockchainFrom!.chainId,
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    await resultWithdraw.map(
      success: (success) {
        return;
      },
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
  }

  Future<void> revealEVMSecret(
    WidgetRef ref,
    String htlcAddress,
    Uint8List secret,
  ) async {
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(5);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    final session = ref.read(SessionProviders.session);
    final walletTo = session.walletTo;
    final resultRevealSecretToChargeableHTLC =
        await ArchethicContract().revealSecretToChargeableHTLC(
      walletTo!.genesisAddress,
      walletTo.nameAccount,
      htlcAddress,
      bytesToHex(secret),
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    await bridgeNotifier.setTransferInProgress(false);
    await resultRevealSecretToChargeableHTLC.map(
      success: (success) async {
        await bridgeNotifier.setCurrentStep(6);
        return;
      },
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        throw failure;
      },
    );
  }

  Future<String> sendTransactionWithErrorManagement(
    Web3Client web3Client,
    CredentialsWithKnownAddress credentials,
    Transaction transaction,
    int chainId,
  ) async {
    try {
      return await web3Client.sendTransaction(
        credentials,
        transaction,
        chainId: chainId,
      );
    } catch (e) {
      debugPrint('error provisionChargeableHTLC $e');

      if (e is EthereumUserRejected) {
        throw const Failure.userRejected();
      }
      if (e is EthereumException) {
        throw Failure.other(cause: e.data, stack: e.message);
      }
      if (e is EthersException) {
        throw Failure.other(cause: e.rawError, stack: e.reason);
      }
      if (e is RPCError) {
        const encoder = JsonEncoder.withIndent('  ');
        final validJson = encoder.convert(e.data);
        final Map<String, dynamic> jsonMap = json.decode(validJson);
        final rpcErrorEVMData =
            RPCErrorEVMData.fromJson(jsonMap.entries.first.value);

        // Utiliser cette instance pour créer une instance de Failure.rpcErrorEVM
        throw Failure.rpcErrorEVM(data: {'Some_Key': rpcErrorEVMData});
      }
      throw Failure.other(cause: e.toString());
    }
  }
}
