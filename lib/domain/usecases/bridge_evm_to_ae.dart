/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/domain/repositories/datasources/bridge_local_datasource.dart';
import 'package:aebridge/domain/usecases/archethic_bridge_process_mixin.dart';
import 'package:aebridge/domain/usecases/evm_mixin.dart';
import 'package:aebridge/model/hive/bridge.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeEVMToArchethicUseCase
    with ArchethicBridgeProcessMixin, EVMBridgeProcessMixin {
  Future<void> run(
    WidgetRef ref,
    Bridge bridgeHive, {
    int recoveryStep = 0,
  }) async {
    final hiveBridgeDatasource = await HiveBridgeDatasource.getInstance();
    Bridge bridgeUpdated;

    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final secretInfos = generateRandomSecret();
    final secret = secretInfos.$1;
    final secretHash = secretInfos.$2;

    late String htlcEVMAddress;
    switch (bridge.tokenToBridge!.type) {
      case 'ERC20':

        // 1) Deploy EVM HTLC
        if (recoveryStep <= 1) {
          htlcEVMAddress = await deployEVMHTLC(ref, secretHash);
          bridgeUpdated = bridgeHive.copyWith(htlcEVMAddress: htlcEVMAddress);
          hiveBridgeDatasource.setBridge(bridge: bridgeUpdated);
        }

        // 2) Provision HTLC
        if (recoveryStep <= 2) await provisionEVMHTLC(ref, htlcEVMAddress);

        // 3) Deploy Archethic HTLC
        late String htlcAEAddress;
        if (recoveryStep <= 3) {
          htlcAEAddress = await deployAEChargeableHTLC(ref, secretHash);
          bridgeUpdated = bridgeHive.copyWith(htlcAEAddress: htlcAEAddress);
          hiveBridgeDatasource.setBridge(bridge: bridgeUpdated);
        }

        // 4) Withwdraw
        if (recoveryStep <= 4) await withdrawEVM(ref, htlcEVMAddress, secret);

        // 5) Reveal secret to Archethic HTLC
        if (recoveryStep <= 5) {
          await revealEVMSecret(ref, htlcAEAddress, secret);
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
}
