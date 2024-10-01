/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/contracts/evm_htlc_erc.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/usecases/bridge_ae_process_mixin.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/infrastructure/balance.repository.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/util/faucet_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

class BridgeEVMToArchethicUseCase
    with
        ArchethicBridgeProcessMixin,
        EVMBridgeProcessMixin,
        aedappfm.TransactionMixin {
  Future<void> run(
    AppLocalizations localizations,
    WidgetRef ref, {
    int recoveryStep = 0,
    List<int>? recoverySecret,
    String? recoveryHTLCEVMAddress,
    String? recoveryHTLCAEAddress,
  }) async {
    final bridge = ref.read(bridgeFormNotifierProvider);
    final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);
    final session = ref.read(sessionNotifierProvider);
    await bridgeNotifier.setCurrentStep(0);

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
    String? htlcEVMTxAddress;
    int? endTime;
    if (recoveryHTLCEVMAddress != null) {
      htlcEVMAddress = recoveryHTLCEVMAddress;
      await bridgeNotifier.setHTLCEVMAddress(htlcEVMAddress);
      htlcEVMTxAddress = bridge.htlcEVMTxAddress;
    }
    if (recoveryHTLCAEAddress != null) {
      htlcAEAddress = recoveryHTLCAEAddress;
      await bridgeNotifier.setHTLCAEAddress(recoveryHTLCAEAddress);
    }

    // 1) Deploy EVM HTLC
    if (recoveryStep <= 1) {
      try {
        await bridgeNotifier.setCurrentStep(1);

        if (bridge.tokenToBridge!.typeSource == 'Wrapped') {
          final resultApproval = await EVMHTLCERC(
            '',
            bridge.blockchainFrom!.chainId,
          ).approveChargeableHTLC(
            ref,
            bridge.tokenToBridgeAmount,
            bridge.tokenToBridge!.tokenAddressSource,
            bridge.tokenToBridge!.poolAddressFrom,
            session.walletFrom!.genesisAddress,
            bridge.tokenToBridgeDecimals,
          );

          await resultApproval.map(
            success: (value) {},
            failure: (failure) async {
              await bridgeNotifier.setFailure(failure);
              await bridgeNotifier.setTransferInProgress(false);
              throw Exception();
            },
          );
        }

        final deployEVMHTLCResult = await deployEVMHTLC(ref, secretHash);
        htlcEVMAddress = deployEVMHTLCResult.htlcAddress;
        htlcEVMTxAddress = deployEVMHTLCResult.txAddress;
        await bridgeNotifier.setHTLCEVMAddress(htlcEVMAddress);
        await bridgeNotifier.setHTLCEVMTxAddress(htlcEVMTxAddress);
      } catch (e) {
        return;
      }
      var blockchainFrom = ref.read(bridgeFormNotifierProvider).blockchainFrom;
      blockchainFrom = blockchainFrom!.copyWith(htlcAddress: htlcEVMAddress);

      await bridgeNotifier.setBlockchainFrom(localizations, blockchainFrom);
    }

    // 2) Get HTLC Lock time
    if (recoveryStep <= 3) {
      await bridgeNotifier.setCurrentStep(2);
      final htlc = EVMHTLC(
        htlcEVMAddress!,
        bridge.blockchainFrom!.chainId,
      );
      final resultGetHTLCLockTime = await htlc.getHTLCLockTime();
      await resultGetHTLCLockTime.map(
        success: (htlcLockTime) {
          endTime = htlcLockTime;
        },
        failure: (failure) async {
          await bridgeNotifier
              .setFailure(const aedappfm.Failure.invalidValue());
          await bridgeNotifier.setTransferInProgress(false);
          throw Exception();
        },
      );
    }

    // 3) Provision HTLC
    if (recoveryStep <= 3 && bridge.tokenToBridge!.typeSource != 'Native') {
      await bridgeNotifier.setCurrentStep(3);
    }

    // Waiting for EVM's provider data propagation
    await Future.delayed(const Duration(seconds: 10));

    // 4) Get amount from HTLC
    double? amount;
    if (recoveryStep <= 5) {
      await bridgeNotifier.setCurrentStep(4);
      amount = await getEVMHTLCAmount(
        ref,
        htlcEVMAddress!,
        bridge.tokenToBridgeDecimals,
      );
      if (amount == null) {
        await bridgeNotifier.setFailure(const aedappfm.Failure.invalidValue());
        await bridgeNotifier.setTransferInProgress(false);
        return;
      }

      // before 5) Faucet is necessary
      var _executeCatch = true;
      try {
        await bridgeNotifier.setCurrentStep(5);
        final balanceUCO = await BalanceRepositoryImpl()
            .getBalance(true, bridge.targetAddress, '', '', 8);
        if (balanceUCO == 0) {
          final signature = await signTxFaucetUCO();
          final queryParameters = {
            'archethic_address': bridge.targetAddress,
            'evm_contract': htlcEVMAddress,
            'evm_chain_id': bridge.blockchainFrom!.chainId.toString(),
            'evm_signature': signature,
          };

          final getUrlResult =
              FaucetUtil.getUrl(bridge.blockchainTo!.env, queryParameters);
          final response = await http.get(getUrlResult.uri);
          _executeCatch = getUrlResult.executeCatch;
          if (response.statusCode != 200) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Faucet UCO error status code : ${response.statusCode}',
                  level: aedappfm.LogLevel.error,
                  name: 'BridgeEVMToArchethicUseCase - run',
                );
            await bridgeNotifier.setFailure(
              const aedappfm.Failure.faucetUCOError(),
            );
            await bridgeNotifier.setTransferInProgress(false);
            return;
          }
        }
      } on wagmi.WagmiError catch (e) {
        if (e.findError(wagmi.WagmiErrors.UserRejectedRequestError) != null) {
          await bridgeNotifier.setFailure(
            const aedappfm.Failure.faucetUCOUserRejected(),
          );
          await bridgeNotifier.setTransferInProgress(false);
          return;
        }
        aedappfm.sl.get<aedappfm.LogManager>().log(
              'Faucet UCO error : ${e.name} - ${e.message} - ${e.version} - ${e.cause} - ${e.details}',
              level: aedappfm.LogLevel.error,
              name: 'BridgeEVMToArchethicUseCase - run',
            );

        await bridgeNotifier.setFailure(
          aedappfm.Failure.other(cause: e.shortMessage),
        );
        await bridgeNotifier.setTransferInProgress(false);
        return;
      } on Exception catch (_) {
        if (_executeCatch) {
          await bridgeNotifier.setFailure(
            const aedappfm.Failure.faucetUCOError(),
          );
          await bridgeNotifier.setTransferInProgress(false);
          return;
        }
      }

      // 5) Deploy Archethic HTLC
      try {
        await bridgeNotifier.setCurrentStep(5);
        if (endTime == null) {
          final htlc = EVMHTLC(
            htlcEVMAddress,
            bridge.blockchainFrom!.chainId,
          );
          final resultGetHTLCLockTime = await htlc.getHTLCLockTime();
          await resultGetHTLCLockTime.map(
            success: (htlcLockTime) {
              endTime = htlcLockTime;
            },
            failure: (failure) async {
              await bridgeNotifier
                  .setFailure(const aedappfm.Failure.invalidValue());
              await bridgeNotifier.setTransferInProgress(false);
              throw Exception();
            },
          );
        }

        htlcAEAddress = await deployAEChargeableHTLC(
          ref,
          secretHash,
          amount,
          endTime!,
          htlcEVMAddress,
          htlcEVMTxAddress!,
        );

        await bridgeNotifier.setHTLCAEAddress(htlcAEAddress);

        // Wait for AE HTLC Update
        final apiService = aedappfm.sl.get<ApiService>();
        if (await waitForManualTxConfirmation(
              htlcAEAddress,
              2,
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
      var blockchainTo = ref.read(bridgeFormNotifierProvider).blockchainTo;
      blockchainTo = blockchainTo!.copyWith(htlcAddress: htlcAEAddress);

      await bridgeNotifier.setBlockchainTo(localizations, blockchainTo);
    }

    // 6) Withdraw
    if (recoveryStep <= 6) {
      var checkAmount = 0.0;
      await bridgeNotifier.setCurrentStep(6);
      final balanceGetResponseMap =
          await aedappfm.sl.get<ApiService>().fetchBalance([htlcAEAddress!]);
      final balanceGetResponse = balanceGetResponseMap[htlcAEAddress];
      if (kDebugMode) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              'balanceGetResponse : $balanceGetResponse',
              level: aedappfm.LogLevel.debug,
              name: 'BridgeEVMToArchethicUseCase - run',
            );
      }

      if (bridge.tokenToBridge!.symbol.toUpperCase() == 'UCO') {
        checkAmount = fromBigInt(balanceGetResponse!.uco).toDouble();
        if (kDebugMode) {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'checkAmount : $checkAmount',
                level: aedappfm.LogLevel.debug,
                name: 'BridgeEVMToArchethicUseCase - run',
              );
        }
      } else {
        for (final balanceToken in balanceGetResponse!.token) {
          if (balanceToken.address!.toUpperCase() ==
              bridge.tokenToBridge!.tokenAddressTarget.toUpperCase()) {
            checkAmount = fromBigInt(balanceToken.amount).toDouble();
            if (kDebugMode) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    'checkAmount : $checkAmount - ${balanceToken.address!}',
                    level: aedappfm.LogLevel.debug,
                    name: 'BridgeEVMToArchethicUseCase - run',
                  );
            }
          }
        }
      }
      if (amount == null) {
        amount = await getEVMHTLCAmount(
          ref,
          htlcEVMAddress!,
          bridge.tokenToBridgeDecimals,
        );
        if (amount == null) {
          await bridgeNotifier
              .setFailure(const aedappfm.Failure.invalidValue());
          await bridgeNotifier.setTransferInProgress(false);
          return;
        }
      }
      if (kDebugMode) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              'if checkAmount : $checkAmount < $amount',
              level: aedappfm.LogLevel.debug,
              name: 'BridgeEVMToArchethicUseCase - run',
            );
      }
      if (checkAmount < amount) {
        await bridgeNotifier
            .setFailure(const aedappfm.Failure.htlcWithoutFunds());
        await bridgeNotifier.setTransferInProgress(false);
        return;
      }

      final signatureAEHTLC = await getProvisionSignature(htlcAEAddress);
      if (signatureAEHTLC == null) {
        await bridgeNotifier.setFailure(const aedappfm.Failure.notHTLC());
        await bridgeNotifier.setTransferInProgress(false);
        return;
      }

      try {
        final htlc = EVMHTLC(
          htlcEVMAddress!,
          bridge.blockchainFrom!.chainId,
        );
        final status = await htlc.getStatus();
        if (status != 1) {
          await withdrawEVM(
            ref,
            htlcEVMAddress,
            secret,
            signatureAEHTLC,
          );
        }
      } catch (e) {
        return;
      }
    }

    // 7) Reveal secret to Archethic HTLC
    if (recoveryStep <= 7) {
      try {
        await bridgeNotifier.setCurrentStep(7);
        if (amount == null) {
          amount = await getEVMHTLCAmount(
            ref,
            htlcEVMAddress!,
            bridge.tokenToBridgeDecimals,
          );
          amount ??= bridge.tokenToBridgeAmount;
        }
        await revealEVMSecret(
          ref,
          htlcAEAddress!,
          secret,
          amount,
          bridge.tokenToBridge!.poolAddressTo,
        );
      } catch (e) {
        return;
      }
    }

    await bridgeNotifier.setCurrentStep(8);
    bridgeNotifier.setBridgeOk(true);
  }

  String getStepLabel(
    AppLocalizations localizations,
    int step,
  ) {
    return getEVMStepLabel(localizations, step);
  }
}
