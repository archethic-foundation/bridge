/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:aebridge/application/contracts/archethic_contract_chargeable.dart';
import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/contracts/evm_lp.dart';
import 'package:aebridge/application/contracts/evm_lp_erc.dart';
import 'package:aebridge/application/contracts/evm_lp_native.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/json_rpc.dart';
import 'package:webthree/webthree.dart';

enum EVMBridgeProcessStep { none, deploy }

const contractNameIHTLC = 'IHTLC';
const contractNameHTLCERC = 'HTLC_ERC';
const contractNameHTLCETH = 'HTLC_ETH';

const contractNameIPool = 'IPool';
const contractNamePoolBase = 'PoolBase';

const contractNameIERC20 = 'IERC20';
const contractNameSignedHTLCERC = 'SignedHTLC_ERC';
const contractNameSignedHTLCETH = 'SignedHTLC_ETH';
const contractNameChargeableHTLCERC = 'ChargeableHTLC_ERC';

mixin EVMBridgeProcessMixin {
  String getEVMStepLabel(
    BuildContext context,
    int step,
  ) {
    switch (step) {
      case 1:
        return AppLocalizations.of(context)!.evmBridgeProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.evmBridgeProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.evmBridgeProcessStep3;
      case 4:
        return AppLocalizations.of(context)!.evmBridgeProcessStep4;
      case 5:
        return AppLocalizations.of(context)!.evmBridgeProcessStep5;
      case 6:
        return AppLocalizations.of(context)!.evmBridgeProcessStep6;
      default:
        return AppLocalizations.of(context)!.evmBridgeProcessStep0;
    }
  }

  Future<String> deployEVMHTCLAndProvision(
    WidgetRef ref,
    SecretHash secretHash,
    int endTime,
    double amount,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(4);
    final evmLP = EVMLP(bridge.blockchainTo!.providerEndpoint);
    debugPrint(
      'bridge.blockchainTo!.providerEndpoint ${bridge.blockchainTo!.providerEndpoint}',
    );
    debugPrint(
      'bridge.tokenToBridge!.poolAddressTo: ${bridge.tokenToBridge!.poolAddressTo}',
    );
    debugPrint('bridge.blockchainTo!.chainId: ${bridge.blockchainTo!.chainId}');

    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final resultDeployAndProvisionSignedHTLC =
        await evmLP.deployAndProvisionSignedHTLC(
      bridge.tokenToBridge!.poolAddressTo,
      secretHash,
      amount,
      endTime,
      chainId: bridge.blockchainTo!.chainId,
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    late String htlcAddress;
    await resultDeployAndProvisionSignedHTLC.map(
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

  Uint8List generateRandomSecret() {
    final secret = Uint8List.fromList(
      List<int>.generate(
        32,
        (int i) => Random.secure().nextInt(256),
      ),
    );
    return secret;
  }

  Future<String> deployEVMHTLC(WidgetRef ref, Digest secretHash) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(1);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final evmLP = EVMLP(bridge.blockchainFrom!.providerEndpoint);
    final resultDeployChargeableHTLCEVM = await evmLP.deployChargeableHTLC(
      bridge.tokenToBridge!.poolAddressFrom,
      secretHash.toString(),
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridge!.type != 'Native',
      chainId: bridge.blockchainFrom!.chainId,
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    late String htlcAddress;
    await resultDeployChargeableHTLCEVM.map(
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

  Future<void> provisionEVMHTLC(WidgetRef ref, String htlcAddress) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(2);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);

    Result<void, Failure>? resultProvisionChargeableHTLC;
    if (bridge.tokenToBridge!.type == 'ERC20') {
      final evmLPERC = EVMLPERC(
        bridge.blockchainFrom!.providerEndpoint,
        htlcAddress,
        bridge.blockchainFrom!.chainId,
      );
      resultProvisionChargeableHTLC = await evmLPERC.provisionChargeableHTLC(
        bridge.tokenToBridgeAmount,
        bridge.tokenToBridge!.tokenAddressSource,
      );
    }

    if (bridge.tokenToBridge!.type == 'Native') {
      final evmLPNative = EVMLPNative(
        bridge.blockchainFrom!.providerEndpoint,
        htlcAddress,
        bridge.blockchainFrom!.chainId,
      );
      resultProvisionChargeableHTLC = await evmLPNative.provisionChargeableHTLC(
        bridge.tokenToBridgeAmount,
      );
    }

    await bridgeNotifier.setWaitForWalletConfirmation(null);
    await resultProvisionChargeableHTLC!.map(
      success: (success) {},
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
  }

  Future<void> withdrawEVM(
    WidgetRef ref,
    String htlcAddress,
    Uint8List secret,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(4);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);
    final htlc = EVMHTLC(
      bridge.blockchainFrom!.providerEndpoint,
      htlcAddress,
      bridge.blockchainFrom!.chainId,
    );

    final resultWithdraw = await htlc.withdraw(
      '0x${bytesToHex(secret)}',
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    await resultWithdraw.map(
      success: (success) {
        return;
      },
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
  }

  Future<double?> getEVMHTLCAmount(WidgetRef ref, String htlcAddress) async {
    double? etlcAmount;
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final htlc = EVMHTLC(
      bridge.blockchainFrom!.providerEndpoint,
      htlcAddress,
      bridge.blockchainFrom!.chainId,
    );
    final resultAmount = await htlc.getAmount();
    resultAmount.map(
      success: (amount) => etlcAmount = amount,
      failure: (failure) => etlcAmount = null,
    );
    return etlcAmount;
  }

  Future<void> revealEVMSecret(
    WidgetRef ref,
    String htlcAddress,
    Uint8List secret,
    double amount,
    String poolAddress,
  ) async {
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(5);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.archethic);
    final session = ref.read(SessionProviders.session);
    final walletTo = session.walletTo;
    final resultRevealSecretToChargeableHTLC =
        await ArchethicContractChargeable().revealSecretToChargeableHTLC(
      walletTo!.genesisAddress,
      walletTo.nameAccount,
      htlcAddress,
      bytesToHex(secret),
      amount,
      poolAddress,
    );
    await bridgeNotifier.setWaitForWalletConfirmation(null);
    await bridgeNotifier.setTransferInProgress(false);
    await resultRevealSecretToChargeableHTLC.map(
      success: (success) async {
        await bridgeNotifier.setCurrentStep(6);
        return;
      },
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        throw failure;
      },
    );
  }

  Future<String> sendTransactionWithErrorManagement(
    Web3Client web3Client,
    CredentialsWithKnownAddress credentials,
    Transaction transaction,
    int chainId,
  ) async {
    try {
      final transactionHash = await web3Client.sendTransaction(
        credentials,
        transaction,
        chainId: chainId,
      );
      debugPrint('transactionHash $transactionHash');
      return transactionHash;
    } catch (e) {
      debugPrint('error provisionChargeableHTLC $e');

      if (e is EthereumUserRejected) {
        throw const Failure.userRejected();
      }
      if (e is EthereumException) {
        throw Failure.other(cause: e.data, stack: e.message);
      }
      if (e is EthersException) {
        throw Failure.other(cause: e.rawError.toString(), stack: e.reason);
      }
      if (e is RPCError) {
        const encoder = JsonEncoder.withIndent('  ');
        final validJson = encoder.convert(e.data);
        final Map<String, dynamic> jsonMap = json.decode(validJson);

        throw Failure.rpcErrorEVM(jsonMap.entries.first.value);
      }
      throw Failure.other(cause: e.toString());
    }
  }

// wait and report:
  Future<TransactionReceipt> watchTxStatus(
    Web3Client web3client,
    String txHash, {
    int delay = 1,
    int retries = 10,
  }) async {
    TransactionReceipt? receipt;
    try {
      debugPrint('async watch tx status');
      receipt = await web3client.getTransactionReceipt(txHash);
    } catch (err) {
      debugPrint('could not get $txHash receipt, try again');
    }

    var _delay = delay;
    var _retries = retries;
    while (receipt == null) {
      debugPrint('retry: waiting for receipt');
      await Future.delayed(Duration(seconds: _delay));
      _delay *= 2;
      _retries--;
      if (_retries == 0) {
        throw Exception('Transaction $txHash not mined yet...');
      }
      try {
        receipt = await web3client.getTransactionReceipt(txHash);
      } catch (err) {
        debugPrint('could not get $txHash receipt, try again');
      }
    }
    return receipt;
  }

  Future<BigInt> estimateGas(
    Web3Client web3Client,
    Transaction transaction,
  ) async {
    return web3Client.estimateGas(
      sender: transaction.from,
      to: transaction.to,
      gasPrice: transaction.gasPrice,
      value: transaction.value,
      data: transaction.data,
    );
  }

  Future<DeployedContract> getDeployedContract(
    String contractName,
    String address,
  ) async {
    final abiLPERCStringJson = jsonDecode(
      await rootBundle
          .loadString('contracts/evm/build/contracts/$contractName.json'),
    );

    return DeployedContract(
      ContractAbi.fromJson(
        jsonEncode(abiLPERCStringJson['abi']),
        abiLPERCStringJson['contractName'] as String,
      ),
      EthereumAddress.fromHex(address),
    );
  }

  Future<String> withdrawAE(WidgetRef ref, String htlc, Secret secret) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    await bridgeNotifier.setCurrentStep(7);
    await bridgeNotifier
        .setWaitForWalletConfirmation(WaitForWalletConfirmation.evm);

    Result<String, Failure>? resultSignedWithdraw;
    debugPrint('bridge.tokenToBridge!.type: ${bridge.tokenToBridge!.type}');
    if (bridge.tokenToBridge!.type == 'Native') {
      final evmLPERC = EVMLPERC(
        bridge.blockchainTo!.providerEndpoint,
        htlc,
        bridge.blockchainFrom!.chainId,
      );

      resultSignedWithdraw = await evmLPERC.signedWithdraw(
        secret,
      );
    }

    if (bridge.tokenToBridge!.type == 'Wrapped') {
      final evmLPNative = EVMLPNative(
        bridge.blockchainTo!.providerEndpoint,
        htlc,
        bridge.blockchainFrom!.chainId,
      );

      resultSignedWithdraw = await evmLPNative.signedWithdraw(
        secret,
      );
    }

    if (resultSignedWithdraw == null) {
      const failure =
          Failure.other(cause: 'An error occurs while the withdraw.');
      await bridgeNotifier.setFailure(failure);
      await bridgeNotifier.setTransferInProgress(false);
      throw failure;
    }

    await bridgeNotifier.setWaitForWalletConfirmation(null);
    late String txAddress;
    await resultSignedWithdraw.map(
      success: (success) async {
        await bridgeNotifier.setCurrentStep(8);
        await bridgeNotifier.setWaitForWalletConfirmation(null);
        await bridgeNotifier.setTransferInProgress(false);
        txAddress = success;
      },
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
    return txAddress;
  }
}
