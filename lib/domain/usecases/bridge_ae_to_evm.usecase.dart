/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';

import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/evm_lp.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/get_contract_creation_response.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/bridge_ae_process_mixin.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class BridgeArchethicToEVMUseCase
    with
        ArchethicBridgeProcessMixin,
        EVMBridgeProcessMixin,
        aedappfm.TransactionMixin {
  BridgeArchethicToEVMUseCase();

  Future<void> run(
    AppLocalizations localizations,
    WidgetRef ref,
    awc.ArchethicDAppClient dappClient, {
    int recoveryStep = 0,
    String? recoveryHTLCEVMAddress,
    String? recoveryHTLCAEAddress,
  }) async {
    final bridge = ref.read(bridgeFormNotifierProvider);
    final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);

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
    var blockchainFrom = ref.read(bridgeFormNotifierProvider).blockchainFrom;
    blockchainFrom = blockchainFrom!.copyWith(htlcAddress: htlcAEAddress);

    await bridgeNotifier.setBlockchainFrom(localizations, blockchainFrom);
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
        final apiService = aedappfm.sl.get<archethic.ApiService>();
        if (await waitForManualTxConfirmation(htlcAEAddress, 2, apiService) ==
            false) {
          await bridgeNotifier.setCurrentStep(3);
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
        final resultGetAEHTLCData = await getAEHTLCData(htlcAEAddress);
        secretHash = resultGetAEHTLCData.secretHash;
        endTime = resultGetAEHTLCData.endTime;
        amount = resultGetAEHTLCData.amount;
        if (endTime == 0 ||
            amount == 0 ||
            secretHash.secretHash == null ||
            secretHash.secretHashSignature == null) {
          // https://github.com/archethic-foundation/bridge/issues/100

          aedappfm.sl.get<aedappfm.LogManager>().log(
                'Error 1405',
                level: aedappfm.LogLevel.error,
                name: 'BridgeArchethicToEVMUseCase - run',
              );
          await bridgeNotifier.setFailure(
            aedappfm.Failure.other(
              cause: localizations.failureSignedProvisionAsync,
            ),
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
        var evmHTLCExist = false;

        if (recoveryHTLCAEAddress != null) {
          var _htlcContractAddressEVM = '';
          final evmLP = EVMLP();
          final ownerEVMAddress =
              ref.read(sessionNotifierProvider).walletTo?.genesisAddress;
          if (ownerEVMAddress != null) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Resume AE -> EVM Check HTLC EVM Provisioned: getSwapsByOwner - poolAddressTo :${bridge.tokenToBridge!.poolAddressTo}, ownerEVMAddress $ownerEVMAddress',
                  level: aedappfm.LogLevel.debug,
                  name: 'BridgeArchethicToEVMUseCase - run',
                );

            final swapsByOwnerResult = await evmLP.getSwapsByOwner(
              bridge.tokenToBridge!.poolAddressTo,
              ownerEVMAddress,
              bridge.blockchainTo!.chainId,
            );
            swapsByOwnerResult.map(
              success: (swaps) {
                for (final swap in swaps) {
                  if (swap.htlcContractAddressAE != null &&
                      swap.htlcContractAddressAE?.toUpperCase() ==
                          htlcAEAddress?.toUpperCase() &&
                      swap.htlcContractAddressEVM != null) {
                    evmHTLCExist = true;
                    _htlcContractAddressEVM = swap.htlcContractAddressEVM!;
                  }
                }
              },
              failure: (failure) {
                aedappfm.sl.get<aedappfm.LogManager>().log(
                      'Resume AE -> EVM Check HTLC EVM Provisioned: failure $failure',
                      level: aedappfm.LogLevel.debug,
                      name: 'BridgeArchethicToEVMUseCase - run',
                    );
              },
            );

            if (evmHTLCExist && _htlcContractAddressEVM.isNotEmpty) {
              try {
                final htlcContractAddressEVMTxHash = await fetchTxHash(
                  bridge.blockchainTo!.explorerApi,
                  _htlcContractAddressEVM,
                  ownerEVMAddress,
                );
                htlcEVMAddress = _htlcContractAddressEVM;
                htlcEVMTxAddress = htlcContractAddressEVMTxHash ?? '';
                await bridgeNotifier.setHTLCEVMAddress(_htlcContractAddressEVM);
                if (htlcContractAddressEVMTxHash != null) {
                  await bridgeNotifier
                      .setHTLCEVMTxAddress(htlcContractAddressEVMTxHash);
                }
                aedappfm.sl.get<aedappfm.LogManager>().log(
                      'Resume AE -> EVM Check HTLC EVM Provisioned: HTLC AE : $recoveryHTLCAEAddress - HTLC EVM : $_htlcContractAddressEVM - HTLC EVM TxHash : $htlcContractAddressEVMTxHash',
                      level: aedappfm.LogLevel.debug,
                      name: 'BridgeArchethicToEVMUseCase - run',
                    );
              } catch (e) {
                await bridgeNotifier
                    .setFailure(aedappfm.Failure.other(cause: '$e'));
                await bridgeNotifier.setTransferInProgress(false);
                return;
              }
            }
          }
        }

        if (evmHTLCExist == false) {
          final deployEVMHTCLAndProvisionResult =
              await deployEVMHTCLAndProvision(
            ref,
            secretHash,
            endTime,
            amount,
            bridge.tokenBridgedDecimals,
            htlcAEAddress,
          );
          htlcEVMAddress = deployEVMHTCLAndProvisionResult.htlcAddress;
          htlcEVMTxAddress = deployEVMHTCLAndProvisionResult.txAddress;
          await bridgeNotifier.setHTLCEVMAddress(htlcEVMAddress);
          await bridgeNotifier.setHTLCEVMTxAddress(htlcEVMTxAddress);
        }
      } catch (e) {
        return;
      }
      var blockchainTo = ref.read(bridgeFormNotifierProvider).blockchainTo;
      blockchainTo = blockchainTo!.copyWith(htlcAddress: htlcEVMAddress);

      await bridgeNotifier.setBlockchainTo(localizations, blockchainTo);
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
        final apiService = aedappfm.sl.get<archethic.ApiService>();
        if (await waitForManualTxConfirmation(
              htlcAEAddress,
              3,
              apiService,
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
        secret = await revealAESecret(htlcAEAddress);
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
    AppLocalizations localizations,
    int step,
  ) {
    return getAEStepLabel(localizations, step);
  }

  Future<String?> fetchTxHash(
    String explorerApiUrl,
    String contractAddress,
    String ownerAddress,
  ) async {
    final url = Uri.parse(
      '$explorerApiUrl&module=contract&action=getcontractcreation&contractaddresses=$contractAddress',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final getContractCreationResponse =
          GetContractCreationResponse.fromJson(json.decode(response.body));

      if (getContractCreationResponse.status == '1' &&
          getContractCreationResponse.message == 'OK' &&
          getContractCreationResponse.result.isNotEmpty &&
          getContractCreationResponse.result.first.contractCreator
                  .toUpperCase() ==
              ownerAddress.toUpperCase() &&
          getContractCreationResponse.result.first.contractAddress
                  .toUpperCase() ==
              contractAddress.toUpperCase()) {
        return getContractCreationResponse.result.first.txHash;
      }
    }
    return null;
  }
}
