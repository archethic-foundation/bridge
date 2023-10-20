/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:typed_data';

import 'package:aebridge/application/contracts/archethic_contract_chargeable.dart';
import 'package:aebridge/application/contracts/archethic_contract_signed.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ArchethicBridgeProcessMixin {
  String getAEStepLabel(
    BuildContext context,
    int step,
  ) {
    switch (step) {
      case 1:
        return AppLocalizations.of(context)!.aeBridgeProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.aeBridgeProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.aeBridgeProcessStep3;
      case 4:
        return AppLocalizations.of(context)!.aeBridgeProcessStep4;
      case 5:
        return AppLocalizations.of(context)!.aeBridgeProcessStep5;
      case 6:
        return AppLocalizations.of(context)!.aeBridgeProcessStep6;
      case 7:
        return AppLocalizations.of(context)!.aeBridgeProcessStep7;
      case 8:
        return AppLocalizations.of(context)!.aeBridgeProcessStep8;
      default:
        return AppLocalizations.of(context)!.aeBridgeProcessStep0;
    }
  }

  Future<String> deployAESignedHTLC(
    WidgetRef ref,
    String htlcAEAddress,
    String seedHTLC,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(1);
    await bridgeNotifier.setWalletConfirmation(WalletConfirmation.archethic);

    final session = ref.read(SessionProviders.session);
    final walletFrom = session.walletFrom;

    late String archethicHTLCAddress;
    final resultDeploySignedHTLC =
        await ArchethicContractSigned().deploySignedHTLC(
      ref,
      htlcAEAddress,
      seedHTLC,
      bridge.blockchainFrom!.archethicFactoryAddress!,
      bridge.tokenToBridge!.poolAddressFrom,
      walletFrom!.genesisAddress,
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridge!.tokenAddressSource,
      bridge.blockchainTo!.chainId,
    );
    await bridgeNotifier.setWalletConfirmation(null);
    await resultDeploySignedHTLC.map(
      success: (success) {
        archethicHTLCAddress = success;
        debugPrint('htlc: $archethicHTLCAddress');
      },
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
    return archethicHTLCAddress;
  }

  Future<String> deployAEChargeableHTLC(
    WidgetRef ref,
    Digest secretHash,
    double amount,
    int endTime,
    String htlcEVMAddress,
    String txAddress,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(3);
    await bridgeNotifier.setWalletConfirmation(WalletConfirmation.archethic);

    late String htlcAddress;
    final resultDeployChargeableHTLCAE =
        await ArchethicContractChargeable().deployChargeableHTLC(
      ref,
      bridge.blockchainTo!.archethicFactoryAddress!,
      bridge.tokenToBridge!.poolAddressTo,
      bridge.targetAddress,
      endTime,
      amount,
      bridge.tokenToBridge!.tokenAddressTarget,
      archethic.uint8ListToHex(
        Uint8List.fromList(secretHash.bytes),
      ),
      bridge.blockchainFrom!.chainId,
      htlcEVMAddress,
      txAddress,
    );
    await bridgeNotifier.setWalletConfirmation(null);
    await resultDeployChargeableHTLCAE.map(
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

  Future<void> provisionAEHTLC(
    WidgetRef ref,
    String htlcGenesisAddress,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(2);
    await bridgeNotifier.setWalletConfirmation(WalletConfirmation.archethic);

    final session = ref.read(SessionProviders.session);
    final walletFrom = session.walletFrom;

    final resultProvisionSignedHTLC =
        await ArchethicContractSigned().provisionSignedHTLC(
      ref,
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridge!.tokenAddressSource,
      bridge.tokenToBridge!.poolAddressFrom,
      htlcGenesisAddress,
      walletFrom!.genesisAddress,
      bridge.blockchainTo!.chainId,
    );

    await bridgeNotifier.setWalletConfirmation(null);
    await resultProvisionSignedHTLC.map(
      success: (success) {},
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
    return;
  }

  Future<
      ({
        SecretHash secretHash,
        int endTime,
        double amount,
      })> getAEHTLCData(
    WidgetRef ref,
    String archethicHTLCAddress,
  ) async {
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(3);
    await bridgeNotifier.setWaitForWalletConfirmation(true);

    //final updater = APIDataUpdater()..htlcAddressBefore = archethicHTLCAddress;
    //await updater.waitForHTLCUpdate(archethicHTLCAddress);

    // TODO(reddwarf03): Fix this
    await Future.delayed(const Duration(seconds: 10));

    final htlcDataMap = await sl.get<archethic.ApiService>().callSCFunction(
          jsonRPCRequest: archethic.SCCallFunctionRequest(
            method: 'contract_fun',
            params: archethic.SCCallFunctionParams(
              contract: archethicHTLCAddress,
              function: 'get_htlc_data',
              args: [],
            ),
          ),
          resultMap: true,
        ) as Map<String, dynamic>;
    await bridgeNotifier.setWaitForWalletConfirmation(false);
    debugPrint('htlcDataMap: $htlcDataMap');
    return (
      secretHash: SecretHash(
        secretHash: htlcDataMap['secret_hash'],
        secretHashSignature: SecretHashSignature(
          r: htlcDataMap['secret_hash_signature']['r'],
          s: htlcDataMap['secret_hash_signature']['s'],
          v: htlcDataMap['secret_hash_signature']['v'],
        ),
      ),
      endTime: htlcDataMap['end_time'] as int,
      amount: htlcDataMap['amount'] as double,
    );
  }

  Future<void> requestAESecretFromLP(
    WidgetRef ref,
    String htlcAddress,
    String htlcEVMAddress,
    String txAddress,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(5);
    await bridgeNotifier.setWalletConfirmation(WalletConfirmation.archethic);
    final session = ref.read(SessionProviders.session);
    final walletFrom = session.walletFrom;

    final resultRequestSecretFromSignedHTLC =
        await ArchethicContractSigned().requestSecretFromSignedHTLC(
      ref,
      walletFrom!.nameAccount,
      htlcAddress,
      bridge.tokenToBridge!.poolAddressFrom,
      htlcEVMAddress,
      txAddress,
    );
    await bridgeNotifier.setWalletConfirmation(null);
    await resultRequestSecretFromSignedHTLC.map(
      success: (success) {},
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
  }

  Future<Secret> revealAESecret(WidgetRef ref, String htlcAddress) async {
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(6);
    await bridgeNotifier.setWaitForWalletConfirmation(true);

    // TODO(reddwarf03): Berk
    await Future.delayed(const Duration(seconds: 10));

    final secretMap = await sl.get<archethic.ApiService>().callSCFunction(
          jsonRPCRequest: archethic.SCCallFunctionRequest(
            method: 'contract_fun',
            params: archethic.SCCallFunctionParams(
              contract: htlcAddress,
              function: 'get_secret',
              args: [],
            ),
          ),
          resultMap: true,
        ) as Map<String, dynamic>;

    await bridgeNotifier.setWaitForWalletConfirmation(false);

    debugPrint('secret: $secretMap');
    debugPrint(
      'secret without archethic prefix ${secretMap["secret"]}',
    );
    return Secret(
      secret: '0x${secretMap['secret']}',
      secretSignature: SecretSignature(
        r: '0x${secretMap["secret_signature"]["r"]}',
        s: '0x${secretMap["secret_signature"]["s"]}',
        v: secretMap['secret_signature']['v'],
      ),
    );
  }
}

class APIDataUpdater {
  int retryCount = 0;
  String? htlcAddressBefore;

  Future<String> fetchData(String htlcGenesisAddress) async {
    final htlcAddressAfterMap = await sl
        .get<archethic.ApiService>()
        .getLastTransaction([htlcGenesisAddress], request: 'address');
    return htlcAddressAfterMap[htlcGenesisAddress]!.address!.address!;
  }

  Future<String> waitForHTLCUpdate(String htlcGenesisAddress) async {
    const maxRetries = 5;
    const retryInterval = Duration(seconds: 5);
    const timeout = Duration(seconds: 5);

    final completer = Completer<String>();

    Future<void> checkData() async {
      final htlcAddressAfter = await fetchData(htlcGenesisAddress);
      if (htlcAddressAfter != htlcAddressBefore) {
        debugPrint('waitForHTLCUpdate ok');
        completer.complete(htlcAddressAfter);
      } else {
        if (retryCount < maxRetries) {
          retryCount++;
          debugPrint('waitForHTLCUpdate Retry $retryCount');
          Timer(retryInterval, checkData);
        } else {
          debugPrint('waitForHTLCUpdate Number of retries exceeded');
          completer.completeError(Exception('Number of retries exceeded'));
        }
      }
    }

    Timer(retryInterval, checkData);

    return completer.future.timeout(
      timeout,
      onTimeout: () {
        retryCount = maxRetries;
        throw Exception('Timeout');
      },
    );
  }
}
