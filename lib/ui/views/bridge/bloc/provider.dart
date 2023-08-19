/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/balance.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/repositories/datasources/bridge_local_datasource.dart';
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.dart';
import 'package:aebridge/model/bridge_blockchain.dart';
import 'package:aebridge/model/bridge_token.dart';
import 'package:aebridge/model/hive/bridge.dart' as hive;
import 'package:aebridge/model/hive/bridge_token.dart' as hive;
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
    state = state.copyWith(errorText: '');
    try {
      if (blockchainFrom.isArchethic) {
        debugPrint('connect to Archethic Wallet');
        await sessionNotifier.connectToArchethicWallet(true);
      } else {
        debugPrint('connect to EVM Wallet');
        await sessionNotifier.connectToEVMWallet(blockchainFrom, true);
      }
      state = state.copyWith(blockchainFrom: blockchainFrom);
    } catch (e) {
      setError(
        e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> setBlockchainTo(BridgeBlockchain blockchainTo) async {
    final sessionNotifier = ref.read(SessionProviders.session.notifier);
    state = state.copyWith(errorText: '');
    try {
      if (blockchainTo.isArchethic) {
        debugPrint('connect to Archethic Wallet');
        await sessionNotifier.connectToArchethicWallet(false);
        await Future.delayed(const Duration(milliseconds: 500));
      } else {
        debugPrint('connect to EVM Wallet');
        await sessionNotifier.connectToEVMWallet(blockchainTo, false);
      }

      state = state.copyWith(blockchainTo: blockchainTo);
      final session = ref.read(SessionProviders.session);
      if (session.walletTo != null &&
          session.walletTo!.genesisAddress.isNotEmpty) {
        state = state.copyWith(targetAddress: session.walletTo!.genesisAddress);
      }
    } catch (e) {
      setError(
        e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> setTokenToBridge(
    BridgeToken? tokenToBridge,
  ) async {
    state = state.copyWith(
      tokenToBridge: tokenToBridge,
    );
    final session = ref.read(SessionProviders.session);

    final balance = await ref.watch(
      BalanceProviders.getBalance(
        state.blockchainFrom!.isArchethic,
        session.walletFrom!.genesisAddress,
        state.tokenToBridge!.type,
        state.tokenToBridge!.tokenAddress,
        providerEndpoint: state.blockchainFrom!.providerEndpoint,
      ).future,
    );
    setTokenToBridgeBalance(balance);
  }

  void setTokenToBridgeBalance(
    double tokenToBridgeBalance,
  ) {
    state = state.copyWith(
      tokenToBridgeBalance: tokenToBridgeBalance,
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

  void setMaxAmount() {
    // TODO(redDwarf03): Manage fees
    state = state.copyWith(
      tokenToBridgeAmount: state.tokenToBridgeBalance,
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
    debugPrint('state.tokenToBridgeBalance ${state.tokenToBridgeBalance}');
    if (state.tokenToBridgeBalance < state.tokenToBridgeAmount) {
      state = state.copyWith(
        errorText:
            'Your amount exceeds your balance. Please adjust your amount.',
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

    final bridgeHive = hive.Bridge(
      blockchainChainIdFrom: state.blockchainFrom!.chainId,
      blockchainChainIdTo: state.blockchainTo!.chainId,
      targetAddress: state.targetAddress,
      timestampExec: DateTime.now().millisecondsSinceEpoch,
      tokenToBridge: hive.BridgeToken(
        name: state.tokenToBridge!.name,
        poolAddressFrom: state.tokenToBridge!.poolAddressFrom,
        poolAddressTo: state.tokenToBridge!.poolAddressTo,
        symbol: state.tokenToBridge!.symbol,
        targetTokenName: state.tokenToBridge!.targetTokenName,
        targetTokenSymbol: state.tokenToBridge!.targetTokenSymbol,
        tokenAddress: state.tokenToBridge!.tokenAddress,
        type: state.tokenToBridge!.name,
      ),
      tokenToBridgeAmount: state.tokenToBridgeAmount,
    );
    final hiveBridgeDatasource = await HiveBridgeDatasource.getInstance();
    hiveBridgeDatasource.addBridge(bridge: bridgeHive);

    if (state.blockchainFrom!.isArchethic) {
      await BridgeArchethicToEVMUseCase().run(ref, context);
    } else {
      await BridgeEVMToArchethicUseCase().run(ref, context);
    }
  }
}

abstract class BridgeFormProvider {
  static final bridgeForm = _bridgeFormProvider;
}
