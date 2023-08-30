/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/balance.dart';
import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/application/oracle/state.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/repositories/datasources/bridge_local_datasource.dart';
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.dart';
import 'package:aebridge/model/bridge_blockchain.dart';
import 'package:aebridge/model/bridge_token.dart';
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
  BridgeFormState build() => const BridgeFormState();

  Future<void> storeBridge() async {
    // We store infos only if timestampExec is initialized
    if (state.timestampExec == null) {
      return;
    }
    final hiveBridgeDatasource = await HiveBridgeDatasource.getInstance();
    await hiveBridgeDatasource.setBridge(
      bridge: state.toJson(),
    );
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
      final connection = await sessionNotifier.connectToArchethicWallet(true);
      connection.map(
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
      connection.map(
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
      final connection = await sessionNotifier.connectToArchethicWallet(false);
      await Future.delayed(const Duration(milliseconds: 500));
      connection.map(
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
      connection.map(
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

  Future<void> setTokenToBridge(
    BridgeToken? tokenToBridge,
  ) async {
    state = state.copyWith(
      tokenToBridge: tokenToBridge,
    );
    await storeBridge();
    final session = ref.read(SessionProviders.session);

    if (tokenToBridge == null) return;

    final balance = await ref.read(
      BalanceProviders.getBalance(
        state.blockchainFrom!.isArchethic,
        session.walletFrom!.genesisAddress,
        state.tokenToBridge!.type,
        state.tokenToBridge!.tokenAddress,
        providerEndpoint: state.blockchainFrom!.providerEndpoint,
      ).future,
    );
    await setTokenToBridgeBalance(balance);
  }

  Future<void> setTokenToBridgeBalance(
    double tokenToBridgeBalance,
  ) async {
    state = state.copyWith(
      tokenToBridgeBalance: tokenToBridgeBalance,
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
      networkFees: 0,
      targetAddress: '',
      tokenToBridge: null,
      tokenToBridgeAmount: 0,
      tokenToBridgeBalance: 0,
      waitForWalletConfirmation: null,
      timestampExec: null,
      changeDirectionInProgress: false,
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

  Future<void> setNetworkFees(double networkFees) async {
    state = state.copyWith(
      networkFees: networkFees,
    );
    await storeBridge();
  }

  Future<void> setTimestampExec(int timestampExec) async {
    state = state.copyWith(timestampExec: timestampExec);
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

    /* if (state.tokenToBridgeBalance < state.tokenToBridgeAmount) {
      state = state.copyWith(
        failure: const Failure.other(
          cause: 'Your amount exceeds your balance. Please adjust your amount.',
        ),
      );
      await storeBridge();
      return false;
    }*/
    return true;
  }

  Future<void> bridge(BuildContext context, WidgetRef ref) async {
    //
    if (await control() == false) {
      return;
    }

    await setTimestampExec(DateTime.now().millisecondsSinceEpoch);

    final hiveBridgeDatasource = await HiveBridgeDatasource.getInstance();
    await hiveBridgeDatasource.addBridge(bridge: state.toJson());

    await setTransferInProgress(true);
    if (state.blockchainFrom!.isArchethic) {
      await BridgeArchethicToEVMUseCase().run(ref);
    } else {
      await BridgeEVMToArchethicUseCase().run(ref);
    }
    debugPrint('Bridge process finished');
    await setTransferInProgress(false);
  }
}

abstract class BridgeFormProvider {
  static final bridgeForm = _bridgeFormProvider;
}
