/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer';

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
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webthree/webthree.dart' as webthree;

part 'provider.g.dart';

@riverpod
class _BridgeFormNotifier extends _$BridgeFormNotifier
    with aedappfm.TransactionMixin {
  @override
  BridgeFormState build() {
    return const BridgeFormState();
  }

  BridgeFormState get currentState => state;
  set currentState(BridgeFormState bridgeFormState) {
    state = bridgeFormState;
  }

  Future<BridgeFormState> resume(
    BuildContext context,
    BridgeFormState bridgeFormState,
  ) async {
    await setBlockchainFromWithConnection(
      context,
      bridgeFormState.blockchainFrom!,
    );
    if (context.mounted) {
      await setBlockchainToWithConnection(
        context,
        bridgeFormState.blockchainTo!,
      );
    }
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
    await ref.read(BridgeHistoryProviders.bridgeHistoryRepository).setBridge(
          bridge: state.toJson(),
        );
  }

  void setResumeProcess(bool resumeProcess) {
    state = state.copyWith(resumeProcess: resumeProcess);
  }

  void setRequestTooLong(bool requestTooLong) {
    state = state.copyWith(requestTooLong: requestTooLong);
  }

  Future<void> setBlockchainFrom(
    BuildContext context,
    BridgeBlockchain? blockchainFrom,
  ) async {
    state = state.copyWith(blockchainFrom: blockchainFrom);
    await storeBridge();

    // Check provider's endpoint
    if (blockchainFrom != null && blockchainFrom.isArchethic == false) {
      final client = webthree.Web3Client(
        blockchainFrom.providerEndpoint,
        Client(),
        customFilterPingInterval: const Duration(seconds: 5),
      );

      try {
        await client.getBlockNumber();
      } catch (e) {
        log('Web3Client endpoint error for ${blockchainFrom.providerEndpoint} : $e');
        if (context.mounted) {
          await setFailure(
            aedappfm.Failure.other(
              cause: AppLocalizations.of(context)!.providerEndpointNotAvailable,
            ),
          );
        }
      } finally {
        await client.dispose();
      }
    }
  }

  Future<void> setBlockchainFromWithConnection(
    BuildContext context,
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
    if (blockchainFrom.isArchethic && context.mounted) {
      final connection = await sessionNotifier.connectToArchethicWallet(
        context,
        true,
        blockchainFrom,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      await connection.map(
        success: (success) async {
          await setBlockchainFrom(context, blockchainFrom);
        },
        failure: (failure) async {
          await setBlockchainFrom(context, null);
          await setFailure(failure);
        },
      );
    } else {
      final connection =
          await sessionNotifier.connectToEVMWallet(blockchainFrom, true);
      await connection.map(
        success: (success) async {
          await setBlockchainFrom(context, blockchainFrom);
          final blockchainTo = await ref.read(
            BridgeBlockchainsProviders.getArchethicBlockchainFromEVM(
              blockchainFrom,
            ).future,
          );
          if (blockchainTo != null && state.failure == null) {
            if (context.mounted) {
              await setBlockchainToWithConnection(context, blockchainTo);
            }
          }
        },
        failure: (failure) async {
          await setBlockchainFrom(context, null);
          await setFailure(failure);
        },
      );
    }
  }

  Future<void> setBlockchainTo(
    BuildContext context,
    BridgeBlockchain? blockchainTo,
  ) async {
    state = state.copyWith(blockchainTo: blockchainTo);
    await storeBridge();

    // Check provider's endpoint
    if (blockchainTo != null && blockchainTo.isArchethic == false) {
      final client = webthree.Web3Client(
        blockchainTo.providerEndpoint,
        Client(),
        customFilterPingInterval: const Duration(seconds: 5),
      );

      try {
        await client.getBlockNumber();
      } catch (e) {
        log('Web3Client endpoint error for ${blockchainTo.providerEndpoint} : $e');
        if (context.mounted) {
          await setFailure(
            aedappfm.Failure.other(
              cause: AppLocalizations.of(context)!.providerEndpointNotAvailable,
            ),
          );
        }
      } finally {
        await client.dispose();
      }
    }
  }

  Future<void> setBlockchainToWithConnection(
    BuildContext context,
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
    if (blockchainTo.isArchethic && context.mounted) {
      final connection = await sessionNotifier.connectToArchethicWallet(
        context,
        false,
        blockchainTo,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      await connection.map(
        success: (success) async {
          await setBlockchainTo(context, blockchainTo);
        },
        failure: (failure) async {
          await setBlockchainTo(context, null);
          await setFailure(failure);
        },
      );
    } else {
      final connection =
          await sessionNotifier.connectToEVMWallet(blockchainTo, false);
      await connection.map(
        success: (success) async {
          await setBlockchainTo(context, blockchainTo);
          final blockchainFrom = await ref.read(
            BridgeBlockchainsProviders.getArchethicBlockchainFromEVM(
              blockchainTo,
            ).future,
          );
          if (blockchainFrom != null && state.failure == null) {
            if (context.mounted) {
              await setBlockchainFromWithConnection(context, blockchainFrom);
            }
          }
        },
        failure: (failure) async {
          await setBlockchainTo(context, null);
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

    final tokenToBridgeDecimals = await ref.read(
      TokenDecimalsProviders.getTokenDecimals(
        state.blockchainFrom!.isArchethic,
        state.tokenToBridge!.typeSource,
        state.tokenToBridge!.tokenAddressSource,
        providerEndpoint: state.blockchainFrom!.providerEndpoint,
      ).future,
    );
    await setTokenToBridgeDecimals(tokenToBridgeDecimals);

    final tokenBridgedDecimals = await ref.read(
      TokenDecimalsProviders.getTokenDecimals(
        state.blockchainTo!.isArchethic,
        state.tokenToBridge!.typeTarget,
        state.tokenToBridge!.tokenAddressTarget,
        providerEndpoint: state.blockchainTo!.providerEndpoint,
      ).future,
    );
    await setTokenBridgedDecimals(tokenBridgedDecimals);

    final balance = await ref.read(
      BalanceProviders.getBalance(
        state.blockchainFrom!.isArchethic,
        session.walletFrom!.genesisAddress,
        state.tokenToBridge!.typeSource,
        state.tokenToBridge!.tokenAddressSource,
        state.blockchainFrom!.isArchethic ? 8 : state.tokenToBridgeDecimals,
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
        state.blockchainTo!.isArchethic ? 8 : state.tokenBridgedDecimals,
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
          state.tokenBridgedDecimals,
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
    BuildContext context,
    aedappfm.ProcessStep bridgeProcessStep,
  ) async {
    if (bridgeProcessStep == aedappfm.ProcessStep.confirmation &&
        await control(context) == false) {
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

  Future<void> swapDirections(BuildContext context) async {
    await setChangeDirectionInProgress(true);
    final sessionNotifier = ref.read(SessionProviders.session.notifier);
    await sessionNotifier.cancelAllWalletsConnection();
    final blockchainFrom = state.blockchainFrom;
    final blockchainTo = state.blockchainTo;
    initState();
    if (blockchainFrom != null) {
      if (context.mounted) {
        await setBlockchainToWithConnection(context, blockchainFrom);
      }
    }
    if (blockchainTo != null) {
      if (context.mounted) {
        await setBlockchainFromWithConnection(context, blockchainTo);
      }
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

  Future<bool> control(BuildContext context) async {
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
      if (context.mounted) {
        await setFailure(
          aedappfm.Failure.other(
            cause: AppLocalizations.of(context)!.bridgeControlSelectIssuingBC,
          ),
        );
      }
      return false;
    }
    if (state.blockchainTo == null && state.blockchainTo!.name.isEmpty) {
      if (context.mounted) {
        await setFailure(
          aedappfm.Failure.other(
            cause: AppLocalizations.of(context)!.bridgeControlSelectReceivingBC,
          ),
        );
      }
      return false;
    }
    if (state.tokenToBridge == null && state.tokenToBridge!.name.isEmpty) {
      if (context.mounted) {
        await setFailure(
          aedappfm.Failure.other(
            cause: AppLocalizations.of(context)!.bridgeControlSelectToken,
          ),
        );
      }
      return false;
    }
    if (state.targetAddress.isEmpty) {
      if (context.mounted) {
        await setFailure(
          aedappfm.Failure.other(
            cause: AppLocalizations.of(context)!.bridgeControlTargetAddress,
          ),
        );
      }
      return false;
    }
    if (state.blockchainTo!.isArchethic) {
      if (archethic.Address(address: state.targetAddress).isValid() == false) {
        if (context.mounted) {
          await setFailure(
            aedappfm.Failure.other(
              cause: AppLocalizations.of(context)!
                  .bridgeControlTargetArchethicAddressValid,
            ),
          );
        }
        return false;
      }
    } else {
      try {
        webthree.EthereumAddress.fromHex(
          state.targetAddress,
        );
      } catch (e) {
        if (context.mounted) {
          await setFailure(
            aedappfm.Failure.other(
              cause: AppLocalizations.of(context)!
                  .bridgeControlTargetEVMAddressValid,
            ),
          );
        }
        return false;
      }
    }

    if (state.tokenToBridgeAmount.isNaN || state.tokenToBridgeAmount <= 0) {
      if (context.mounted) {
        await setFailure(
          aedappfm.Failure.other(
            cause: AppLocalizations.of(context)!.bridgeControlAmount,
          ),
        );
      }
      return false;
    }

    if (state.resumeProcess == false &&
        state.tokenToBridgeBalance < state.tokenToBridgeAmount) {
      if (context.mounted) {
        await setFailure(
          aedappfm.Failure.other(
            cause: AppLocalizations.of(context)!.bridgeControlAmountTooHigh,
          ),
        );
      }
      return false;
    }

    if (state.blockchainFrom!.isArchethic &&
        state.poolTargetBalance < state.tokenToBridgeAmount) {
      if (context.mounted) {
        await setFailure(
          aedappfm.Failure.other(
            cause: AppLocalizations.of(context)!
                .bridgeControlInsufficicientLiquidity
                .replaceFirst('%1', state.poolTargetBalance.formatNumber())
                .replaceFirst('%2', state.tokenToBridge!.targetTokenSymbol),
          ),
        );
      }
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

  Future<void> validateForm(BuildContext context) async {
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

    final session = ref.read(SessionProviders.session);
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

    if (context.mounted) {
      await setBridgeProcessStep(
        context,
        aedappfm.ProcessStep.confirmation,
      );
    }
  }

  Future<void> bridge(BuildContext context, WidgetRef ref) async {
    setBridgeOk(false);
    await setTransferInProgress(true);

    //
    if (context.mounted) {
      if (await control(context) == false) {
        await setTransferInProgress(false);
        return;
      }
    }

    final session = ref.read(SessionProviders.session);

    if (state.resumeProcess == false) {
      setTimestampExec(DateTime.now().millisecondsSinceEpoch);
      await ref
          .read(BridgeHistoryProviders.bridgeHistoryRepository)
          .addBridge(bridge: state.toJson());
    }

    if (state.blockchainFrom!.isArchethic) {
      await aedappfm.ConsentRepositoryImpl()
          .addAddress(session.walletFrom!.genesisAddress);

      if (context.mounted) {
        await BridgeArchethicToEVMUseCase().run(
          context,
          ref,
          recoveryStep: state.currentStep,
          recoveryHTLCAEAddress: state.htlcAEAddress,
          recoveryHTLCEVMAddress: state.htlcEVMAddress,
        );
      }
    } else {
      await aedappfm.ConsentRepositoryImpl()
          .addAddress(session.walletTo!.genesisAddress);

      if (context.mounted) {
        await BridgeEVMToArchethicUseCase().run(
          context,
          ref,
          recoveryStep: state.currentStep,
          recoverySecret: state.secret,
          recoveryHTLCAEAddress: state.htlcAEAddress,
          recoveryHTLCEVMAddress: state.htlcEVMAddress,
        );
      }
    }
    setResumeProcess(false);
    await setTransferInProgress(false);
    unawaited(refreshCurrentAccountInfoWallet());
  }
}

abstract class BridgeFormProvider {
  static final bridgeForm = _bridgeFormNotifierProvider;
}
