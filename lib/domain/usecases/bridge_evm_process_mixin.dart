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
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
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
  EVMWalletProvider get evmWalletProvider =>
      aedappfm.sl.get<EVMWalletProvider>();

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

    final evmLP = EVMLP();
    final resultDeployAndProvisionSignedHTLC =
        await evmLP.deployAndProvisionSignedHTLC(
      ref,
      bridge.tokenToBridge!.poolAddressTo,
      htlcContractAddressAE,
      secretHash,
      amount,
      decimal,
      endTime,
      evmWalletProvider.requestedChainId,
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
    final evmLP = EVMLP();
    final resultDeployChargeableHTLCEVM = await evmLP.deployChargeableHTLC(
      ref,
      bridge.tokenToBridge!.poolAddressFrom,
      secretHash.toString(),
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridgeDecimals,
      bridge.tokenToBridge!.typeSource != 'Native',
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
      htlcAddress,
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
    String htlcAddress,
    int decimal,
  ) async {
    double? etlcAmount;
    final htlc = EVMHTLC(
      htlcAddress,
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
    final dappClient = await aedappfm.sl.getAsync<awc.ArchethicDAppClient>();
    final resultRevealSecretToChargeableHTLC =
        await ArchethicContractChargeable().revealSecretToChargeableHTLC(
      dappClient,
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

  Future<BigInt> getBlockNumber({int? cacheTime}) async {
    return wagmi.Core.getBlockNumber(
      wagmi.GetBlockNumberParameters(
        cacheTime: cacheTime,
        chainId: evmWalletProvider.requestedChainId,
      ),
    );
  }

  Future<wagmi.GetTokenReturnType> getToken({
    required String address,
    wagmi.FormatUnit? formatUnits,
  }) async {
    return wagmi.Core.getToken(
      wagmi.GetTokenParameters(
        address: address,
        formatUnits: formatUnits,
        chainId: evmWalletProvider.requestedChainId,
      ),
    );
  }

  Future<dynamic> readContract(
    wagmi.ReadContractParameters params,
  ) async {
    return wagmi.Core.readContract(
      wagmi.ReadContractParameters(
        abi: params.abi,
        address: params.address,
        functionName: params.functionName,
        account: params.account,
        args: params.args,
        blockNumber: params.blockNumber,
        blockTag: params.blockTag,
        chainId: evmWalletProvider.requestedChainId,
      ),
    );
  }

  Future<double> getBalance(
    String address,
    String typeToken,
    int decimal, {
    String erc20address = '',
  }) async {
    try {
      switch (typeToken) {
        case 'Native':
          return double.tryParse(
                (await wagmi.Core.getBalance(
                  wagmi.GetBalanceParameters(
                    address: address,
                    chainId: evmWalletProvider.requestedChainId,
                  ),
                ))
                    .formatted,
              ) ??
              0;
        case 'Wrapped':
          if (erc20address.isEmpty) {
            return 0.0;
          }
          return double.tryParse(
                (await wagmi.Core.getBalance(
                  wagmi.GetBalanceParameters(
                    address: address,
                    token: erc20address,
                    chainId: evmWalletProvider.requestedChainId,
                  ),
                ))
                    .formatted,
              ) ??
              0;
        default:
          return 0.0;
      }
    } catch (e, stackTrace) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            '$e',
            stackTrace: stackTrace,
            level: aedappfm.LogLevel.error,
            name: 'EVMWalletProvider - getBalance',
          );
      return 0.0;
    }
  }

  Future<int> getTokenDecimals(
    String typeToken, {
    String erc20address = '',
  }) async {
    const defaultDecimal = 8;

    try {
      switch (typeToken) {
        case 'Native':
          return 18;
        case 'Wrapped':
          if (erc20address.isEmpty) {
            return defaultDecimal;
          }
          final token = await wagmi.Core.getToken(
            wagmi.GetTokenParameters(
              address: erc20address,
              chainId: evmWalletProvider.requestedChainId,
            ),
          );
          return token.decimals;
        default:
          return defaultDecimal;
      }
    } catch (e, stackTrace) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            '$e',
            stackTrace: stackTrace,
            level: aedappfm.LogLevel.error,
            name: 'EVMWalletProvider - getTokenDecimals',
          );
      return defaultDecimal;
    }
  }

  Future<String> writeContractWithErrorManagement({
    required wagmi.WriteContractParameters parameters,
    required String fromMethod,
    required WidgetRef ref,
    required EVMBridgeProcess evmBridgeProcess,
  }) async {
    try {
      final transactionHash = await wagmi.Core.writeContract(
        parameters.copyWith(chainId: evmWalletProvider.requestedChainId),
      );
      await _waitForTransactionValidation(
        chainId: evmWalletProvider.requestedChainId,
        evmBridgeProcess: evmBridgeProcess,
        fromMethod: fromMethod,
        ref: ref,
        transactionHash: transactionHash,
      );
      return transactionHash;
    } on wagmi.WagmiError catch (e, stackTrace) {
      if (e.findError(wagmi.WagmiErrors.UserRejectedRequestError) != null) {
        throw const aedappfm.Failure.userRejected();
      }
      if (e.findError(wagmi.WagmiErrors.InsufficientFundsError) != null) {
        throw const aedappfm.Failure.insufficientFunds();
      }
      aedappfm.sl.get<aedappfm.LogManager>().log(
            '${e.name} - ${e.message} - ${e.version} - ${e.cause} - ${e.details}',
            stackTrace: stackTrace,
            level: aedappfm.LogLevel.error,
            name: 'EVMBridgeProcessMixin - $fromMethod',
          );
      throw aedappfm.Failure.other(cause: e.shortMessage);
    }
  }

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
          wagmi.GetTransactionReceiptParameters(
            hash: transactionHash,
            chainId: chainId,
          ),
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
      } on wagmi.WagmiError catch (e) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              'transactionHash: $transactionHash - not found (chainId $chainId) - $e',
              name: 'EVMBridgeProcessMixin - $fromMethod',
            );
        if (e.findError(wagmi.WagmiErrors.TransactionReceiptNotFoundError) ==
            null) {
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
        htlc,
      );

      resultSignedWithdraw = await evmHTLCERC.signedWithdraw(
        ref,
        secret,
      );
    }

    if (bridge.tokenToBridge!.typeSource == 'Wrapped') {
      final evmHTLCNative = EVMHTLCNative(
        htlc,
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
  }
}

