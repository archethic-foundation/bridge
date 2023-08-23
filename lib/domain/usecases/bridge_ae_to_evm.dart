/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/domain/usecases/archethic_bridge_process_mixin.dart';
import 'package:aebridge/domain/usecases/evm_mixin.dart';
import 'package:aebridge/model/secret.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeArchethicToEVMUseCase
    with ArchethicBridgeProcessMixin, EVMBridgeProcessMixin {
  Future<void> run(
    WidgetRef ref, {
    int recoveryStep = 0,
  }) async {
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);

    // 1) Deploy Archethic HTLC
    late String htlcAEAddress;
    if (recoveryStep <= 1) {
      htlcAEAddress = await deployAESignedHTLC(ref);
      var blockchainFrom =
          ref.read(BridgeFormProvider.bridgeForm).blockchainFrom;
      blockchainFrom = blockchainFrom!.copyWith(htlcAddress: htlcAEAddress);
      await bridgeNotifier.setBlockchainFrom(blockchainFrom);
    }

    // 2) Provision Archethic HTLC
    if (recoveryStep <= 2) await provisionAEHTLC(ref, htlcAEAddress);

    // 3) Get Secret Hash from API
    late SecretHash secretHash;
    if (recoveryStep <= 3) {
      secretHash = await getAESecretHash(ref, htlcAEAddress);
    }

    // 4) Deploy EVM HTLC + Provision
    late String htlcEVMAddress;
    if (recoveryStep <= 4) {
      htlcEVMAddress = await deployEVMHTCLAndProvision(ref, secretHash);
      var blockchainTo = ref.read(BridgeFormProvider.bridgeForm).blockchainTo;
      blockchainTo = blockchainTo!.copyWith(htlcAddress: htlcEVMAddress);
      await bridgeNotifier.setBlockchainTo(blockchainTo);
    }

    // 5) Request Secret from Archethic LP
    if (recoveryStep <= 5) await requestAESecretFromLP(ref, htlcAEAddress);

    // 6) Reveal Secret
    late Secret secret;
    if (recoveryStep <= 6) {
      secret = await revealAESecret(ref, htlcAEAddress);
    }

    // 7) Reveal Secret EVM (Withdraw)
    if (recoveryStep <= 7) await withdrawAE(ref, htlcEVMAddress, secret);
  }

  String getStepLabel(
    BuildContext context,
    int step,
  ) {
    return getAEStepLabel(context, step);
  }
}
