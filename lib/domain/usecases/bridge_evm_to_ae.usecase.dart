/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:typed_data';

import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/domain/usecases/bridge_ae_process_mixin.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/infrastructure/balance.repository.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class BridgeEVMToArchethicUseCase
    with
        ArchethicBridgeProcessMixin,
        EVMBridgeProcessMixin,
        aedappfm.TransactionMixin {
  Future<void> run(
    WidgetRef ref, {
    int recoveryStep = 0,
    List<int>? recoverySecret,
    String? recoveryHTLCEVMAddress,
    String? recoveryHTLCAEAddress,
  }) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
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
        final deployEVMHTLCResult = await deployEVMHTLC(ref, secretHash);
        htlcEVMAddress = deployEVMHTLCResult.htlcAddress;
        htlcEVMTxAddress = deployEVMHTLCResult.txAddress;
        await bridgeNotifier.setHTLCEVMAddress(htlcEVMAddress);
        await bridgeNotifier.setHTLCEVMTxAddress(htlcEVMTxAddress);
      } catch (e) {
        return;
      }
      var blockchainFrom =
          ref.read(BridgeFormProvider.bridgeForm).blockchainFrom;
      blockchainFrom = blockchainFrom!.copyWith(htlcAddress: htlcEVMAddress);
      await bridgeNotifier.setBlockchainFrom(blockchainFrom);
    }

    // 2) Get HTLC Lock time
    if (recoveryStep <= 3) {
      await bridgeNotifier.setCurrentStep(2);
      final htlc = EVMHTLC(
        bridge.blockchainFrom!.providerEndpoint,
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
          return;
        },
      );
    }

    // 3) Provision HTLC
    if (recoveryStep <= 3 && bridge.tokenToBridge!.type != 'Native') {
      try {
        await bridgeNotifier.setCurrentStep(3);
        await provisionEVMHTLC(ref, htlcEVMAddress!);
      } catch (e) {
        return;
      }
    }

    // 4) Get amount from HTLC
    double? amount;
    if (recoveryStep <= 5) {
      await bridgeNotifier.setCurrentStep(4);
      amount = await getEVMHTLCAmount(ref, htlcEVMAddress!);
      if (amount == null) {
        await bridgeNotifier.setFailure(const aedappfm.Failure.invalidValue());
        await bridgeNotifier.setTransferInProgress(false);
        return;
      }

      // before 5) Faucet is necessary
      try {
        await bridgeNotifier.setCurrentStep(5);
        final balanceUCO = await BalanceRepositoryImpl()
            .getBalance(true, bridge.targetAddress, '', '');
        if (balanceUCO == 0) {
          final signature = await signTxFaucetUCO();
          final uri = Uri.http('localhost:8080', '/api/faucet', {
            'archethic_address': bridge.targetAddress,
            'evm_contract': htlcEVMAddress,
            'evm_chain_id': bridge.blockchainFrom!.chainId.toString(),
            'evm_signature': '0x${uint8ListToHex(signature)}',
          });

          final response = await http.get(uri);
          if (response.statusCode == 200) {
          } else {
            await bridgeNotifier.setFailure(
              aedappfm.Failure.other(
                cause:
                    'Faucet error - response.statusCode ${response.statusCode}',
              ),
            );
            await bridgeNotifier.setTransferInProgress(false);
            return;
          }
        }
        // ignore: unused_catch_stack
      } catch (e, stack) {
        // Because of CORS policy, i comment these lines...
        //await bridgeNotifier.setFailure(
        //    aedappfm.Failure.other(cause: e.toString() + stack.toString()));
        //await bridgeNotifier.setTransferInProgress(false);
        //return;
      }

      // 5) Deploy Archethic HTLC
      try {
        await bridgeNotifier.setCurrentStep(5);
        if (endTime == null) {
          final htlc = EVMHTLC(
            bridge.blockchainFrom!.providerEndpoint,
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
              return;
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
        if (await waitForManualTxConfirmation(htlcAEAddress, 2) == false) {
          await bridgeNotifier.setFailure(const aedappfm.Failure.timeout());
          await bridgeNotifier.setTransferInProgress(false);
          return;
        }
      } catch (e) {
        return;
      }
      var blockchainTo = ref.read(BridgeFormProvider.bridgeForm).blockchainTo;
      blockchainTo = blockchainTo!.copyWith(htlcAddress: htlcAEAddress);
      await bridgeNotifier.setBlockchainTo(blockchainTo);
    }

    // 6) Withdraw
    if (recoveryStep <= 6) {
      var checkAmount = 0.0;
      final balanceGetResponseMap =
          await aedappfm.sl.get<ApiService>().fetchBalance([htlcAEAddress!]);
      final balanceGetResponse = balanceGetResponseMap[htlcAEAddress];
      if (bridge.tokenToBridge!.type == 'ERC20') {
        checkAmount = fromBigInt(balanceGetResponse!.uco).toDouble();
      } else {
        for (final balanceToken in balanceGetResponse!.token) {
          if (balanceToken.address!.toUpperCase() ==
              bridge.tokenToBridge!.tokenAddressTarget.toUpperCase()) {
            checkAmount = fromBigInt(balanceToken.amount).toDouble();
          }
        }
      }
      if (checkAmount < amount!) {
        await bridgeNotifier
            .setFailure(const aedappfm.Failure.htlcWithoutFunds());
        await bridgeNotifier.setTransferInProgress(false);
        return;
      }

      await bridgeNotifier.setCurrentStep(6);
      try {
        await withdrawEVM(ref, htlcEVMAddress!, secret);
      } catch (e) {
        return;
      }
    }

    // 7) Reveal secret to Archethic HTLC
    if (recoveryStep <= 7) {
      try {
        await bridgeNotifier.setCurrentStep(7);
        if (amount == null) {
          amount = await getEVMHTLCAmount(ref, htlcEVMAddress!);
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
    BuildContext context,
    int step,
  ) {
    return getEVMStepLabel(context, step);
  }
}
