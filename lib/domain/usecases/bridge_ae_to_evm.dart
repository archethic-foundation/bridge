/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/archethic_bridge_process_mixin.dart';
import 'package:aebridge/domain/usecases/evm_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeArchethicToEVMUseCase
    with ArchethicBridgeProcessMixin, EVMBridgeProcessMixin {
  Future<void> run(
    WidgetRef ref, {
    int recoveryStep = 0,
    String? recoveryHTLCEVMAddress,
    String? recoveryHTLCAEAddress,
  }) async {
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);

    String? htlcEVMAddress;
    String? htlcAEAddress;
    if (recoveryHTLCEVMAddress != null) {
      htlcEVMAddress = recoveryHTLCEVMAddress;
    }
    if (recoveryHTLCAEAddress != null) {
      htlcAEAddress = recoveryHTLCAEAddress;
    }

    // 1) Deploy Archethic HTLC
    if (recoveryStep <= 1) {
      try {
        htlcAEAddress = await deployAESignedHTLC(ref);
      } catch (e) {
        return;
      }
      var blockchainFrom =
          ref.read(BridgeFormProvider.bridgeForm).blockchainFrom;
      blockchainFrom = blockchainFrom!.copyWith(htlcAddress: htlcAEAddress);
      await bridgeNotifier.setBlockchainFrom(blockchainFrom);
    }

    // 2) Provision Archethic HTLC
    if (recoveryStep <= 2) {
      try {
        await provisionAEHTLC(ref, htlcAEAddress!);
      } catch (e) {
        return;
      }
    }

    // 3) Get Secret Hash from API
    late SecretHash secretHash;
    if (recoveryStep <= 3) {
      try {
        secretHash = await getAESecretHash(ref, htlcAEAddress!);
      } catch (e) {
        return;
      }
    }

    // 4) Deploy EVM HTLC + Provision
    if (recoveryStep <= 4) {
      try {
        htlcEVMAddress = await deployEVMHTCLAndProvision(ref, secretHash);
      } catch (e) {
        return;
      }
      var blockchainTo = ref.read(BridgeFormProvider.bridgeForm).blockchainTo;
      blockchainTo = blockchainTo!.copyWith(htlcAddress: htlcEVMAddress);
      await bridgeNotifier.setBlockchainTo(blockchainTo);
    }

    // 5) Request Secret from Archethic LP
    if (recoveryStep <= 5) {
      try {
        await requestAESecretFromLP(ref, htlcAEAddress!);
      } catch (e) {
        return;
      }
    }

    // 6) Reveal Secret
    late Secret secret;
    if (recoveryStep <= 6) {
      try {
        secret = await revealAESecret(ref, htlcAEAddress!);
      } catch (e) {
        return;
      }
    }

    // 7) Reveal Secret EVM (Withdraw)
    if (recoveryStep <= 7) {
      try {
        await withdrawAE(ref, htlcEVMAddress!, secret);
      } catch (e) {
        return;
      }
    }
  }

  String getStepLabel(
    BuildContext context,
    int step,
  ) {
    return getAEStepLabel(context, step);
  }
}