mixin FeeValuesUtils {
  static Future<wagmi.FeeValuesEIP1559> defaultEIP1559FeeValues(
    int chainId,
  ) async {
    final suggestedGasFeesResult = await _suggestedGasFees(chainId);

    final maxPriorityFeePerGas = _getMaxPriorityFeePerGas(
      suggestedGasFeesResult,
      chainId,
    );
    final maxFeePerGas = await _getMaxFeePerGas(
      suggestedGasFeesResult,
      maxPriorityFeePerGas.getInWei,
      chainId,
    );

    aedappfm.sl.get<aedappfm.LogManager>().log(
          'Default EIP1559 Fee Values (chainId: $chainId) = ${maxPriorityFeePerGas.getInWei} / ${maxFeePerGas.getInWei}',
          name: 'defaultEIP1559FeeValues',
        );

    return wagmi.FeeValuesEIP1559(
      maxPriorityFeePerGas: maxPriorityFeePerGas.getInWei,
      maxFeePerGas: maxFeePerGas.getInWei,
    );
  }

  static Future<GasFeeEstimation?> _suggestedGasFees(
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
    int chainId,
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

    final blockInformation = await wagmi.Core.getBlock(
      wagmi.GetBlockParameters(
        chainId: chainId,
      ),
    );
    final baseFeePerGas = blockInformation.baseFeePerGas;

    if (baseFeePerGas == null) {
      return wagmi.EtherAmount.zero();
    }

    return wagmi.EtherAmount.inWei(
      baseFeePerGas * BigInt.from(2) + maxPriorityFeePerGas,
    );
  }
}
