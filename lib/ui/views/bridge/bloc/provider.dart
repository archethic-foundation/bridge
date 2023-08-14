/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
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

  Future<void> setBlockchainFrom(BridgeBlockchain blockchainFrom) async {
    final sessionNotifier = ref.read(SessionProviders.session.notifier);
    if (blockchainFrom.chainId < 0) {
      debugPrint('connect to Archethic Wallet');
      await sessionNotifier.connectToArchethicWallet(true);
    } else {
      debugPrint('connect to EVM Wallet');
      final result =
          await sessionNotifier.connectToEVMWallet(blockchainFrom, true);
      if (result.isFailure) {
        setError(result.failureOrNull!.cause.toString());
        return;
      }
    }
    state = state.copyWith(blockchainFrom: blockchainFrom);
  }

  Future<void> setBlockchainTo(BridgeBlockchain blockchainTo) async {
    final sessionNotifier = ref.read(SessionProviders.session.notifier);
    if (blockchainTo.chainId < 0) {
      debugPrint('connect to Archethic Wallet');
      await sessionNotifier.connectToArchethicWallet(false);
    } else {
      debugPrint('connect to EVM Wallet');
      final result =
          await sessionNotifier.connectToEVMWallet(blockchainTo, false);
      if (result.isFailure) {
        setError(result.failureOrNull!.cause.toString());
        return;
      }
    }
    state = state.copyWith(blockchainTo: blockchainTo);
  }

  void setTokenToBridge(
    BridgeToken? tokenToBridge,
  ) {
    state = state.copyWith(
      tokenToBridge: tokenToBridge,
    );
  }

  Future<void> setTokenToBridgeAmount(
    double tokenToBridgeAmount,
  ) async {
    // TODO(reddwarf03): manage oracle
    /*final oracleUcoPrice = await sl.get<OracleService>().getOracleData();
    state = state.copyWith(
      tokenToBridgeAmount: tokenToBridgeAmount,
      tokenToBridgeAmountFiat:
          tokenToBridgeAmount * (oracleUcoPrice.uco?.usd ?? 0),
    );*/

    state = state.copyWith(
      tokenToBridgeAmount: tokenToBridgeAmount,
      tokenToBridgeAmountFiat: 0,
    );
  }

  void setError(
    String errorText,
  ) {
    state = state.copyWith(
      errorText: errorText,
    );
  }

  void setTargetAddress(
    String targetAddress,
  ) {
    state = state.copyWith(
      targetAddress: targetAddress,
    );
  }

  void setBridgeProcessStep(BridgeProcessStep bridgeProcessStep) {
    if (bridgeProcessStep == BridgeProcessStep.confirmation &&
        control() == false) {
      return;
    }
    state = state.copyWith(
      bridgeProcessStep: bridgeProcessStep,
    );
  }

  void setStepError(String stepError) {
    state = state.copyWith(
      stepError: stepError,
    );
  }

  void setControlInProgress(bool controlInProgress) {
    state = state.copyWith(
      controlInProgress: controlInProgress,
    );
  }

  Future<void> setNetworkFees(double networkFees) async {
    /* final oracleUcoPrice = await sl.get<OracleService>().getOracleData();
    state = state.copyWith(
      networkFees: networkFees,
      networkFeesFiat: networkFees * (oracleUcoPrice.uco?.usd ?? 0),
    );*/
    state = state.copyWith(
      networkFees: networkFees,
      networkFeesFiat: 0,
    );
  }

  void setTokenToBridgeBalance(double tokenToBridgeBalance) {
    state = state.copyWith(
      tokenToBridgeBalance: tokenToBridgeBalance,
    );
  }

  bool control() {
    if (state.blockchainFrom == null && state.blockchainFrom!.name.isEmpty) {
      state = state.copyWith(
        errorText: 'Please select the issuing blockchain.',
      );
      return false;
    }
    if (state.blockchainTo == null && state.blockchainTo!.name.isEmpty) {
      state = state.copyWith(
        errorText: 'Please select the receiving blockchain.',
      );
      return false;
    }
    if (state.tokenToBridge == null && state.tokenToBridge!.name.isEmpty) {
      state = state.copyWith(
        errorText: 'Please select the token to transfer.',
      );
      return false;
    }
    if (state.targetAddress.isEmpty) {
      state = state.copyWith(
        errorText:
            'Please enter your receiving address on the target blockchain.',
      );
      return false;
    }
    if (state.blockchainTo!.isArchethic) {
      if (archethic.Address(address: state.targetAddress).isValid() == false) {
        state = state.copyWith(
          errorText: 'Please enter a valid Archethic address.',
        );
        return false;
      }
    } else {
      try {
        webthree.EthereumAddress.fromHex(
          state.targetAddress,
        );
      } catch (e) {
        state = state.copyWith(
          errorText: 'Please enter a valid address.',
        );
        return false;
      }
    }

    if (state.tokenToBridgeAmount.isNaN || state.tokenToBridgeAmount <= 0) {
      state = state.copyWith(
        errorText: 'Please enter the amount of tokens to transfer.',
      );
      return false;
    }
    return true;
  }

  Future<void> bridge(BuildContext context, WidgetRef ref) async {
    //
    if (control() == false) {
      return;
    }
  }
}

abstract class BridgeFormProvider {
  static final bridgeForm = _bridgeFormProvider;
}
