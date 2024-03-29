/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer';

import 'package:aebridge/application/balance.dart';
import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/application/contracts/archethic_factory.dart';
import 'package:aebridge/application/contracts/evm_lp.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/application/token_decimals.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.usecase.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.usecase.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aebridge/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webthree/webthree.dart' as webthree;

part 'provider.g.dart';

@riverpod
class _BridgeFormNotifier extends AutoDisposeNotifier<BridgeFormState>
    with aedappfm.TransactionMixin {
  @override
  BridgeFormState build() {
    return const BridgeFormState();
  }

  BridgeFormState get currentState => state;
  set currentState(BridgeFormState bridgeFormState) {
    state = bridgeFormState;
  }

  Future<BridgeFormState> resume(BridgeFormState bridgeFormState) async {
    await setBlockchainFromWithConnection(bridgeFormState.blockchainFrom!);
    await setBlockchainToWithConnection(bridgeFormState.blockchainTo!);
    state = bridgeFormState.copyWith(
      archethicOracleUCO: bridgeFormState.archethicOracleUCO,
      archethicProtocolFeesAddress:
          bridgeFormState.archethicProtocolFeesAddress,
      archethicProtocolFeesRate: bridgeFormState.archethicProtocolFeesRate,
      archethicTransactionFees: bridgeFormState.archethicTransactionFees,
      htlcAEAddress: bridgeFormState.htlcAEAddress,
      htlcEVMAddress: bridgeFormState.htlcEVMAddress,
      htlcEVMTxAddress: bridgeFormState.htlcEVMTxAddress,
      poolTargetBalance: bridgeFormState.poolTargetBalance,
      safetyModuleFeesAddress: bridgeFormState.safetyModuleFeesAddress,
      safetyModuleFeesRate: bridgeFormState.safetyModuleFeesRate,
      secret: bridgeFormState.secret,
      targetAddress: bridgeFormState.targetAddress,
      tokenBridgedBalance: bridgeFormState.tokenBridgedBalance,
      tokenToBridge: bridgeFormState.tokenToBridge,
      tokenToBridgeAmount: bridgeFormState.tokenToBridgeAmount,
      tokenToBridgeBalance: bridgeFormState.tokenBridgedBalance,
      tokenToBridgeDecimals: bridgeFormState.tokenToBridgeDecimals,
      resumeProcess: true,
      processStep: aedappfm.ProcessStep.confirmation,
      isTransferInProgress: false,
      changeDirectionInProgress: false,
      walletConfirmation: null,
      timestampExec: bridgeFormState.timestampExec,
    );
    await setFailure(bridgeFormState.failure);
    return state;
  }

  Future<void> storeBridge() async {
    // We store infos only if timestampExec is initialized
    if (state.timestampExec == null) {
      return;
    }
    await ref.read(BridgeHistoryProviders.bridgeHistoryRepository).setBridge(
          bridge: state.toJson(),
        );
  }

  void setResumeProcess(bool resumeProcess) {
    state = state.copyWith(resumeProcess: resumeProcess);
  }

  Future<void> setBlockchainFrom(
    BridgeBlockchain? blockchainFrom,
  ) async {
    state = state.copyWith(blockchainFrom: blockchainFrom);
    await storeBridge();

    // Check provider's endpoint
    if (blockchainFrom != null && blockchainFrom.isArchethic == false) {
      final client = webthree.Web3Client(
        blockchainFrom.providerEndpoint,
        Client(),
      );

      try {
        await client.getBlockNumber();
      } catch (e) {
        log('Web3Client endpoint error for ${blockchainFrom.providerEndpoint} : $e');
        await setFailure(
          const aedappfm.Failure.other(
            cause:
                "The provider's endpoint is not available. Please contact Archethic support.",
          ),
        );
      } finally {
        await client.dispose();
      }
    }
  }

  Future<void> setBlockchainFromWithConnection(
    BridgeBlockchain blockchainFrom,
  ) async {
    final sessionNotifier = ref.read(SessionProviders.session.notifier);
    state = state.copyWith(
      blockchainFrom: null,
      targetAddress: '',
      tokenToBridge: null,
      tokenToBridgeAmount: 0,
      tokenToBridgeBalance: 0,
      tokenBridgedBalance: 0,
      poolTargetBalance: 0,
      tokenToBridgeDecimals: 8,
      timestampExec: null,
      messageMaxHalfUCO: false,
    );
    await setFailure(null);
    if (blockchainFrom.isArchethic) {
      final connection = await sessionNotifier.connectToArchethicWallet(
        true,
        blockchainFrom,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      await connection.map(
        success: (success) async {
          await setBlockchainFrom(blockchainFrom);
        },
        failure: (failure) async {
          await setBlockchainFrom(null);
          await setFailure(failure);
        },
      );
    } else {
      final connection =
          await sessionNotifier.connectToEVMWallet(blockchainFrom, true);
      await connection.map(
        success: (success) async {
          await setBlockchainFrom(blockchainFrom);
          final blockchainTo = await ref.read(
            BridgeBlockchainsProviders.getArchethicBlockchainFromEVM(
              blockchainFrom,
            ).future,
          );
          if (blockchainTo != null && state.failure == null) {
            await setBlockchainToWithConnection(blockchainTo);
          }
        },
        failure: (failure) async {
          await setBlockchainFrom(null);
          await setFailure(failure);
        },
      );
    }
  }

  Future<void> setBlockchainTo(
    BridgeBlockchain? blockchainTo,
  ) async {
    state = state.copyWith(blockchainTo: blockchainTo);
    await storeBridge();

    // Check provider's endpoint
    if (blockchainTo != null && blockchainTo.isArchethic == false) {
      final client = webthree.Web3Client(
        blockchainTo.providerEndpoint,
        Client(),
      );

      try {
        await client.getBlockNumber();
      } catch (e) {
        log('Web3Client endpoint error for ${blockchainTo.providerEndpoint} : $e');
        await setFailure(
          const aedappfm.Failure.other(
            cause:
                "The provider's endpoint is not available. Please contact Archethic support.",
          ),
        );
      } finally {
        await client.dispose();
      }
    }
  }

  Future<void> setBlockchainToWithConnection(
    BridgeBlockchain blockchainTo,
  ) async {
    final sessionNotifier = ref.read(SessionProviders.session.notifier);
    state = state.copyWith(
      targetAddress: '',
      tokenToBridge: null,
      tokenToBridgeAmount: 0,
      tokenToBridgeBalance: 0,
      tokenBridgedBalance: 0,
      poolTargetBalance: 0,
      tokenToBridgeDecimals: 8,
      timestampExec: null,
      messageMaxHalfUCO: false,
    );

    await setFailure(null);
    if (blockchainTo.isArchethic) {
      final connection = await sessionNotifier.connectToArchethicWallet(
        false,
        blockchainTo,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      await connection.map(
        success: (success) async {
          await setBlockchainTo(blockchainTo);
        },
        failure: (failure) async {
          await setBlockchainTo(null);
          await setFailure(failure);
        },
      );
    } else {
      final connection =
          await sessionNotifier.connectToEVMWallet(blockchainTo, false);
      await connection.map(
        success: (success) async {
          await setBlockchainTo(blockchainTo);
          final blockchainFrom = await ref.read(
            BridgeBlockchainsProviders.getArchethicBlockchainFromEVM(
              blockchainTo,
            ).future,
          );
          if (blockchainFrom != null && state.failure == null) {
            await setBlockchainFromWithConnection(blockchainFrom);
          }
        },
        failure: (failure) async {
          await setBlockchainTo(null);
          await setFailure(failure);
        },
      );
    }
  }

  Future<void> setTransferInProgress(bool isTransferInProgress) async {
    state = state.copyWith(isTransferInProgress: isTransferInProgress);
    await storeBridge();
  }

  Future<void> setTokenToBridge(
    BridgeToken? tokenToBridge,
  ) async {
    state = state.copyWith(
      tokenToBridge: tokenToBridge,
      messageMaxHalfUCO: false,
    );
    await storeBridge();
    final session = ref.read(SessionProviders.session);
    if (session.walletTo != null &&
        session.walletTo!.genesisAddress.isNotEmpty) {
      await setTargetAddress(session.walletTo!.genesisAddress);
    }

    if (tokenToBridge == null) return;

    final balance = await ref.read(
      BalanceProviders.getBalance(
        state.blockchainFrom!.isArchethic,
        session.walletFrom!.genesisAddress,
        state.tokenToBridge!.typeSource,
        state.tokenToBridge!.tokenAddressSource,
        providerEndpoint: state.blockchainFrom!.providerEndpoint,
      ).future,
    );
    await setTokenToBridgeBalance(balance);

    final tokenDecimals = await ref.read(
      TokenDecimalsProviders.getTokenDecimals(
        state.blockchainFrom!.isArchethic,
        state.tokenToBridge!.typeSource,
        state.tokenToBridge!.tokenAddressSource,
        providerEndpoint: state.blockchainFrom!.providerEndpoint,
      ).future,
    );
    await setTokenToBridgeDecimals(tokenDecimals);

    final balanceTarget = await ref.read(
      BalanceProviders.getBalance(
        state.blockchainTo!.isArchethic,
        session.walletTo!.genesisAddress,
        state.tokenToBridge!.typeTarget,
        state.tokenToBridge!.tokenAddressTarget,
        providerEndpoint: state.blockchainTo!.providerEndpoint,
      ).future,
    );
    await setTokenBridgedBalance(balanceTarget);

    if (state.blockchainTo!.isArchethic == false) {
      final poolTargetBalance = await ref.read(
        BalanceProviders.getBalance(
          state.blockchainTo!.isArchethic,
          state.tokenToBridge!.poolAddressTo,
          state.tokenToBridge!.typeTarget,
          state.tokenToBridge!.tokenAddressTarget,
          providerEndpoint: state.blockchainTo!.providerEndpoint,
        ).future,
      );
      setPoolTargetBalance(poolTargetBalance);
    }
  }

  Future<void> setTokenToBridgeBalance(
    double tokenToBridgeBalance,
  ) async {
    state = state.copyWith(
      tokenToBridgeBalance: tokenToBridgeBalance,
    );
    await storeBridge();
  }

  Future<void> setTokenToBridgeDecimals(
    int tokenToBridgeDecimals,
  ) async {
    state = state.copyWith(
      tokenToBridgeDecimals: tokenToBridgeDecimals,
    );
    await storeBridge();
  }

  Future<void> setTokenBridgedBalance(
    double tokenBridgedBalance,
  ) async {
    state = state.copyWith(
      tokenBridgedBalance: tokenBridgedBalance,
    );
    await storeBridge();
  }

  void setPoolTargetBalance(
    double poolTargetBalance,
  ) {
    state = state.copyWith(
      poolTargetBalance: poolTargetBalance,
    );
  }

  Future<void> setTokenToBridgeAmount(
    double tokenToBridgeAmount,
  ) async {
    state = state.copyWith(
      tokenToBridgeAmount: tokenToBridgeAmount,
      messageMaxHalfUCO: false,
    );
    await storeBridge();
  }

  Future<void> setFailure(
    aedappfm.Failure? failure,
  ) async {
    state = state.copyWith(
      failure: failure,
    );
    await storeBridge();
  }

  void setMessageMaxHalfUCO(
    bool messageMaxHalfUCO,
  ) {
    state = state.copyWith(
      messageMaxHalfUCO: messageMaxHalfUCO,
    );
  }

  Future<void> setTargetAddress(
    String targetAddress,
  ) async {
    state = state.copyWith(
      targetAddress: targetAddress,
    );
    await storeBridge();
  }

  void setBridgeOk(bool bridgeOk) {
    state = state.copyWith(
      bridgeOk: bridgeOk,
    );
  }

  Future<void> setMaxAmount() async {
    await setTokenToBridgeAmount(
      Decimal.parse(state.tokenToBridgeBalance.toString())
          .floor(scale: state.tokenToBridgeDecimals)
          .toDouble(),
    );
  }

  Future<void> setMaxHalf() async {
    await setTokenToBridgeAmount(
      (Decimal.parse(state.tokenToBridgeBalance.toString()) /
              Decimal.parse('2'))
          .toDecimal()
          .floor(scale: state.tokenToBridgeDecimals)
          .toDouble(),
    );
    await storeBridge();
  }

  Future<void> setWalletConfirmation(
    WalletConfirmation? walletConfirmation,
  ) async {
    state = state.copyWith(
      walletConfirmation: walletConfirmation,
    );
    await storeBridge();
  }

  Future<void> setBridgeProcessStep(
    aedappfm.ProcessStep bridgeProcessStep,
  ) async {
    if (bridgeProcessStep == aedappfm.ProcessStep.confirmation &&
        await control() == false) {
      return;
    }
    state = state.copyWith(
      processStep: bridgeProcessStep,
    );
    await storeBridge();
  }

  void initState() {
    state = state.copyWith(
      blockchainFrom: null,
      blockchainTo: null,
      processStep: aedappfm.ProcessStep.form,
      currentStep: 0,
      failure: null,
      isTransferInProgress: false,
      safetyModuleFeesRate: 0,
      archethicProtocolFeesRate: 0,
      archethicTransactionFees: 0,
      targetAddress: '',
      tokenToBridge: null,
      tokenToBridgeAmount: 0,
      tokenToBridgeBalance: 0,
      tokenBridgedBalance: 0,
      poolTargetBalance: 0,
      tokenToBridgeDecimals: 8,
      timestampExec: null,
      htlcAEAddress: null,
      htlcEVMAddress: null,
      resumeProcess: false,
      secret: null,
      archethicOracleUCO: null,
      safetyModuleFeesAddress: '',
      archethicProtocolFeesAddress: '',
      messageMaxHalfUCO: false,
    );
  }

  Future<void> setCurrentStep(int currentStep) async {
    state = state.copyWith(currentStep: currentStep);
    await storeBridge();
  }

  Future<void> swapDirections() async {
    await setChangeDirectionInProgress(true);
    final sessionNotifier = ref.read(SessionProviders.session.notifier);
    await sessionNotifier.cancelAllWalletsConnection();
    final blockchainFrom = state.blockchainFrom;
    final blockchainTo = state.blockchainTo;
    initState();
    if (blockchainFrom != null) {
      await setBlockchainToWithConnection(blockchainFrom);
    }
    if (blockchainTo != null) {
      await setBlockchainFromWithConnection(blockchainTo);
    }
    await setTokenToBridge(null);
    await setTokenToBridgeAmount(0);
    await setChangeDirectionInProgress(false);
  }

  Future<void> setChangeDirectionInProgress(
    bool changeDirectionInProgress,
  ) async {
    state =
        state.copyWith(changeDirectionInProgress: changeDirectionInProgress);
    await storeBridge();
  }

  Future<void> setSafetyModuleFeesRate(double rate) async {
    state = state.copyWith(
      safetyModuleFeesRate: rate,
    );
    await storeBridge();
  }

  Future<void> setSafetyModuleFeesAddress(String address) async {
    state = state.copyWith(
      safetyModuleFeesAddress: address,
    );
    await storeBridge();
  }

  Future<void> setArchethicProtocolFeesAddress(String address) async {
    state = state.copyWith(
      archethicProtocolFeesAddress: address,
    );
    await storeBridge();
  }

  Future<void> setArchethicProtocolFeesRate(double rate) async {
    state = state.copyWith(
      archethicProtocolFeesRate: rate,
    );
    await storeBridge();
  }

  Future<void> setArchethicTransactionFees(double fees) async {
    state = state.copyWith(
      archethicTransactionFees: fees,
    );
    await storeBridge();
  }

  void setTimestampExec(int timestampExec) {
    state = state.copyWith(timestampExec: timestampExec);
  }

  Future<void> setHTLCAEAddress(String? htlcAEAddress) async {
    state = state.copyWith(
      htlcAEAddress: htlcAEAddress,
    );
    await storeBridge();
  }

  Future<void> setHTLCEVMAddress(String? htlcEVMAddress) async {
    state = state.copyWith(
      htlcEVMAddress: htlcEVMAddress,
    );
    await storeBridge();
  }

  Future<void> setHTLCEVMTxAddress(String htlcEVMTxAddress) async {
    state = state.copyWith(
      htlcEVMTxAddress: htlcEVMTxAddress,
    );
    await storeBridge();
  }

  Future<void> setSecret(List<int> secret) async {
    state = state.copyWith(
      secret: secret,
    );
    await storeBridge();
  }

  Future<void> setArchethicOracleUCO(
    int timestamp,
    double eur,
    double usd,
  ) async {
    state = state.copyWith(
      archethicOracleUCO: aedappfm.ArchethicOracleUCO(
        timestamp: timestamp,
        eur: eur,
        usd: usd,
      ),
    );
    await storeBridge();
  }

  Future<bool> control() async {
    await setFailure(null);
    setMessageMaxHalfUCO(false);
    if (BrowserUtil().isEdgeBrowser() ||
        BrowserUtil().isInternetExplorerBrowser()) {
      await setFailure(
        const aedappfm.Failure.incompatibleBrowser(),
      );
      return false;
    }

    if (state.blockchainFrom == null && state.blockchainFrom!.name.isEmpty) {
      await setFailure(
        const aedappfm.Failure.other(
          cause: 'Please select the issuing blockchain.',
        ),
      );
      return false;
    }
    if (state.blockchainTo == null && state.blockchainTo!.name.isEmpty) {
      await setFailure(
        const aedappfm.Failure.other(
          cause: 'Please select the receiving blockchain.',
        ),
      );
      return false;
    }
    if (state.tokenToBridge == null && state.tokenToBridge!.name.isEmpty) {
      await setFailure(
        const aedappfm.Failure.other(
          cause: 'Please select the token to transfer.',
        ),
      );
      return false;
    }
    if (state.targetAddress.isEmpty) {
      await setFailure(
        const aedappfm.Failure.other(
          cause:
              'Please enter your receiving address on the target blockchain.',
        ),
      );
      return false;
    }
    if (state.blockchainTo!.isArchethic) {
      if (archethic.Address(address: state.targetAddress).isValid() == false) {
        await setFailure(
          const aedappfm.Failure.other(
            cause: 'Please enter a valid Archethic address.',
          ),
        );
        return false;
      }
    } else {
      try {
        webthree.EthereumAddress.fromHex(
          state.targetAddress,
        );
      } catch (e) {
        await setFailure(
          const aedappfm.Failure.other(cause: 'Please enter a valid address.'),
        );
        return false;
      }
    }

    if (state.tokenToBridgeAmount.isNaN || state.tokenToBridgeAmount <= 0) {
      await setFailure(
        const aedappfm.Failure.other(
          cause: 'Please enter the amount of tokens to transfer.',
        ),
      );
      return false;
    }

    if (state.resumeProcess == false &&
        state.tokenToBridgeBalance < state.tokenToBridgeAmount) {
      await setFailure(
        const aedappfm.Failure.other(
          cause: 'Your amount exceeds your balance. Please adjust your amount.',
        ),
      );
      return false;
    }

    if (state.blockchainFrom!.isArchethic &&
        state.poolTargetBalance < state.tokenToBridgeAmount) {
      await setFailure(
        aedappfm.Failure.other(
          cause:
              "Sorry, but your request can't be completed due to insufficient liquidity on the destination chain. The current available liquidity is ${state.poolTargetBalance.formatNumber()} ${state.tokenToBridge!.targetTokenSymbol}.",
        ),
      );
      return false;
    }

    const kFeesEstimatedUCOBridge = 2.0;
    if (state.blockchainFrom!.isArchethic &&
        state.tokenToBridge!.symbol == 'UCO' &&
        state.tokenToBridgeAmount + kFeesEstimatedUCOBridge >
            state.tokenToBridgeBalance) {
      state = state.copyWith(feesEstimatedUCO: kFeesEstimatedUCOBridge);
      final adjustedAmount =
          state.tokenToBridgeAmount - kFeesEstimatedUCOBridge;
      if (adjustedAmount < 0) {
        state = state.copyWith(messageMaxHalfUCO: true);
        await setFailure(const aedappfm.Failure.insufficientFunds());
        return false;
      } else {
        await setTokenToBridgeAmount(adjustedAmount);
        state = state.copyWith(messageMaxHalfUCO: true);
      }
    }

    return true;
  }

  Future<void> validateForm() async {
    if (state.blockchainFrom!.isArchethic == false) {
      final evmLP = EVMLP(
        state.blockchainFrom!.isArchethic
            ? state.blockchainTo!.providerEndpoint
            : state.blockchainFrom!.providerEndpoint,
      );

      final safetyModuleFees = await evmLP.calculateSafetyModuleFees(
        state.blockchainFrom!.isArchethic
            ? state.tokenToBridge!.poolAddressTo
            : state.tokenToBridge!.poolAddressFrom,
      );
      await setSafetyModuleFeesRate(safetyModuleFees.rate);
      await setSafetyModuleFeesAddress(safetyModuleFees.address);
    } else {
      await setSafetyModuleFeesRate(0);
      await setSafetyModuleFeesAddress('');
    }

    final archethicProtocolFees = await ArchethicFactory(
      state.blockchainFrom!.isArchethic
          ? state.blockchainFrom!.archethicFactoryAddress!
          : state.blockchainTo!.archethicFactoryAddress!,
    ).calculateArchethicProtocolFees();
    await setArchethicProtocolFeesRate(archethicProtocolFees.rate);
    await setArchethicProtocolFeesAddress(archethicProtocolFees.address);

    //final aeHTLCFees = await ArchethicContract().estimateDeployHTLCFees();

    await setBridgeProcessStep(
      aedappfm.ProcessStep.confirmation,
    );
  }

  Future<void> bridge(BuildContext context, WidgetRef ref) async {
    setBridgeOk(false);
    await setTransferInProgress(true);

    //
    if (await control() == false) {
      await setTransferInProgress(false);
      return;
    }

    if (state.resumeProcess == false) {
      setTimestampExec(DateTime.now().millisecondsSinceEpoch);
      await ref
          .read(BridgeHistoryProviders.bridgeHistoryRepository)
          .addBridge(bridge: state.toJson());
    }

    if (state.blockchainFrom!.isArchethic) {
      await BridgeArchethicToEVMUseCase().run(
        ref,
        recoveryStep: state.currentStep,
        recoveryHTLCAEAddress: state.htlcAEAddress,
        recoveryHTLCEVMAddress: state.htlcEVMAddress,
      );
    } else {
      await BridgeEVMToArchethicUseCase().run(
        ref,
        recoveryStep: state.currentStep,
        recoverySecret: state.secret,
        recoveryHTLCAEAddress: state.htlcAEAddress,
        recoveryHTLCEVMAddress: state.htlcEVMAddress,
      );
    }
    setResumeProcess(false);
    await setTransferInProgress(false);
    unawaited(refreshCurrentAccountInfoWallet());
  }
}

abstract class BridgeFormProvider {
  static final bridgeForm = _bridgeFormNotifierProvider;
}
