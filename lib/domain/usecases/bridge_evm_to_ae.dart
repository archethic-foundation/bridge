/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:math';

import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/lp_erc_contract.dart';
import 'package:aebridge/application/contracts/lp_eth_contract.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/util/date_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webthree/crypto.dart';

class BridgeEVMToArchethicUseCase {
  Future<void> run(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    final secret = Uint8List.fromList(
      List<int>.generate(
        32,
        (int i) => Random.secure().nextInt(256),
      ),
    );
    final secretHex = '0x${bytesToHex(secret)}';
    final secretHash = sha256.convert(
      secret,
    );
    debugPrint('secret: $secretHex');
    debugPrint('type token: ${bridge.tokenToBridge!.type}');
    debugPrint('poolAddress: ${bridge.tokenToBridge!.poolAddressFrom}');

    late String htlcContract;
    switch (bridge.tokenToBridge!.type) {
      case 'ERC20':
        debugPrint('tokenAddress: ${bridge.tokenToBridge!.tokenAddress}');

        // 1) Deploy EVM HTLC contract + Provision
        bridgeNotifier
          ..setCurrentStep(1)
          ..setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
        final lpercContract =
            LPERCContract(bridge.blockchainFrom!.providerEndpoint);
        final resultDeploy = await lpercContract.deployChargeableHTLC(
          bridge.tokenToBridge!.poolAddressFrom,
          secretHash.toString(),
          BigInt.from(bridge.tokenToBridgeAmount),
          chainId: bridge.blockchainFrom!.chainId,
        );
        bridgeNotifier.setWaitForWalletConfirmation(null);
        resultDeploy.map(
          success: (success) {
            htlcContract = success;
          },
          failure: (failure) {
            bridgeNotifier
              ..setError(Failure.getErrorMessage(failure))
              ..setTransferInProgress(false);
            return;
          },
        );

        // 2) Provision HTLC Contract
        bridgeNotifier
          ..setCurrentStep(2)
          ..setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
        final resultProvision = await lpercContract.provisionChargeableHTLC(
          BigInt.from(bridge.tokenToBridgeAmount),
          htlcContract,
          bridge.tokenToBridge!.tokenAddress,
          chainId: bridge.blockchainFrom!.chainId,
        );
        bridgeNotifier.setWaitForWalletConfirmation(null);
        resultProvision.map(
          success: (success) {},
          failure: (failure) {
            bridgeNotifier
              ..setError(Failure.getErrorMessage(failure))
              ..setTransferInProgress(false);
            return;
          },
        );

        // 3) Deploy Archethic HTLC contract
        bridgeNotifier.setCurrentStep(3);
        var endTime = DateTime.now()
            .add(const Duration(minutes: 720))
            .millisecondsSinceEpoch;
        endTime = DateUtil().roundToNearestMinute(endTime) ~/ 1000;

        bridgeNotifier
            .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
        final archethicHTLCAddress =
            await ArchethicContract().deployChargeableHTLC(
          bridge.tokenToBridge!.poolAddressTo,
          bridge.targetAddress,
          endTime,
          bridge.tokenToBridgeAmount,
          '',
          archethic.uint8ListToHex(
            Uint8List.fromList(secretHash.bytes),
          ),
        );
        bridgeNotifier.setWaitForWalletConfirmation(null);

        // 4) Reveal secret + Send ETH to Reserve
        bridgeNotifier
          ..setCurrentStep(4)
          ..setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
        final resultWithdraw = await lpercContract.withdraw(
          htlcContract,
          secretHex,
          chainId: bridge.blockchainFrom!.chainId,
        );
        bridgeNotifier.setWaitForWalletConfirmation(null);
        resultWithdraw.map(
          success: (success) {},
          failure: (failure) {
            bridgeNotifier
              ..setError(Failure.getErrorMessage(failure))
              ..setTransferInProgress(false);
            return;
          },
        );

        // 5) Reveal secret to Archethic HTLC
        bridgeNotifier
          ..setCurrentStep(5)
          ..setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
        final session = ref.read(SessionProviders.session);
        final walletTo = session.walletTo;
        await ArchethicContract().revealSecretToChargeableHTLC(
          walletTo!.genesisAddress,
          walletTo.nameAccount,
          archethicHTLCAddress!,
          bytesToHex(secret),
        );
        bridgeNotifier
          ..setCurrentStep(6)
          ..setWaitForWalletConfirmation(null)
          ..setTransferInProgress(false);
        break;
      case 'Native':
        final lpethContract =
            LPETHContract(bridge.blockchainFrom!.providerEndpoint);
        final htlcContract = await lpethContract.deployAndProvisionHTLC(
          bridge.tokenToBridge!.poolAddressFrom,
          secretHash.toString(),
          BigInt.from(bridge.tokenToBridgeAmount),
          chainId: bridge.blockchainFrom!.chainId,
        );
        if (htlcContract == null) {
          return;
        }
        await lpethContract.withdraw(
          htlcContract,
          secretHex,
          chainId: bridge.blockchainFrom!.chainId,
        );

        break;
      case 'Wrapped':
        break;
      default:
        throw Exception('Unknown token type.');
    }
  }
}
