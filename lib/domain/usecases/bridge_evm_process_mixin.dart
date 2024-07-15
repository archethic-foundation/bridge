/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:aebridge/application/contracts/archethic_contract_chargeable.dart';
import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/contracts/evm_htlc_erc.dart';
import 'package:aebridge/application/contracts/evm_htlc_native.dart';
import 'package:aebridge/application/contracts/evm_lp.dart';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webthree/browser.dart';
import 'package:webthree/crypto.dart';
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
const contractNameERC20 =
    'contracts/evm/artifacts/@openzeppelin/contracts/token/ERC20/ERC20.sol/ERC20.json';
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
    int decimal,
    String htlcContractAddressAE,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
    final evmLP = EVMLP(bridge.blockchainTo!.providerEndpoint);
    final resultDeployAndProvisionSignedHTLC =
        await evmLP.deployAndProvisionSignedHTLC(
      ref,
      bridge.tokenToBridge!.poolAddressTo,
      htlcContractAddressAE,
      secretHash,
      amount,
      decimal,
      endTime,
      chainId: bridge.blockchainTo!.chainId,
    );
    late String htlcAddress;
    late String txAddress;
    await resultDeployAndProvisionSignedHTLC.map(
      success: (success) {
        htlcAddress = success.htlcContractAddressEVM;
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
      bridge.tokenToBridgeDecimals,
      bridge.tokenToBridge!.typeSource != 'Native',
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

  Future<void> withdrawEVM(
    WidgetRef ref,
    String htlcAddress,
    Uint8List secret,
    SecretSignature signatureAEHTLC,
  ) async {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);

    final htlc = EVMHTLC(
      bridge.blockchainFrom!.providerEndpoint,
      htlcAddress,
      bridge.blockchainFrom!.chainId,
    );

    var contract = contractNameChargeableHTLCERC;
    if (bridge.tokenToBridge!.typeSource == 'Native') {
      contract = contractNameChargeableHTLCETH;
    }

    final resultWithdraw = await htlc.withdraw(
      ref,
      '0x${bytesToHex(secret)}',
      contract,
      signatureAEHTLC,
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

  Future<double?> getEVMHTLCAmount(
    WidgetRef ref,
    String htlcAddress,
    int decimal,
  ) async {
    double? htlcAmount;
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    final htlc = EVMHTLC(
      bridge.blockchainFrom!.providerEndpoint,
      htlcAddress,
      bridge.blockchainFrom!.chainId,
    );

    final resultAmount = await htlc.getAmount(decimal);
    resultAmount.map(
      success: (amount) => htlcAmount = amount,
      failure: (failure) => htlcAmount = null,
    );
    return htlcAmount;
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
      var newTransaction = transaction;
      if (transaction.gasPrice == null) {
        final gasPrice = await web3Client.getGasPrice();
        const slippage = 1.5;
        final gasPriceInWei = gasPrice.getInWei.toDouble();
        final newGasPriceInWei = gasPriceInWei * slippage;
        final newGasPrice =
            EtherAmount.fromDouble(EtherUnit.wei, newGasPriceInWei);
        newTransaction = newTransaction.copyWith(gasPrice: newGasPrice);
      }
      if (transaction.value == null) {
        newTransaction = newTransaction.copyWith(value: EtherAmount.zero());
      }
      if (transaction.maxPriorityFeePerGas == null) {
        final maxPriorityFeePerGas = await _getMaxPriorityFeePerGas();
        newTransaction =
            newTransaction.copyWith(maxPriorityFeePerGas: maxPriorityFeePerGas);
        if (transaction.maxFeePerGas == null) {
          final maxFeePerGas =
              await _getMaxFeePerGas(web3Client, maxPriorityFeePerGas.getInWei);
          newTransaction = newTransaction.copyWith(maxFeePerGas: maxFeePerGas);
        }
      }
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'gasPrice=${newTransaction.gasPrice}, maxPriorityFeePerGas=${newTransaction.maxPriorityFeePerGas}, maxFeePerGas=${newTransaction.maxFeePerGas}',
            name: 'EVMBridgeProcessMixin - sendTransactionWithErrorManagement',
          );

      final transactionHash = await web3Client.sendTransaction(
        credentials,
        newTransaction,
        chainId: chainId,
      );
      return transactionHash;
    } catch (e, stackTrace) {
      if (e is EthereumUserRejected) {
        throw const aedappfm.Failure.userRejected();
      }
      if (e is EthereumException) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              '$e',
              stackTrace: stackTrace,
              level: aedappfm.LogLevel.error,
              name:
                  'EVMBridgeProcessMixin - sendTransactionWithErrorManagement',
            );
        if (e.data == null &&
            e.message.contains('insufficient funds for gas * price')) {
          throw throw const aedappfm.Failure.insufficientFunds();
        }

        throw aedappfm.Failure.other(
          cause: e.data ?? e.message,
          stack: e.data == null ? null : e.message,
        );
      }
      if (e is EthersException) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              '$e',
              stackTrace: stackTrace,
              level: aedappfm.LogLevel.error,
              name:
                  'EVMBridgeProcessMixin - sendTransactionWithErrorManagement',
            );
        throw aedappfm.Failure.other(
          cause: e.rawError.toString(),
          stack: e.reason,
        );
      }
      if (e is WebThreeRPCError) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              '$e',
              stackTrace: stackTrace,
              level: aedappfm.LogLevel.error,
              name:
                  'EVMBridgeProcessMixin - sendTransactionWithErrorManagement',
            );
        const encoder = JsonEncoder.withIndent('  ');
        final validJson = encoder.convert(e.data);
        final Map<String, dynamic> jsonMap = json.decode(validJson);
        if (jsonMap.entries.first.value is Map) {
          throw aedappfm.Failure.rpcErrorEVM(
            (jsonMap.entries.first.value as Map).entries.first.value,
          );
        }

        throw aedappfm.Failure.rpcErrorEVM(jsonMap.entries.first.value);
      }
      if (e is BinanceWalletException) {
        throw aedappfm.Failure.other(cause: e.error);
      }

      aedappfm.sl.get<aedappfm.LogManager>().log(
            '$e',
            stackTrace: stackTrace,
            level: aedappfm.LogLevel.error,
            name: 'EVMBridgeProcessMixin - sendTransactionWithErrorManagement',
          );
      throw aedappfm.Failure.other(cause: e.toString());
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

    aedappfm.Result<String, aedappfm.Failure>? resultSignedWithdraw;
    if (bridge.tokenToBridge!.typeSource == 'Native') {
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

    if (bridge.tokenToBridge!.typeSource == 'Wrapped') {
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
          aedappfm.Failure.other(cause: 'An error occurs while the withdraw.');
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

  Future<EtherAmount> _getMaxPriorityFeePerGas() {
    // We may want to compute this more accurately in the future,
    // using the formula "check if the base fee is correct".
    // See: https://eips.ethereum.org/EIPS/eip-1559
    return Future.value(EtherAmount.inWei(BigInt.from(1000000000)));
  }

// Max Fee = (2 * Base Fee) + Max Priority Fee
  Future<EtherAmount> _getMaxFeePerGas(
    Web3Client client,
    BigInt maxPriorityFeePerGas,
  ) async {
    final blockInformation = await client.getBlockInformation();
    final baseFeePerGas = blockInformation.baseFeePerGas;

    if (baseFeePerGas == null) {
      return EtherAmount.zero();
    }

    return EtherAmount.inWei(
      baseFeePerGas.getInWei * BigInt.from(2) + maxPriorityFeePerGas,
    );
  }

  Future<Uint8List> signTxFaucetUCO() async {
    if (aedappfm.sl.isRegistered<EVMWalletProvider>() == false) {
      throw const aedappfm.Failure.connectivityEVM();
    }

    final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
    if (evmWalletProvider.walletConnected == false) {
      throw const aedappfm.Failure.connectivityEVM();
    }
    const payload =
        "To help you join the Archethic ecosystem, we're offering you free Archethic transaction fees. For security reasons, this requires your signature. Thank you for joining us, and happy exploring!";
    try {
      final result = await evmWalletProvider.credentials!.signPersonalMessage(
        utf8.encode(payload),
      );
      return result;
    } catch (e) {
      if (evmWalletProvider.eth != null) {
        final result = await evmWalletProvider.eth!.rawRequest(
          'personal_sign',
          params: [
            bytesToHex(
              utf8.encode(payload),
              include0x: true,
              padToEvenLength: true,
            ),
            evmWalletProvider.currentAddress,
          ],
        );

        return hexToBytes(result as String);
      } else {
        rethrow;
      }
    }
  }
}
