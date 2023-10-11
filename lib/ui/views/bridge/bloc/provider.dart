/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/balance.dart';
import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/application/contracts/archethic_factory.dart';
import 'package:aebridge/application/contracts/evm_lp.dart';
import 'package:aebridge/application/market.dart';
import 'package:aebridge/application/oracle/state.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/application/token_decimals.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webthree/webthree.dart' as webthree;

part 'provider.g.dart';

@riverpod
class _BridgeFormNotifier extends AutoDisposeNotifier<BridgeFormState> {
  @override
  BridgeFormState build() {
    return const BridgeFormState();
  }

  BridgeFormState get currentState => state;
  set currentState(BridgeFormState bridgeFormState) {
    state = bridgeFormState;
  }

  Future<BridgeFormState> resume(BridgeFormState bridgeFormState) async {
    state = bridgeFormState.copyWith(
      resumeProcess: true,
      bridgeProcessStep: BridgeProcessStep.confirmation,
      isTransferInProgress: false,
    );

    await setBlockchainFromWithConnection(bridgeFormState.blockchainFrom!);
    await setBlockchainToWithConnection(bridgeFormState.blockchainTo!);
    await setFailure(bridgeFormState.failure);
    debugPrint('$state');
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
  }

  Future<void> setBlockchainFromWithConnection(
    BridgeBlockchain blockchainFrom,
  ) async {
    final sessionNotifier = ref.read(SessionProviders.session.notifier);
    await setFailure(null);
    if (blockchainFrom.isArchethic) {
      debugPrint('connect to Archethic Wallet');
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
      debugPrint('connect to EVM Wallet');
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
  }

  Future<void> setBlockchainToWithConnection(
    BridgeBlockchain blockchainTo,
  ) async {
    final sessionNotifier = ref.read(SessionProviders.session.notifier);
    await setFailure(null);
    if (blockchainTo.isArchethic) {
      debugPrint('connect to Archethic Wallet');
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
      debugPrint('connect to EVM Wallet');
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

    final session = ref.read(SessionProviders.session);
    if (session.walletTo != null &&
        session.walletTo!.genesisAddress.isNotEmpty) {
      await setTargetAddress(session.walletTo!.genesisAddress);
    }
  }

  Future<void> setTransferInProgress(bool isTransferInProgress) async {
    state = state.copyWith(isTransferInProgress: isTransferInProgress);
    await storeBridge();
  }

  Future<void> setCoingeckoPrice() async {
    if (state.tokenToBridge == null) {
      state = state.copyWith(coingeckoPrice: 0);
    }
    String? coinId;
    switch (state.tokenToBridge!.symbol) {
      case 'ETH':
      case 'aeETH':
        coinId = 'ethereum';
        break;
      case 'BSC':
      case 'aeBSC':
        coinId = 'binance-usd';
        break;
      case 'MATIC':
      case 'aeMATIC':
        coinId = 'polygon';
        break;
      default:
        state = state.copyWith(coingeckoPrice: 0);
        return;
    }

    final coingeckoPriceResult =
        await ref.read(MarketProviders.marketRepository).getPrice(coinId);
    coingeckoPriceResult.map(
      success: (coingeckoPrice) =>
          state = state.copyWith(coingeckoPrice: coingeckoPrice),
      failure: (failure) => state = state.copyWith(coingeckoPrice: 0),
    );
    await storeBridge();
  }

  Future<void> setTokenToBridge(
    BridgeToken? tokenToBridge,
  ) async {
    state = state.copyWith(
      tokenToBridge: tokenToBridge,
    );
    await storeBridge();
    final session = ref.read(SessionProviders.session);

    if (tokenToBridge == null) return;

    await setCoingeckoPrice();

    final balance = await ref.read(
      BalanceProviders.getBalance(
        state.blockchainFrom!.isArchethic,
        session.walletFrom!.genesisAddress,
        state.tokenToBridge!.type,
        state.tokenToBridge!.tokenAddressSource,
        providerEndpoint: state.blockchainFrom!.providerEndpoint,
      ).future,
    );
    await setTokenToBridgeBalance(balance);

    final tokenDecimals = await ref.read(
      TokenDecimalsProviders.getTokenDecimals(
        state.blockchainFrom!.isArchethic,
        state.tokenToBridge!.type,
        state.tokenToBridge!.tokenAddressSource,
        providerEndpoint: state.blockchainFrom!.providerEndpoint,
      ).future,
    );
    await setTokenToBridgeDecimals(tokenDecimals);

    late final String typeTarget;
    switch (state.tokenToBridge!.type) {
      case 'ERC20':
        typeTarget = 'Native';
        break;
      case 'Native':
        typeTarget = 'Wrapped';
        break;
      case 'Wrapped':
        typeTarget = 'Native';
        break;
    }
    final balanceTarget = await ref.read(
      BalanceProviders.getBalance(
        state.blockchainTo!.isArchethic,
        session.walletTo!.genesisAddress,
        typeTarget,
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
          typeTarget,
          state.tokenToBridge!.tokenAddressTarget,
          providerEndpoint: state.blockchainTo!.providerEndpoint,
        ).future,
      );
      debugPrint('poolTargetBalance $poolTargetBalance');
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
    );
    await storeBridge();
  }

  Future<void> setFailure(
    Failure? failure,
  ) async {
    state = state.copyWith(
      failure: failure,
    );
    await storeBridge();
  }

  Future<void> setTargetAddress(
    String targetAddress,
  ) async {
    state = state.copyWith(
      targetAddress: targetAddress,
    );
    await storeBridge();
  }

  Future<void> setMaxAmount() async {
    state = state.copyWith(
      tokenToBridgeAmount: state.tokenToBridgeBalance,
    );
    await storeBridge();
  }

  Future<void> setWaitForWalletConfirmation(
    WaitForWalletConfirmation? waitForWalletConfirmation,
  ) async {
    state = state.copyWith(
      waitForWalletConfirmation: waitForWalletConfirmation,
    );
    await storeBridge();
  }

  Future<void> setBridgeProcessStep(BridgeProcessStep bridgeProcessStep) async {
    if (bridgeProcessStep == BridgeProcessStep.confirmation &&
        await control() == false) {
      return;
    }
    state = state.copyWith(
      bridgeProcessStep: bridgeProcessStep,
    );
    await storeBridge();
  }

  void initState() {
    state = state.copyWith(
      blockchainFrom: null,
      blockchainTo: null,
      bridgeProcessStep: BridgeProcessStep.form,
      currentStep: 0,
      failure: null,
      isTransferInProgress: false,
      safetyModuleFeesRate: 0,
      archethicProtocolFeesRate: 0,
      archethicTransactionFees: 0,
      targetAddress: '',
      tokenToBridge: null,
      coingeckoPrice: 0,
      tokenToBridgeAmount: 0,
      tokenToBridgeBalance: 0,
      tokenBridgedBalance: 0,
      poolTargetBalance: 0,
      tokenToBridgeDecimals: 8,
      waitForWalletConfirmation: null,
      timestampExec: null,
      htlcAEAddress: null,
      htlcEVMAddress: null,
      resumeProcess: false,
      secret: null,
      archethicOracleUCO: null,
      safetyModuleFeesAddress: '',
      changeDirectionInProgress: false,
      archethicProtocolFeesAddress: '',
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

  Future<void> setHTLCAEAddress(String htlcAEAddress) async {
    state = state.copyWith(
      htlcAEAddress: htlcAEAddress,
    );
    await storeBridge();
  }

  Future<void> setHTLCEVMAddress(String htlcEVMAddress) async {
    state = state.copyWith(
      htlcEVMAddress: htlcEVMAddress,
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
      archethicOracleUCO: ArchethicOracleUCO(
        timestamp: timestamp,
        eur: eur,
        usd: usd,
      ),
    );
    await storeBridge();
  }

  Future<bool> control() async {
    await setFailure(null);

    if (state.blockchainFrom == null && state.blockchainFrom!.name.isEmpty) {
      await setFailure(
        const Failure.other(cause: 'Please select the issuing blockchain.'),
      );
      return false;
    }
    if (state.blockchainTo == null && state.blockchainTo!.name.isEmpty) {
      await setFailure(
        const Failure.other(
          cause: 'Please select the receiving blockchain.',
        ),
      );
      return false;
    }
    if (state.tokenToBridge == null && state.tokenToBridge!.name.isEmpty) {
      await setFailure(
        const Failure.other(cause: 'Please select the token to transfer.'),
      );
      return false;
    }
    if (state.targetAddress.isEmpty) {
      await setFailure(
        const Failure.other(
          cause:
              'Please enter your receiving address on the target blockchain.',
        ),
      );
      return false;
    }
    if (state.blockchainTo!.isArchethic) {
      if (archethic.Address(address: state.targetAddress).isValid() == false) {
        await setFailure(
          const Failure.other(
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
          const Failure.other(cause: 'Please enter a valid address.'),
        );
        return false;
      }
    }

    if (state.tokenToBridgeAmount.isNaN || state.tokenToBridgeAmount <= 0) {
      await setFailure(
        const Failure.other(
          cause: 'Please enter the amount of tokens to transfer.',
        ),
      );
      return false;
    }
    debugPrint('state.tokenToBridgeBalance ${state.tokenToBridgeBalance}');
    debugPrint('state.bridgeProcessStep ${state.bridgeProcessStep.name}');

    if (state.tokenToBridgeBalance < state.tokenToBridgeAmount) {
      await setFailure(
        const Failure.other(
          cause: 'Your amount exceeds your balance. Please adjust your amount.',
        ),
      );
      return false;
    }

    if (state.blockchainFrom!.isArchethic &&
        state.poolTargetBalance < state.tokenToBridgeAmount) {
      await setFailure(
        const Failure.other(
          cause:
              "Sorry, but your amount exceeds the current pool's balance.\nPlease adjust your amount or try later.",
        ),
      );
      return false;
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
    await setCoingeckoPrice();

    //final aeHTLCFees = await ArchethicContract().estimateDeployHTLCFees();

    await setBridgeProcessStep(
      BridgeProcessStep.confirmation,
    );
  }

  Future<void> bridge(BuildContext context, WidgetRef ref) async {
    //
    if (await control() == false) {
      return;
    }

    if (state.resumeProcess == false) {
      setTimestampExec(DateTime.now().millisecondsSinceEpoch);
      await ref
          .read(BridgeHistoryProviders.bridgeHistoryRepository)
          .addBridge(bridge: state.toJson());
    }

    await setTransferInProgress(true);
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
    debugPrint('Bridge process finished');
    await setTransferInProgress(false);
  }
}

abstract class BridgeFormProvider {
  static final bridgeForm = _bridgeFormNotifierProvider;
}
