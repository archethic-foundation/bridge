/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/contracts/archethic_contract.dart';
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
    String? seedHTLC;
    if (recoveryHTLCEVMAddress != null) {
      htlcEVMAddress = recoveryHTLCEVMAddress;
      await bridgeNotifier.setHTLCEVMAddress(recoveryHTLCEVMAddress);
    }
    if (recoveryHTLCAEAddress != null) {
      htlcAEAddress = recoveryHTLCAEAddress;
    } else {
      final resultDefineHTLCAddress = ArchethicContract().defineHTLCAddress();
      htlcAEAddress = resultDefineHTLCAddress.genesisAddressHTLC;
      seedHTLC = resultDefineHTLCAddress.seedHTLC;
    }
    await bridgeNotifier.setHTLCAEAddress(htlcAEAddress);

    var blockchainFrom = ref.read(BridgeFormProvider.bridgeForm).blockchainFrom;
    blockchainFrom = blockchainFrom!.copyWith(htlcAddress: htlcAEAddress);
    await bridgeNotifier.setBlockchainFrom(blockchainFrom);

    // 1) Deploy Archethic HTLC
    if (recoveryStep <= 1) {
      try {
        await deployAESignedHTLC(
          ref,
          htlcAEAddress,
          seedHTLC!,
        );
      } catch (e) {
        return;
      }
    }

    // 2) Provision Archethic HTLC
    if (recoveryStep <= 2) {
      try {
        await provisionAEHTLC(
          ref,
          htlcAEAddress,
        );
      } catch (e) {
        return;
      }
    }

    late SecretHash secretHash;
    late int endTime;
    late double amount;
    if (recoveryStep <= 4) {
      try {
        // 3) Get Secret Hash from API
        final resultGetAEHTLCData = await getAEHTLCData(ref, htlcAEAddress);
        secretHash = resultGetAEHTLCData.secretHash;
        endTime = resultGetAEHTLCData.endTime;
        amount = resultGetAEHTLCData.amount;
      } catch (e) {
        return;
      }

      // 4) Deploy EVM HTLC + Provision
      try {
        htlcEVMAddress =
            await deployEVMHTCLAndProvision(ref, secretHash, endTime, amount);
        await bridgeNotifier.setHTLCEVMAddress(htlcEVMAddress);
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
        await requestAESecretFromLP(ref, htlcAEAddress);
      } catch (e) {
        return;
      }
    }

    late Secret secret;
    if (recoveryStep <= 7) {
      try {
        // 6) Reveal Secret
        secret = await revealAESecret(ref, htlcAEAddress);
      } catch (e) {
        return;
      }

      // 7) Reveal Secret EVM (Withdraw)
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
