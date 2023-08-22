/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/domain/usecases/archethic_bridge_process_mixin.dart';
import 'package:aebridge/domain/usecases/evm_mixin.dart';
import 'package:aebridge/model/secret.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeArchethicToEVMUseCase
    with ArchethicBridgeProcessMixin, EVMBridgeProcessMixin {
  Future<void> run(
    WidgetRef ref, {
    int recoveryStep = 0,
  }) async {
    // 1) Deploy Archethic HTLC
    late String htlcAEAddress;
    if (recoveryStep <= 1) htlcAEAddress = await deployAESignedHTLC(ref);

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
}
