/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/metamask.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/model/bridge_blockchain.dart';
import 'package:aebridge/model/bridge_token.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final oldBlockchainFrom = state.blockchainFrom;
    state = state.copyWith(blockchainFrom: blockchainFrom);

    // Switch Metamask to Archethic
    if (oldBlockchainFrom != null &&
        oldBlockchainFrom.chainId > 0 &&
        blockchainFrom.chainId < 0) {
      if (sl.isRegistered<MetaMaskProvider>()) {
        sl.get<MetaMaskProvider>().disconnect();
        return;
      }
    }

    // Switch Archethic to Metamask
    if (oldBlockchainFrom != null &&
        oldBlockchainFrom.chainId < 0 &&
        blockchainFrom.chainId > 0) {
      debugPrint('connect to Metamask');
      final sessionNotifier = ref.read(SessionProviders.session.notifier);
      await sessionNotifier.connectToMetamask(blockchainFrom);
    }

    // Switch metamask
    if (oldBlockchainFrom != null &&
        oldBlockchainFrom.chainId > 0 &&
        blockchainFrom.chainId > 0) {
      if (sl.isRegistered<MetaMaskProvider>()) {
        final metaMaskProvider = sl.get<MetaMaskProvider>();
        if (metaMaskProvider.walletConnected &&
            metaMaskProvider.currentChain != blockchainFrom.chainId) {
          if (blockchainFrom.chainId > 0) {
            final changeIsOk =
                await metaMaskProvider.changeChainId(blockchainFrom.chainId);
            if (!changeIsOk) {
              state = state.copyWith(blockchainFrom: oldBlockchainFrom);
            }
          } else {
            metaMaskProvider.disconnect();
          }
        }
      }
    }
  }

  void setBlockchainTo(BridgeBlockchain blockchainTo) {
    state = state.copyWith(blockchainTo: blockchainTo);
  }

  void setTokenToBridge(
    BridgeToken tokenToBridge,
  ) {
    state = state.copyWith(
      tokenToBridge: tokenToBridge,
    );
    return;
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

  Future<void> bridge(BuildContext context, WidgetRef ref) async {
    //
  }
}

abstract class BridgeFormProvider {
  static final bridgeForm = _bridgeFormProvider;
}
