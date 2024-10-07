/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/balance.dart';
import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/application/contracts/archethic_factory.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/application/token_decimals.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.usecase.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.usecase.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aebridge/util/browser_util_web.dart';
import 'package:aebridge/util/ethereum_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:decimal/decimal.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

part 'provider.g.dart';

@riverpod
class BridgeFormNotifier extends _$BridgeFormNotifier
    with aedappfm.TransactionMixin {
  wagmi.WatchChainIdReturnType? _watchChainIdUnsubscribe;

  @override
  BridgeFormState build() {
    ref.onDispose(_unwatchChainId);

    return const BridgeFormState();
  }

  BridgeFormState get currentState => state;
  set currentState(BridgeFormState bridgeFormState) {
    state = bridgeFormState;
  }

  Future<BridgeFormState> resume(
    AppLocalizations localizations,
    BridgeFormState bridgeFormState,
  ) async {
    await setBlockchainFromWithConnection(
      localizations,
      bridgeFormState.blockchainFrom!,
    );

    await setBlockchainToWithConnection(
      localizations,
      bridgeFormState.blockchainTo!,
    );

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
      secret: bridgeFormState.secret,
      targetAddress: bridgeFormState.targetAddress,
      tokenBridgedBalance: bridgeFormState.tokenBridgedBalance,
      tokenToBridge: bridgeFormState.tokenToBridge,
      tokenToBridgeAmount: bridgeFormState.tokenToBridgeAmount,
      tokenToBridgeBalance: bridgeFormState.tokenToBridgeBalance,
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
    await ref.read(bridgeHistoryRepositoryProvider).setBridge(
          bridge: state.toJson(),
        );
  }

  void setResumeProcess(bool resumeProcess) {
    state = state.copyWith(resumeProcess: resumeProcess);
  }

  void setRequestTooLong(bool requestTooLong) {
    state = state.copyWith(requestTooLong: requestTooLong);
  }

  void setChainIdUpdated(bool chainIdUpdated) {
    state = state.copyWith(chainIdUpdated: chainIdUpdated);
  }

  Future<void> setBlockchainFrom(
    AppLocalizations localizations,
    BridgeBlockchain? blockchainFrom,
  ) async {
    state = state.copyWith(blockchainFrom: blockchainFrom);
    await storeBridge();
  }

  Future<void> setBlockchainFromWithConnection(
    AppLocalizations localizations,
    BridgeBlockchain blockchainFrom,
  ) async {
    final sessionNotifier = ref.read(sessionNotifierProvider.notifier);
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
        localizations,
        true,
        blockchainFrom,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      await connection.map(
        success: (success) async {
          await setBlockchainFrom(localizations, blockchainFrom);
        },
        failure: (failure) async {
          await setBlockchainFrom(localizations, null);
          await setFailure(failure);
        },
      );
    } else {
      final connection =
          await sessionNotifier.connectToEVMWallet(blockchainFrom, true);
      await connection.map(
        success: (success) async {
          await setBlockchainFrom(localizations, blockchainFrom);
          final blockchainTo = await ref.read(
            getArchethicBlockchainFromEVMProvider(
              blockchainFrom,
            ).future,
          );
          if (blockchainTo != null && state.failure == null) {
            await setBlockchainToWithConnection(localizations, blockchainTo);
          }
        },
        failure: (failure) async {
          await setBlockchainFrom(localizations, null);
          await setFailure(failure);
        },
      );
    }
  }

  Future<void> setBlockchainTo(
    AppLocalizations localizations,
    BridgeBlockchain? blockchainTo,
  ) async {
    state = state.copyWith(blockchainTo: blockchainTo);
    await storeBridge();
  }

  Future<void> setBlockchainToWithConnection(
    AppLocalizations localizations,
    BridgeBlockchain blockchainTo,
  ) async {
    final sessionNotifier = ref.read(sessionNotifierProvider.notifier);
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
        localizations,
        false,
        blockchainTo,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      await connection.map(
        success: (success) async {
          await setBlockchainTo(localizations, blockchainTo);
        },
        failure: (failure) async {
          await setBlockchainTo(localizations, null);
          await setFailure(failure);
        },
      );
    } else {
      final connection =
          await sessionNotifier.connectToEVMWallet(blockchainTo, false);
      await connection.map(
        success: (success) async {
          await setBlockchainTo(localizations, blockchainTo);
          final blockchainFrom = await ref.read(
            getArchethicBlockchainFromEVMProvider(
              blockchainTo,
            ).future,
          );
          if (blockchainFrom != null && state.failure == null) {
            await setBlockchainFromWithConnection(
              localizations,
              blockchainFrom,
            );
          }
        },
        failure: (failure) async {
          await setBlockchainTo(localizations, null);
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
    final session = ref.read(sessionNotifierProvider);
    if (session.walletTo != null &&
        session.walletTo!.genesisAddress.isNotEmpty) {
      await setTargetAddress(session.walletTo!.genesisAddress);
    }

    if (tokenToBridge == null) return;

    final tokenToBridgeDecimals = await ref.read(
      getTokenDecimalsProvider(
        state.blockchainFrom!.isArchethic,
        state.tokenToBridge!.typeSource,
        state.tokenToBridge!.tokenAddressSource,
      ).future,
    );
    await setTokenToBridgeDecimals(tokenToBridgeDecimals);

    final tokenBridgedDecimals = await ref.read(
      getTokenDecimalsProvider(
        state.blockchainTo!.isArchethic,
        state.tokenToBridge!.typeTarget,
        state.tokenToBridge!.tokenAddressTarget,
      ).future,
    );
    await setTokenBridgedDecimals(tokenBridgedDecimals);

    final balance = await ref.read(
      getBalanceProvider(
        state.blockchainFrom!.isArchethic,
        session.walletFrom!.genesisAddress,
        state.tokenToBridge!.typeSource,
        state.tokenToBridge!.tokenAddressSource,
        state.blockchainFrom!.isArchethic ? 8 : state.tokenToBridgeDecimals,
      ).future,
    );
    await setTokenToBridgeBalance(balance);

    if (state.tokenToBridge!.ucoV1Address.isNotEmpty) {
      final tokenToBridgeUCOV1Decimals = await ref.read(
        getTokenDecimalsProvider(
          state.blockchainFrom!.isArchethic,
          state.tokenToBridge!.typeSource,
          state.tokenToBridge!.ucoV1Address,
        ).future,
      );

      final ucoV1Balance = await ref.read(
        getBalanceProvider(
          false,
          session.walletFrom!.genesisAddress,
          state.tokenToBridge!.typeSource,
          state.tokenToBridge!.ucoV1Address,
          tokenToBridgeUCOV1Decimals,
        ).future,
      );
      await setUCOV1Balance(ucoV1Balance);
    }

    final tokenDecimals = await ref.read(
      getTokenDecimalsProvider(
        state.blockchainFrom!.isArchethic,
        state.tokenToBridge!.typeSource,
        state.tokenToBridge!.tokenAddressSource,
      ).future,
    );
    await setTokenToBridgeDecimals(tokenDecimals);

    final balanceTarget = await ref.read(
      getBalanceProvider(
        state.blockchainTo!.isArchethic,
        session.walletTo!.genesisAddress,
        state.tokenToBridge!.typeTarget,
        state.tokenToBridge!.tokenAddressTarget,
        state.blockchainTo!.isArchethic ? 8 : state.tokenBridgedDecimals,
      ).future,
    );
    await setTokenBridgedBalance(balanceTarget);

    setPoolTargetBalance(0);
    if (state.blockchainTo!.isArchethic == false &&
        state.tokenToBridge!.contractToMintAndBurn != null &&
        state.tokenToBridge!.contractToMintAndBurn == false) {
      final poolTargetBalance = await ref.read(
        getBalanceProvider(
          state.blockchainTo!.isArchethic,
          state.tokenToBridge!.poolAddressTo,
          state.tokenToBridge!.typeTarget,
          state.tokenToBridge!.tokenAddressTarget,
          state.tokenBridgedDecimals,
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

  Future<void> setUCOV1Balance(
    double ucoV1Balance,
  ) async {
    state = state.copyWith(
      ucoV1Balance: ucoV1Balance,
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

  Future<void> setTokenBridgedDecimals(
    int tokenBridgedDecimals,
  ) async {
    state = state.copyWith(
      tokenBridgedDecimals: tokenBridgedDecimals,
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
      failure: null,
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
      failure: null,
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
          .floor(scale: state.tokenBridgedDecimals)
          .toDouble(),
    );
  }

  Future<void> setMaxHalf() async {
    await setTokenToBridgeAmount(
      (Decimal.parse(state.tokenToBridgeBalance.toString()) /
              Decimal.parse('2'))
          .toDecimal()
          .floor(scale: state.tokenBridgedDecimals)
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
    AppLocalizations localizations,
    aedappfm.ProcessStep bridgeProcessStep,
  ) async {
    if (bridgeProcessStep == aedappfm.ProcessStep.confirmation &&
        await control(localizations) == false) {
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
      archethicProtocolFeesAddress: '',
      messageMaxHalfUCO: false,
    );
  }

  Future<void> setCurrentStep(int currentStep) async {
    state = state.copyWith(currentStep: currentStep);
    await storeBridge();
  }

  Future<void> swapDirections(
    AppLocalizations localizations,
  ) async {
    await setChangeDirectionInProgress(true);
    final sessionNotifier = ref.read(sessionNotifierProvider.notifier);
    await sessionNotifier.cancelAllWalletsConnection();
    final blockchainFrom = state.blockchainFrom;
    final blockchainTo = state.blockchainTo;
    initState();
    if (blockchainFrom != null) {
      await setBlockchainToWithConnection(localizations, blockchainFrom);
    }
    if (blockchainTo != null) {
      await setBlockchainFromWithConnection(localizations, blockchainTo);
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

  Future<bool> control(
    AppLocalizations localizations,
  ) async {
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
        aedappfm.Failure.other(
          cause: localizations.bridgeControlSelectIssuingBC,
        ),
      );
      return false;
    }
    if (state.blockchainTo == null && state.blockchainTo!.name.isEmpty) {
      await setFailure(
        aedappfm.Failure.other(
          cause: localizations.bridgeControlSelectReceivingBC,
        ),
      );
      return false;
    }
    if (state.tokenToBridge == null && state.tokenToBridge!.name.isEmpty) {
      await setFailure(
        aedappfm.Failure.other(
          cause: localizations.bridgeControlSelectToken,
        ),
      );
      return false;
    }
    if (state.targetAddress.isEmpty) {
      await setFailure(
        aedappfm.Failure.other(
          cause: localizations.bridgeControlTargetAddress,
        ),
      );
      return false;
    }
    if (state.blockchainTo!.isArchethic) {
      if (archethic.Address(address: state.targetAddress).isValid() == false) {
        await setFailure(
          aedappfm.Failure.other(
            cause: localizations.bridgeControlTargetArchethicAddressValid,
          ),
        );
        return false;
      }
    } else {
      if (EVMUtil.isValidEVMAddress(state.targetAddress) == false) {
        await setFailure(
          aedappfm.Failure.other(
            cause: localizations.bridgeControlTargetEVMAddressValid,
          ),
        );
        return false;
      }
    }

    if (state.tokenToBridgeAmount.isNaN || state.tokenToBridgeAmount <= 0) {
      await setFailure(
        aedappfm.Failure.other(
          cause: localizations.bridgeControlAmount,
        ),
      );
      return false;
    }

    if (state.resumeProcess == false &&
        state.tokenToBridgeBalance < state.tokenToBridgeAmount) {
      await setFailure(
        aedappfm.Failure.other(
          cause: localizations.bridgeControlAmountTooHigh,
        ),
      );
      return false;
    }

    if (state.blockchainFrom!.isArchethic &&
        state.tokenToBridge!.contractToMintAndBurn == false &&
        state.poolTargetBalance < state.tokenToBridgeAmount) {
      await setFailure(
        aedappfm.Failure.other(
          cause: localizations.bridgeControlInsufficicientLiquidity
              .replaceFirst('%1', state.poolTargetBalance.formatNumber())
              .replaceFirst('%2', state.tokenToBridge!.targetTokenSymbol),
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

  Future<void> validateForm(
    AppLocalizations localizations,
  ) async {
    state = state.copyWith(controlInProgress: true);
    if (state.blockchainTo != null &&
        state.blockchainTo!.isArchethic == false) {
      final archethicProtocolFees = await ArchethicFactory(
        state.blockchainFrom!.isArchethic
            ? state.blockchainFrom!.archethicFactoryAddress!
            : state.blockchainTo!.archethicFactoryAddress!,
      ).calculateArchethicProtocolFees();
      await setArchethicProtocolFeesRate(archethicProtocolFees.rate);
      await setArchethicProtocolFeesAddress(archethicProtocolFees.address);
    } else {
      await setArchethicProtocolFeesRate(0);
      await setArchethicProtocolFeesAddress('');
    }

    final session = ref.read(sessionNotifierProvider);
    DateTime? consentDateTime;
    if (state.blockchainFrom!.isArchethic) {
      consentDateTime = await aedappfm.ConsentRepositoryImpl()
          .getConsentTime(session.walletFrom!.genesisAddress);
    } else {
      consentDateTime = await aedappfm.ConsentRepositoryImpl()
          .getConsentTime(session.walletTo!.genesisAddress);
    }
    state = state.copyWith(consentDateTime: consentDateTime);

    state = state.copyWith(controlInProgress: false);

    await setBridgeProcessStep(
      localizations,
      aedappfm.ProcessStep.confirmation,
    );
  }

  Future<void> bridge(AppLocalizations localizations, WidgetRef ref) async {
    setBridgeOk(false);
    await setTransferInProgress(true);

    //

    if (await control(localizations) == false) {
      await setTransferInProgress(false);
      return;
    }

    final session = ref.read(sessionNotifierProvider);

    await _watchChainId();

    if (state.resumeProcess == false) {
      setTimestampExec(DateTime.now().millisecondsSinceEpoch);
      await ref
          .read(bridgeHistoryRepositoryProvider)
          .addBridge(bridge: state.toJson());
    }
    final dappClient = aedappfm.sl.get<awc.ArchethicDAppClient>();
    if (state.blockchainFrom!.isArchethic) {
      await aedappfm.ConsentRepositoryImpl()
          .addAddress(session.walletFrom!.genesisAddress);

      await BridgeArchethicToEVMUseCase(dappClient: dappClient).run(
        localizations,
        ref,
        recoveryStep: state.currentStep,
        recoveryHTLCAEAddress: state.htlcAEAddress,
        recoveryHTLCEVMAddress: state.htlcEVMAddress,
      );
    } else {
      await aedappfm.ConsentRepositoryImpl()
          .addAddress(session.walletTo!.genesisAddress);

      await BridgeEVMToArchethicUseCase().run(
        localizations,
        ref,
        recoveryStep: state.currentStep,
        recoverySecret: state.secret,
        recoveryHTLCAEAddress: state.htlcAEAddress,
        recoveryHTLCEVMAddress: state.htlcEVMAddress,
      );
    }
    setResumeProcess(false);
    await setTransferInProgress(false);

    _unwatchChainId();

    unawaited(refreshCurrentAccountInfoWallet(dappClient));
  }

  Future<void> _watchChainId() async {
    _unwatchChainId();
    final watchChainIdParameters = wagmi.WatchChainIdParameters(
      onChange: (chainId, prevChainId) {
        if (chainId != prevChainId) setChainIdUpdated(true);
      },
    );
    _watchChainIdUnsubscribe = await wagmi.Core.watchChainId(
      watchChainIdParameters,
    );
  }

  void _unwatchChainId() {
    setChainIdUpdated(false);
    if (_watchChainIdUnsubscribe != null) {
      _watchChainIdUnsubscribe?.call();
      _watchChainIdUnsubscribe = null;
    }
  }
}
