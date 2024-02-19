/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/bridge_ae_process_mixin.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeArchethicToEVMUseCase
    with
        ArchethicBridgeProcessMixin,
        EVMBridgeProcessMixin,
        aedappfm.TransactionMixin {
  Future<void> run(
    WidgetRef ref, {
    int recoveryStep = 0,
    String? recoveryHTLCEVMAddress,
    String? recoveryHTLCAEAddress,
  }) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);

    String? htlcEVMAddress;
    String? htlcAEAddress;
    String? htlcEVMTxAddress;
    String? seedHTLC;
    if (recoveryHTLCEVMAddress != null) {
      htlcEVMAddress = recoveryHTLCEVMAddress;
      await bridgeNotifier.setHTLCEVMAddress(recoveryHTLCEVMAddress);
      htlcEVMTxAddress = bridge.htlcEVMTxAddress;
    }
    if (recoveryHTLCAEAddress != null) {
      htlcAEAddress = recoveryHTLCAEAddress;
    } else {
      final resultDefineHTLCAddress = ArchethicContract().defineHTLCAddress();
      htlcAEAddress = resultDefineHTLCAddress.genesisAddressHTLC;
      seedHTLC = resultDefineHTLCAddress.seedHTLC;
    }

    // 1) Deploy Archethic HTLC
    if (recoveryStep <= 1) {
      try {
        await bridgeNotifier.setCurrentStep(1);
        await deployAESignedHTLC(
          ref,
          htlcAEAddress,
          seedHTLC!,
        );
      } catch (e) {
        return;
      }
    }
    var blockchainFrom = ref.read(BridgeFormProvider.bridgeForm).blockchainFrom;
    blockchainFrom = blockchainFrom!.copyWith(htlcAddress: htlcAEAddress);
    await bridgeNotifier.setBlockchainFrom(blockchainFrom);

    await bridgeNotifier.setHTLCAEAddress(htlcAEAddress);

    // 2) Provision Archethic HTLC
    if (recoveryStep <= 2) {
      try {
        await bridgeNotifier.setCurrentStep(2);
        await provisionAEHTLC(
          ref,
          htlcAEAddress,
        );

        // Wait for AE HTLC Update
        if (await waitForManualTxConfirmation(htlcAEAddress, 2) == false) {
          await bridgeNotifier.setFailure(const aedappfm.Failure.timeout());
          await bridgeNotifier.setTransferInProgress(false);
          return;
        }
      } catch (e) {
        return;
      }
    }

    SecretHash secretHash;
    int endTime;
    double amount;
    if (recoveryStep <= 4) {
      try {
        // 3) Get Secret Hash from API
        await bridgeNotifier.setCurrentStep(3);
        final resultGetAEHTLCData = await getAEHTLCData(ref, htlcAEAddress);
        secretHash = resultGetAEHTLCData.secretHash;
        endTime = resultGetAEHTLCData.endTime;
        amount = resultGetAEHTLCData.amount;
        if (endTime == 0 ||
            amount == 0 ||
            secretHash.secretHash == null ||
            secretHash.secretHashSignature == null) {
          await bridgeNotifier.setFailure(
            const aedappfm.Failure.invalidValue(),
          );
          await bridgeNotifier.setTransferInProgress(false);
          return;
        }
      } catch (e, stackTrace) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              '$e',
              stackTrace: stackTrace,
              level: aedappfm.LogLevel.error,
              name: 'BridgeArchethicToEVMUseCase - run',
            );
        await bridgeNotifier.setFailure(
          aedappfm.Failure.other(cause: e.toString()),
        );
        await bridgeNotifier.setTransferInProgress(false);
        return;
      }

      // 4) Deploy EVM HTLC + Provision
      await bridgeNotifier.setCurrentStep(4);
      try {
        final deployEVMHTCLAndProvisionResult =
            await deployEVMHTCLAndProvision(ref, secretHash, endTime, amount);
        htlcEVMAddress = deployEVMHTCLAndProvisionResult.htlcAddress;
        htlcEVMTxAddress = deployEVMHTCLAndProvisionResult.txAddress;
        await bridgeNotifier.setHTLCEVMAddress(htlcEVMAddress);
        await bridgeNotifier.setHTLCEVMTxAddress(htlcEVMTxAddress);
      } catch (e) {
        return;
      }
      var blockchainTo = ref.read(BridgeFormProvider.bridgeForm).blockchainTo;
      blockchainTo = blockchainTo!.copyWith(htlcAddress: htlcEVMAddress);
      await bridgeNotifier.setBlockchainTo(blockchainTo);
    }

    // 5) Request Secret from Archethic LP
    if (recoveryStep <= 5) {
      await bridgeNotifier.setCurrentStep(5);
      try {
        await requestAESecretFromLP(
          ref,
          htlcAEAddress,
          htlcEVMAddress!,
          htlcEVMTxAddress!,
        );

        // Wait for AE HTLC Update
        if (await waitForManualTxConfirmation(
              htlcAEAddress,
              3,
            ) ==
            false) {
          await bridgeNotifier.setFailure(const aedappfm.Failure.timeout());
          await bridgeNotifier.setTransferInProgress(false);
          return;
        }
      } catch (e) {
        return;
      }
    }

    late Secret secret;
    if (recoveryStep <= 7) {
      await bridgeNotifier.setCurrentStep(6);
      try {
        // 6) Reveal Secret
        secret = await revealAESecret(ref, htlcAEAddress);
      } catch (e) {
        return;
      }

      // 7) Reveal Secret EVM (Withdraw)
      await bridgeNotifier.setCurrentStep(7);
      try {
        await withdrawAE(ref, htlcEVMAddress!, secret);
      } catch (e) {
        return;
      }

      await bridgeNotifier.setCurrentStep(8);
      bridgeNotifier.setBridgeOk(true);
    }
  }

  String getStepLabel(
    BuildContext context,
    int step,
  ) {
    return getAEStepLabel(context, step);
  }
}
