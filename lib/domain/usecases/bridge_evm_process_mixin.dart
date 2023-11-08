/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:aebridge/application/contracts/archethic_contract_chargeable.dart';
import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/contracts/evm_htlc_erc.dart';
import 'package:aebridge/application/contracts/evm_htlc_native.dart';
import 'package:aebridge/application/contracts/evm_lp.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/util/custom_logs.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/json_rpc.dart';
import 'package:webthree/webthree.dart';

enum EVMBridgeProcessStep { none, deploy }

const contractNameHTLCBase =
    'contracts/evm/artifacts/contracts/HTLC/HTLCBase.sol/HTLCBase.json';
const contractNameHTLCERC =
    'contracts/evm/artifacts/contracts/HTLC/HTLC_ERC.sol/HTLC_ERC.json';
const contractNameHTLCETH =
    'contracts/evm/artifacts/contracts/HTLC/HTLC_ETH.sol/HTLC_ETH.json';

const contractNameIPool =
    'contracts/evm/artifacts/interfaces/IPool.sol/IPool.json';
const contractNamePoolBase =
    'contracts/evm/artifacts/contracts/Pool/PoolBase.sol/PoolBase.json';

const contractNameIERC20 =
    'contracts/evm/artifacts/@openzeppelin/contracts/token/ERC20/IERC20.sol/IERC20.json';
const contractNameSignedHTLCERC =
    'contracts/evm/artifacts/contracts/HTLC/SignedHTLC_ERC.sol/SignedHTLC_ERC.json';
const contractNameSignedHTLCETH =
    'contracts/evm/artifacts/contracts/HTLC/SignedHTLC_ETH.sol/SignedHTLC_ETH.json';
const contractNameChargeableHTLCERC =
    'contracts/evm/artifacts/contracts/HTLC/ChargeableHTLC_ERC.sol/ChargeableHTLC_ERC.json';
const contractNameChargeableHTLCETH =
    'contracts/evm/artifacts/contracts/HTLC/ChargeableHTLC_ETH.sol/ChargeableHTLC_ETH.json';

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
      case 7:
        return AppLocalizations.of(context)!.evmBridgeProcessStep7;
      case 8:
        return AppLocalizations.of(context)!.evmBridgeProcessStep8;
      default:
        return AppLocalizations.of(context)!.evmBridgeProcessStep0;
    }
  }

  Future<
      ({
        String htlcAddress,
        String txAddress,
      })> deployEVMHTCLAndProvision(
    WidgetRef ref,
    SecretHash secretHash,
    int endTime,
    double amount,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    final evmLP = EVMLP(bridge.blockchainTo!.providerEndpoint);
    final resultDeployAndProvisionSignedHTLC =
        await evmLP.deployAndProvisionSignedHTLC(
      ref,
      bridge.tokenToBridge!.poolAddressTo,
      secretHash,
      amount,
      endTime,
      chainId: bridge.blockchainTo!.chainId,
    );
    late String htlcAddress;
    late String txAddress;
    await resultDeployAndProvisionSignedHTLC.map(
      success: (success) {
        htlcAddress = success.htlcContractAddress;
        txAddress = success.txAddress;
      },
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
    return (htlcAddress: htlcAddress, txAddress: txAddress);
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

  Future<({String htlcAddress, String txAddress})> deployEVMHTLC(
    WidgetRef ref,
    Digest secretHash,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);

    final evmLP = EVMLP(bridge.blockchainFrom!.providerEndpoint);
    final resultDeployChargeableHTLCEVM = await evmLP.deployChargeableHTLC(
      ref,
      bridge.tokenToBridge!.poolAddressFrom,
      secretHash.toString(),
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridge!.type != 'Native',
      chainId: bridge.blockchainFrom!.chainId,
    );
    late String htlcAddress;
    late String txAddress;
    await resultDeployChargeableHTLCEVM.map(
      success: (success) {
        htlcAddress = success.htlcContractAddress;
        txAddress = success.txAddress;
      },
      failure: (failure) async {
        await bridgeNotifier.setFailure(failure);
        await bridgeNotifier.setTransferInProgress(false);
        throw failure;
      },
    );
    return (
      htlcAddress: htlcAddress,
      txAddress: txAddress,
    );
  }

  Future<void> provisionEVMHTLC(WidgetRef ref, String htlcAddress) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);

    Result<void, Failure>? resultProvisionChargeableHTLC;
    if (bridge.tokenToBridge!.type == 'ERC20') {
      final evmHTLCERC = EVMHTLCERC(
        bridge.blockchainFrom!.providerEndpoint,
        htlcAddress,
        bridge.blockchainFrom!.chainId,
      );
      resultProvisionChargeableHTLC = await evmHTLCERC.provisionChargeableHTLC(
        ref,
        bridge.tokenToBridgeAmount,
        bridge.tokenToBridge!.tokenAddressSource,
      );
    }

    if (bridge.tokenToBridge!.type == 'Native') {
      final evmHTLCNative = EVMHTLCNative(
        bridge.blockchainFrom!.providerEndpoint,
        htlcAddress,
        bridge.blockchainFrom!.chainId,
      );
      resultProvisionChargeableHTLC =
          await evmHTLCNative.provisionChargeableHTLC(
        ref,
        bridge.tokenToBridgeAmount,
      );
    }
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

    final htlc = EVMHTLC(
      bridge.blockchainFrom!.providerEndpoint,
      htlcAddress,
      bridge.blockchainFrom!.chainId,
    );

    final resultWithdraw = await htlc.withdraw(
      ref,
      '0x${bytesToHex(secret)}',
    );
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
    final session = ref.read(SessionProviders.session);
    final walletTo = session.walletTo;
    final resultRevealSecretToChargeableHTLC =
        await ArchethicContractChargeable().revealSecretToChargeableHTLC(
      ref,
      walletTo!.genesisAddress,
      walletTo.nameAccount,
      htlcAddress,
      bytesToHex(secret),
      amount,
      poolAddress,
    );
    await bridgeNotifier.setTransferInProgress(false);
    await resultRevealSecretToChargeableHTLC.map(
      success: (success) async {
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
      return transactionHash;
    } catch (e, stackTrace) {
      sl.get<LogManager>().log(
            '$e',
            stackTrace: stackTrace,
            level: LogLevel.error,
          );

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
      await rootBundle.loadString(contractName),
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

    Result<String, Failure>? resultSignedWithdraw;
    if (bridge.tokenToBridge!.type == 'Native') {
      final evmHTLCERC = EVMHTLCERC(
        bridge.blockchainTo!.providerEndpoint,
        htlc,
        bridge.blockchainFrom!.chainId,
      );

      resultSignedWithdraw = await evmHTLCERC.signedWithdraw(
        ref,
        secret,
      );
    }

    if (bridge.tokenToBridge!.type == 'Wrapped') {
      final evmHTLCNative = EVMHTLCNative(
        bridge.blockchainTo!.providerEndpoint,
        htlc,
        bridge.blockchainFrom!.chainId,
      );

      resultSignedWithdraw = await evmHTLCNative.signedWithdraw(
        ref,
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

    late String txAddress;
    await resultSignedWithdraw.map(
      success: (success) async {
        await bridgeNotifier.setWalletConfirmation(null);
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
