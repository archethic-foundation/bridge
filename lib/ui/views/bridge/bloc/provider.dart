/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/balance.dart';
import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/evm_lp.dart';
import 'package:aebridge/application/market.dart';
import 'package:aebridge/application/oracle/state.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webthree/webthree.dart' as webthree;

final _bridgeFormProvider =
    NotifierProvider.autoDispose<BridgeFormNotifier, BridgeFormState>(
  () {
    return BridgeFormNotifier();
  },
);

class BridgeFormNotifier extends AutoDisposeNotifier<BridgeFormState> {
  BridgeFormNotifier();

  @override
  BridgeFormState build() {
    return const BridgeFormState();
  }

  Future<void> resume(BridgeFormState bridgeFormState) async {
    await setBlockchainFromWithConnection(bridgeFormState.blockchainFrom!);
    await setBlockchainToWithConnection(bridgeFormState.blockchainTo!);
    state = state.copyWith(
      archethicOracleUCO: bridgeFormState.archethicOracleUCO,
      blockchainTo: bridgeFormState.blockchainTo,
      bridgeProcessStep: bridgeFormState.bridgeProcessStep,
      changeDirectionInProgress: bridgeFormState.isControlsOk,
      currentStep: bridgeFormState.currentStep,
      failure: null,
      isTransferInProgress: true,
      archethicTransactionFees: bridgeFormState.archethicTransactionFees,
      targetAddress: bridgeFormState.targetAddress,
      timestampExec: bridgeFormState.timestampExec,
      tokenToBridge: bridgeFormState.tokenToBridge,
      tokenToBridgeAmount: bridgeFormState.tokenToBridgeAmount,
      tokenToBridgeBalance: bridgeFormState.tokenToBridgeBalance,
      tokenBridgedBalance: bridgeFormState.tokenBridgedBalance,
      waitForWalletConfirmation: bridgeFormState.waitForWalletConfirmation,
      htlcAEAddress: bridgeFormState.htlcAEAddress,
      htlcEVMAddress: bridgeFormState.htlcEVMAddress,
      secret: bridgeFormState.secret,
    );
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
    state = state.copyWith(failure: null);
    await storeBridge();
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
    state = state.copyWith(failure: null);
    await storeBridge();
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
      state = state.copyWith(targetAddress: session.walletTo!.genesisAddress);
      await storeBridge();
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
      case 'WETH':
        coinId = 'ethereum';
        break;
      case 'BSC':
        coinId = 'binance-usd';
        break;
      case 'MATIC':
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
  }

  Future<void> setTokenToBridgeBalance(
    double tokenToBridgeBalance,
  ) async {
    state = state.copyWith(
      tokenToBridgeBalance: tokenToBridgeBalance,
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

  Future<void> setTokenToBridgeAmount(
    double tokenToBridgeAmount,
  ) async {
    state = state.copyWith(
      tokenToBridgeAmount: tokenToBridgeAmount,
    );
    await storeBridge();
  }

  Future<void> setFailure(
    Failure failure,
  ) async {
    debugPrint(failure.toString());
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

  Future<void> initState() async {
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
      waitForWalletConfirmation: null,
      timestampExec: null,
      htlcAEAddress: null,
      htlcEVMAddress: null,
      resumeProcess: false,
      secret: null,
      archethicOracleUCO: null,
    );
    await storeBridge();
  }

  Future<void> setCurrentStep(int currentStep) async {
    state = state.copyWith(currentStep: currentStep);
    await storeBridge();
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
    state = state.copyWith(failure: null);
    await storeBridge();

    if (state.blockchainFrom == null && state.blockchainFrom!.name.isEmpty) {
      state = state.copyWith(
        failure:
            const Failure.other(cause: 'Please select the issuing blockchain.'),
      );
      await storeBridge();
      return false;
    }
    if (state.blockchainTo == null && state.blockchainTo!.name.isEmpty) {
      state = state.copyWith(
        failure: const Failure.other(
          cause: 'Please select the receiving blockchain.',
        ),
      );
      await storeBridge();
      return false;
    }
    if (state.tokenToBridge == null && state.tokenToBridge!.name.isEmpty) {
      state = state.copyWith(
        failure:
            const Failure.other(cause: 'Please select the token to transfer.'),
      );
      await storeBridge();
      return false;
    }
    if (state.targetAddress.isEmpty) {
      state = state.copyWith(
        failure: const Failure.other(
          cause:
              'Please enter your receiving address on the target blockchain.',
        ),
      );
      await storeBridge();
      return false;
    }
    if (state.blockchainTo!.isArchethic) {
      if (archethic.Address(address: state.targetAddress).isValid() == false) {
        state = state.copyWith(
          failure: const Failure.other(
            cause: 'Please enter a valid Archethic address.',
          ),
        );
        await storeBridge();
        return false;
      }
    } else {
      try {
        webthree.EthereumAddress.fromHex(
          state.targetAddress,
        );
      } catch (e) {
        state = state.copyWith(
          failure: const Failure.other(cause: 'Please enter a valid address.'),
        );
        await storeBridge();
        return false;
      }
    }

    if (state.tokenToBridgeAmount.isNaN || state.tokenToBridgeAmount <= 0) {
      state = state.copyWith(
        failure: const Failure.other(
          cause: 'Please enter the amount of tokens to transfer.',
        ),
      );
      await storeBridge();
      return false;
    }
    debugPrint('state.tokenToBridgeBalance ${state.tokenToBridgeBalance}');
    debugPrint('state.bridgeProcessStep ${state.bridgeProcessStep.name}');

    if (state.tokenToBridgeBalance < state.tokenToBridgeAmount) {
      state = state.copyWith(
        failure: const Failure.other(
          cause: 'Your amount exceeds your balance. Please adjust your amount.',
        ),
      );
      await storeBridge();
      return false;
    }
    return true;
  }

  Future<void> validateForm() async {
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

    final archethicProtocolFees =
        await ArchethicContract().calculateArchethicProtocolFees(
      state.blockchainFrom!.isArchethic
          ? state.blockchainFrom!.archethicFactoryAddress!
          : state.blockchainTo!.archethicFactoryAddress!,
    );
    await setArchethicProtocolFeesRate(archethicProtocolFees.rate);
    await setArchethicProtocolFeesAddress(archethicProtocolFees.address);
    await setCoingeckoPrice();
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
  static final bridgeForm = _bridgeFormProvider;
}
