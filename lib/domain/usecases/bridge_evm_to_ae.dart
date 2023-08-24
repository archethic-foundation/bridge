/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/domain/usecases/archethic_bridge_process_mixin.dart';
import 'package:aebridge/domain/usecases/evm_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeEVMToArchethicUseCase
    with ArchethicBridgeProcessMixin, EVMBridgeProcessMixin {
  Future<void> run(
    WidgetRef ref, {
    int recoveryStep = 0,
  }) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    final secretInfos = generateRandomSecret();
    final secret = secretInfos.$1;
    final secretHash = secretInfos.$2;

    String? htlcEVMAddress;
    String? htlcAEAddress;

    switch (bridge.tokenToBridge!.type) {
      case 'ERC20':

        // 1) Deploy EVM HTLC
        if (recoveryStep <= 1) {
          try {
            htlcEVMAddress = await deployEVMHTLC(ref, secretHash);
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
