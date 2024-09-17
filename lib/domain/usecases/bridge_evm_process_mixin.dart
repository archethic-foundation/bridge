/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:aebridge/application/contracts/archethic_contract_chargeable.dart';
import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/contracts/evm_htlc_erc.dart';
import 'package:aebridge/application/contracts/evm_htlc_native.dart';
import 'package:aebridge/application/contracts/evm_lp.dart';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/gas_fee_estimation.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

enum EVMBridgeProcess { bridge, refund }

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
    AppLocalizations localizations,
    int step,
  ) {
    switch (step) {
      case 1:
        return localizations.evmBridgeProcessStep1;
      case 2:
        return localizations.evmBridgeProcessStep2;
      case 3:
        return localizations.evmBridgeProcessStep3;
      case 4:
        return localizations.evmBridgeProcessStep4;
      case 5:
        return localizations.evmBridgeProcessStep5;
      case 6:
        return localizations.evmBridgeProcessStep6;
      case 7:
        return localizations.evmBridgeProcessStep7;
      case 8:
        return localizations.evmBridgeProcessStep8;
      default:
        return localizations.evmBridgeProcessStep0;
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
    final bridge = ref.read(bridgeFormNotifierProvider);
    final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);
    final chainId = aedappfm.sl.get<EVMWalletProvider>().currentChain ?? 0;

    final evmLP = EVMLP(
      bridge.blockchainTo!.providerEndpoint,
      chainId,
    );
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
        (int i) => math.Random.secure().nextInt(256),
      ),
    );
    return secret;
  }

  Future<({String htlcAddress, String txAddress})> deployEVMHTLC(
    WidgetRef ref,
    Digest secretHash,
  ) async {
    final bridge = ref.read(bridgeFormNotifierProvider);
    final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);
    final chainId = aedappfm.sl.get<EVMWalletProvider>().currentChain ?? 0;

    final evmLP = EVMLP(
      bridge.blockchainFrom!.providerEndpoint,
      chainId,
    );
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
    final bridge = ref.read(bridgeFormNotifierProvider);
    final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);

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
      '0x${archethic.uint8ListToHex(secret)}',
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
    double? etlcAmount;
    final bridge = ref.read(bridgeFormNotifierProvider);
    final htlc = EVMHTLC(
      bridge.blockchainFrom!.providerEndpoint,
      htlcAddress,
      bridge.blockchainFrom!.chainId,
    );

    final resultAmount = await htlc.getAmount(decimal);
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
    final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);
    final session = ref.read(sessionNotifierProvider);
    final walletTo = session.walletTo;
    final resultRevealSecretToChargeableHTLC =
        await ArchethicContractChargeable().revealSecretToChargeableHTLC(
      ref,
      walletTo!.genesisAddress,
      walletTo.nameAccount,
      htlcAddress,
      archethic.uint8ListToHex(secret),
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

  Future<T> _handleError<T>(
    FutureOr<T> Function() action,
    String fromMethod,
  ) async {
    try {
      return action();
    } catch (e, stackTrace) {
      throw aedappfm.Failure.other(cause: e.toString());
      // TODO(reddwarf03): Manage errors
      /* if (e is EthereumUserRejected) {
        throw const aedappfm.Failure.userRejected();
      }
      if (e is EthereumException) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              '$e',
              stackTrace: stackTrace,
              level: aedappfm.LogLevel.error,
              name: 'EVMBridgeProcessMixin - $fromMethod',
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
              name: 'EVMBridgeProcessMixin - $fromMethod',
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
              name: 'EVMBridgeProcessMixin - $fromMethod',
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
            name: 'EVMBridgeProcessMixin - $fromMethod',
          );
      throw aedappfm.Failure.other(cause: e.toString());
    }*/
    }
  }

  Future<String> sendTransactionWithErrorManagement({
    required wagmi.SendTransactionParameters transaction,
    required int chainId,
    required String fromMethod,
    required WidgetRef ref,
    required EVMBridgeProcess evmBridgeProcess,
  }) async =>
      _handleError(
        () async {
          var newTransaction = transaction;
          if (transaction is wagmi.SendTransactionParametersLegacy) {
            newTransaction = transaction.copyWith(
              feeValues: transaction.feeValues ??
                  await FeeValuesUtils.defaultLegacyFeeValues(transaction),
            );
          }
          if (transaction.value == null) {
            newTransaction = newTransaction.copyWith(value: BigInt.zero);
          }
          if (newTransaction is wagmi.SendTransactionParametersEIP1559) {
            newTransaction = newTransaction.copyWith(
              feeValues: await FeeValuesUtils.defaultEIP1559FeeValues(
                newTransaction,
              ),
            );
          }
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'feeValues=${newTransaction.feeValues}',
                name:
                    'EVMBridgeProcessMixin - sendTransactionWithErrorManagement from $fromMethod',
              );

          aedappfm.sl.get<aedappfm.LogManager>().log(
                newTransaction.feeValues.toString(),
                name:
                    'EVMBridgeProcessMixin - sendTransactionWithErrorManagement from $fromMethod',
              );

          final transactionHash = await wagmi.Core.sendTransaction(
            newTransaction,
          );

          await _waitForTransactionValidation(
            evmBridgeProcess: evmBridgeProcess,
            ref: ref,
            transactionHash: transactionHash,
            fromMethod: fromMethod,
            chainId: chainId,
          );

          return transactionHash;
        },
        fromMethod,
      );

  Future<String> writeContractWithErrorManagement({
    required wagmi.WriteContractParameters parameters,
    required int chainId,
    required String fromMethod,
    required WidgetRef ref,
    required EVMBridgeProcess evmBridgeProcess,
  }) async =>
      _handleError(
        () async {
          final transactionHash = await wagmi.Core.writeContract(parameters);
          await _waitForTransactionValidation(
            chainId: chainId,
            evmBridgeProcess: evmBridgeProcess,
            fromMethod: fromMethod,
            ref: ref,
            transactionHash: transactionHash,
          );
          return transactionHash;
        },
        fromMethod,
      );

  Future<String> _waitForTransactionValidation({
    required EVMBridgeProcess evmBridgeProcess,
    required WidgetRef ref,
    required String fromMethod,
    required String transactionHash,
    required int chainId,
  }) async {
    switch (evmBridgeProcess) {
      case EVMBridgeProcess.bridge:
        await ref
            .read(bridgeFormNotifierProvider.notifier)
            .setWalletConfirmation(null);

        break;
      case EVMBridgeProcess.refund:
        ref
            .read(RefundFormProvider.refundForm.notifier)
            .setWalletConfirmation(null);
        break;
    }

    const timeoutDuration = Duration(minutes: 60);
    const checkInterval = Duration(seconds: 2);
    const notifyDelay = Duration(seconds: 30);

    var elapsedTime = Duration.zero;
    var tooLong = false;

    while (elapsedTime < timeoutDuration) {
      await Future.delayed(
        checkInterval,
      );
      elapsedTime += checkInterval;

      // TODO(reddwarf03): See waitForTransactionReceipt instead of polling
      try {
        final transactionReceipt = await wagmi.Core.getTransactionReceipt(
          wagmi.GetTransactionReceiptParameters(hash: transactionHash),
        );

        if (transactionReceipt.status == 'success') {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'transactionHash: $transactionHash - status true (chainId $chainId)',
                level: aedappfm.LogLevel.error,
                name: 'EVMBridgeProcessMixin - $fromMethod',
              );

          switch (evmBridgeProcess) {
            case EVMBridgeProcess.bridge:
              ref
                  .read(bridgeFormNotifierProvider.notifier)
                  .setRequestTooLong(false);

              break;
            case EVMBridgeProcess.refund:
              ref
                  .read(RefundFormProvider.refundForm.notifier)
                  .setRequestTooLong(false);
              break;
          }
          return transactionHash;
        } else {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'transactionHash: $transactionHash - status false (chainId $chainId)',
                level: aedappfm.LogLevel.error,
                name: 'EVMBridgeProcessMixin - $fromMethod',
              );
          throw Exception(
            'An unknown error has occurred. Please refer to your EVM explorer',
          );
        }
      } catch (e) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              'transactionHash: $transactionHash - not found (chainId $chainId) - $e',
              name: 'EVMBridgeProcessMixin - $fromMethod',
            );
        if (e.toString().contains('TransactionReceiptNotFoundError') == false) {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'transactionHash: $transactionHash - error (chainId $chainId) - $e',
                level: aedappfm.LogLevel.error,
                name: 'EVMBridgeProcessMixin - $fromMethod',
              );
          throw Exception(
            'An unknown error has occurred. Please refer to your EVM explorer',
          );
        }
      }

      if (elapsedTime >= notifyDelay && tooLong == false) {
        switch (evmBridgeProcess) {
          case EVMBridgeProcess.bridge:
            ref
                .read(bridgeFormNotifierProvider.notifier)
                .setRequestTooLong(true);

            break;
          case EVMBridgeProcess.refund:
            ref
                .read(RefundFormProvider.refundForm.notifier)
                .setRequestTooLong(true);
            break;
        }

        tooLong = true;
      }
    }

    throw TimeoutException('Transaction timeout');
  }

  Future<wagmi.Abi> loadAbi(String assetPath) async {
    final abi = jsonDecode(
      await rootBundle.loadString(assetPath),
    )['abi'] as List;

    return abi.cast<Map<String, dynamic>>();
  }

  Future<String> withdrawAE(WidgetRef ref, String htlc, Secret secret) async {
    final bridge = ref.read(bridgeFormNotifierProvider);
    final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);

    aedappfm.Result<String, aedappfm.Failure>? resultSignedWithdraw;
    if (bridge.tokenToBridge!.typeSource == 'Native') {
      final evmHTLCERC = EVMHTLCERC(
        bridge.blockchainTo!.providerEndpoint,
        htlc,
        bridge.blockchainTo!.chainId,
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
        bridge.blockchainTo!.chainId,
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

  Future<String> signTxFaucetUCO() async {
    // TODO: Wait for PR validation
    /* if (aedappfm.sl.isRegistered<EVMWalletProvider>() == false) {
      throw const aedappfm.Failure.connectivityEVM();
    }

    final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
    if (evmWalletProvider.walletConnected == false) {
      throw const aedappfm.Failure.connectivityEVM();
    }
    const payload =
        "To help you join the Archethic ecosystem, we're offering you free Archethic transaction fees. For security reasons, this requires your signature. Thank you for joining us, and happy exploring!";
    try {
      final payloadSigned = await wagmi.Core.signMessage(
        wagmi.SignMessageParameters(
          account: wagmi.Core.getAccount().address!,
          message: const wagmi.MessageToSign.rawMessage(
            message: wagmi.RawMessage.hex(raw: payload),
          ),
        ),
      );
      return payloadSigned;
    } catch (e) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'Error signing $e',
            name: 'signTxFaucetUCO',
          );
      rethrow;
    }
  }*/
    return '';
  }
}

class FeeValuesUtils {
  static Future<GasFeeEstimation?> suggestedGasFees(
    int chainId,
  ) async {
    try {
      final url =
          'https://gas.api.infura.io/v3/3a7a2dbdbec046a4961550ddf8c7d78a/networks/$chainId/suggestedGasFees';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var gasFeeResponse =
            GasFeeEstimation.fromJson(jsonDecode(response.body));
        gasFeeResponse = gasFeeResponse.copyWith(timestamp: DateTime.now());
        aedappfm.sl
            .get<aedappfm.LogManager>()
            .log(gasFeeResponse.toString(), name: 'suggestedGasFees');
        return gasFeeResponse;
      } else {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              'Response status code: ${response.statusCode} / ${response.body}',
              name: 'suggestedGasFees',
            );
      }
    } catch (e) {
      aedappfm.sl
          .get<aedappfm.LogManager>()
          .log('Error: $e', name: 'suggestedGasFees');
    }
    return null;
  }

  static Future<wagmi.FeeValuesLegacy> defaultLegacyFeeValues(
    wagmi.SendTransactionParametersLegacy parameters,
  ) async {
    final gasPrice = await wagmi.Core.getGasPrice(
      wagmi.GetGasPriceParameters(),
    );
    final slippage = parameters.chainId == 1 ? 2.5 : 1.5;
    final gasPriceInWei = gasPrice.toDouble();
    final newGasPriceInWei = gasPriceInWei * slippage;
    final newGasPrice =
        wagmi.EtherAmount.fromDouble(wagmi.EtherUnit.wei, newGasPriceInWei);
    return wagmi.FeeValuesLegacy(gasPrice: newGasPrice.getInWei);
  }

  static Future<wagmi.FeeValuesEIP1559> defaultEIP1559FeeValues(
    wagmi.SendTransactionParametersEIP1559 transaction,
  ) async {
    final suggestedGasFeesResult = await suggestedGasFees(transaction.chainId!);

    final maxPriorityFeePerGas = _getMaxPriorityFeePerGas(
      suggestedGasFeesResult,
      transaction.chainId!,
    );
    return wagmi.FeeValuesEIP1559(
      maxPriorityFeePerGas: maxPriorityFeePerGas.getInWei,
      maxFeePerGas: transaction.feeValues?.maxFeePerGas ??
          (await _getMaxFeePerGas(
            suggestedGasFeesResult,
            maxPriorityFeePerGas.getInWei,
          ))
              .getInWei,
    );
  }

  static wagmi.EtherAmount _getMaxPriorityFeePerGas(
    GasFeeEstimation? suggestedGasFeesResult,
    int chainId,
  ) {
    return suggestedGasFeesResult != null &&
            suggestedGasFeesResult.medium.suggestedMaxPriorityFeePerGas
                .isValidNumber()
        ? wagmi.EtherAmount.fromDouble(
            wagmi.EtherUnit.gwei,
            math.max(
              1,
              double.tryParse(
                suggestedGasFeesResult.medium.suggestedMaxPriorityFeePerGas,
              )!,
            ),
          )
        : wagmi.EtherAmount.inWei(
            BigInt.from(chainId == 1 ? 2000000000 : 1000000000),
          );
  }

// Max Fee = (2 * Base Fee) + Max Priority Fee
  static Future<wagmi.EtherAmount> _getMaxFeePerGas(
    GasFeeEstimation? suggestedGasFeesResult,
    BigInt maxPriorityFeePerGas,
  ) async {
    if (suggestedGasFeesResult != null &&
        suggestedGasFeesResult.medium.suggestedMaxFeePerGas.isValidNumber()) {
      return wagmi.EtherAmount.fromDouble(
        wagmi.EtherUnit.gwei,
        double.tryParse(
          suggestedGasFeesResult.medium.suggestedMaxFeePerGas,
        )!,
      );
    }

    final blockInformation =
        await wagmi.Core.getBlock(wagmi.GetBlockParameters());
    final baseFeePerGas = blockInformation.baseFeePerGas;

    if (baseFeePerGas == null) {
      return wagmi.EtherAmount.zero();
    }

    return wagmi.EtherAmount.inWei(
      baseFeePerGas * BigInt.from(2) + maxPriorityFeePerGas,
    );
  }
}
