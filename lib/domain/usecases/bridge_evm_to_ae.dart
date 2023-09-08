/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:typed_data';

import 'package:aebridge/domain/usecases/archethic_bridge_process_mixin.dart';
import 'package:aebridge/domain/usecases/evm_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeEVMToArchethicUseCase
    with ArchethicBridgeProcessMixin, EVMBridgeProcessMixin {
  Future<void> run(
    WidgetRef ref, {
    int recoveryStep = 0,
    List<int>? recoverySecret,
    String? recoveryHTLCEVMAddress,
    String? recoveryHTLCAEAddress,
  }) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);

    Uint8List? secret;
    if (recoverySecret != null) {
      secret = Uint8List.fromList(recoverySecret);
    } else {
      secret = generateRandomSecret();
      await bridgeNotifier.setSecret(secret.toList());
    }

    final secretHash = sha256.convert(
      secret,
    );

    String? htlcEVMAddress;
    String? htlcAEAddress;

    if (recoveryHTLCEVMAddress != null) {
      htlcEVMAddress = recoveryHTLCEVMAddress;
      await bridgeNotifier.setHTLCEVMAddress(htlcEVMAddress);
    }
    if (recoveryHTLCAEAddress != null) {
      htlcAEAddress = recoveryHTLCAEAddress;
      await bridgeNotifier.setHTLCAEAddress(recoveryHTLCAEAddress);
    }

    switch (bridge.tokenToBridge!.type) {
      case 'ERC20':

        // 1) Deploy EVM HTLC
        if (recoveryStep <= 1) {
          try {
            htlcEVMAddress = await deployEVMHTLC(ref, secretHash);
            await bridgeNotifier.setHTLCEVMAddress(htlcEVMAddress);
          } catch (e) {
            return;
          }
          var blockchainFrom =
              ref.read(BridgeFormProvider.bridgeForm).blockchainFrom;
          blockchainFrom =
              blockchainFrom!.copyWith(htlcAddress: htlcEVMAddress);
          await bridgeNotifier.setBlockchainFrom(blockchainFrom);
        }

        // 2) Provision HTLC
        if (recoveryStep <= 2) {
          try {
            await provisionEVMHTLC(ref, htlcEVMAddress!);
          } catch (e) {
            return;
          }
        }

        // 3) Deploy Archethic HTLC
        if (recoveryStep <= 3) {
          try {
            htlcAEAddress = await deployAEChargeableHTLC(ref, secretHash);
            await bridgeNotifier.setHTLCAEAddress(htlcAEAddress);
          } catch (e) {
            return;
          }
          var blockchainTo =
              ref.read(BridgeFormProvider.bridgeForm).blockchainTo;
          blockchainTo = blockchainTo!.copyWith(htlcAddress: htlcAEAddress);
          await bridgeNotifier.setBlockchainTo(blockchainTo);
        }

        // 4) Withwdraw
        if (recoveryStep <= 4) {
          try {
            await withdrawEVM(ref, htlcEVMAddress!, secret);
          } catch (e) {
            return;
          }
        }
        // 5) Reveal secret to Archethic HTLC
        if (recoveryStep <= 5) {
          try {
            await revealEVMSecret(ref, htlcAEAddress!, secret);
          } catch (e) {
            return;
          }
        }

        break;
      case 'Native':
        break;
      case 'Wrapped':
        break;
      default:
        throw Exception('Unknown token type.');
    }
  }

  String getStepLabel(
    BuildContext context,
    int step,
  ) {
    return getEVMStepLabel(context, step);
  }
}
