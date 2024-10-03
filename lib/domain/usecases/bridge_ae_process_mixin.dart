/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:typed_data';

import 'package:aebridge/application/contracts/archethic_contract_chargeable.dart';
import 'package:aebridge/application/contracts/archethic_contract_signed.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:crypto/crypto.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ArchethicBridgeProcessMixin {
  String getAEStepLabel(
    AppLocalizations localizations,
    int step,
  ) {
    switch (step) {
      case 1:
        return localizations.aeBridgeProcessStep1;
      case 2:
        return localizations.aeBridgeProcessStep2;
      case 3:
        return localizations.aeBridgeProcessStep3;
      case 4:
        return localizations.aeBridgeProcessStep4;
      case 5:
        return localizations.aeBridgeProcessStep5;
      case 6:
        return localizations.aeBridgeProcessStep6;
      case 7:
        return localizations.aeBridgeProcessStep7;
      case 8:
        return localizations.aeBridgeProcessStep8;
      default:
        return localizations.aeBridgeProcessStep0;
    }
  }

  Future<String> deployAESignedHTLC(
    WidgetRef ref,
    String htlcAEAddress,
    String seedHTLC,
  ) async {
    final bridge = ref.read(bridgeFormNotifierProvider);
    final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);
    final session = ref.read(sessionNotifierProvider);
    final walletFrom = session.walletFrom;
    final dappClient = aedappfm.sl.get<awc.ArchethicDAppClient>();
    late String archethicHTLCAddress;
    final resultDeploySignedHTLC =
        await ArchethicContractSigned().deploySignedHTLC(
      dappClient,
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

    await resultDeploySignedHTLC.map(
      success: (success) {
        archethicHTLCAddress = success;
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
    final bridge = ref.read(bridgeFormNotifierProvider);
    final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);
    final dappClient = aedappfm.sl.get<awc.ArchethicDAppClient>();
    late String htlcAddress;
    final resultDeployChargeableHTLCAE =
        await ArchethicContractChargeable().deployChargeableHTLC(
      dappClient,
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
    final bridge = ref.read(bridgeFormNotifierProvider);
    final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);
    final session = ref.read(sessionNotifierProvider);
    final walletFrom = session.walletFrom;
    final walletTo = session.walletTo;
    final dappClient = aedappfm.sl.get<awc.ArchethicDAppClient>();
    final resultProvisionSignedHTLC =
        await ArchethicContractSigned().provisionSignedHTLC(
      dappClient,
      ref,
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridge!.tokenAddressSource,
      bridge.tokenToBridge!.poolAddressFrom,
      htlcGenesisAddress,
      walletFrom!.genesisAddress,
      walletTo!.genesisAddress,
      bridge.blockchainTo!.chainId,
    );

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
    String archethicHTLCAddress,
  ) async {
    try {
      final htlcDataMap =
          await aedappfm.sl.get<archethic.ApiService>().callSCFunction(
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
    } catch (e) {
      return (
        secretHash: SecretHash(),
        endTime: 0,
        amount: 0.0,
      );
    }
  }

  Future<void> requestAESecretFromLP(
    WidgetRef ref,
    String htlcAddress,
    String htlcEVMAddress,
    String txAddress,
  ) async {
    final bridge = ref.read(bridgeFormNotifierProvider);
    final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);
    final session = ref.read(sessionNotifierProvider);
    final walletFrom = session.walletFrom;
    final dappClient = aedappfm.sl.get<awc.ArchethicDAppClient>();
    final resultRequestSecretFromSignedHTLC =
        await ArchethicContractSigned().requestSecretFromSignedHTLC(
      dappClient,
      ref,
      walletFrom!.nameAccount,
      htlcAddress,
      bridge.tokenToBridge!.poolAddressFrom,
      htlcEVMAddress,
      txAddress,
    );
    await resultRequestSecretFromSignedHTLC.map(
      success: (success) {},
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
  }

  Future<Secret> revealAESecret(String htlcAddress) async {
    final secretMap =
        await aedappfm.sl.get<archethic.ApiService>().callSCFunction(
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

    return Secret(
      secret: '0x${secretMap['secret']}',
      secretSignature: SecretSignature(
        r: '0x${secretMap["secret_signature"]["r"]}',
        s: '0x${secretMap["secret_signature"]["s"]}',
        v: secretMap['secret_signature']['v'],
      ),
    );
  }

  Future<SecretSignature?> getProvisionSignature(String htlcAddress) async {
    final dataJson =
        await aedappfm.sl.get<archethic.ApiService>().callSCFunction(
              jsonRPCRequest: archethic.SCCallFunctionRequest(
                method: 'contract_fun',
                params: archethic.SCCallFunctionParams(
                  contract: htlcAddress.toUpperCase(),
                  function: 'get_provision_signature',
                  args: [],
                ),
              ),
              resultMap: true,
            ) as Map<String, dynamic>;

    if (dataJson['r'] == null ||
        dataJson['s'] == null ||
        dataJson['v'] == null) {
      return null;
    }
    return SecretSignature(
      r: dataJson['r'],
      s: dataJson['s'],
      v: dataJson['v'],
    );
  }

  Future<
      ({
        String? evmHTLCAddress,
        String? evmPoolAddress,
        String? aePoolAddress,
        int? statusHTLC
      })> getInfo(archethic.ApiService apiService, String htlcAddress) async {
    try {
      final dataJson = await apiService.callSCFunction(
        jsonRPCRequest: archethic.SCCallFunctionRequest(
          method: 'contract_fun',
          params: archethic.SCCallFunctionParams(
            contract: htlcAddress.toUpperCase(),
            function: 'info',
            args: [],
          ),
        ),
        resultMap: true,
      ) as Map<String, dynamic>;
      return (
        evmHTLCAddress: dataJson['evm_contract']?.toString(),
        evmPoolAddress: dataJson['evm_pool']?.toString(),
        aePoolAddress: dataJson['ae_pool']?.toString(),
        statusHTLC:
            dataJson['status'] == null ? null : dataJson['status'] as int
      );
    } catch (e) {
      return (
        evmHTLCAddress: null,
        evmPoolAddress: null,
        aePoolAddress: null,
        statusHTLC: null,
      );
    }
  }
}
