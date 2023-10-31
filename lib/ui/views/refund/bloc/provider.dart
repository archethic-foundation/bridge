import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/contracts/evm_htlc_erc.dart';
import 'package:aebridge/application/contracts/evm_htlc_native.dart';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/usecases/refund_evm.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webthree/webthree.dart' as webthree;

final _refundFormNotifierProvider =
    NotifierProvider.autoDispose<RefundFormNotifier, RefundFormState>(
  () {
    return RefundFormNotifier();
  },
);

class RefundFormNotifier extends AutoDisposeNotifier<RefundFormState> {
  @override
  RefundFormState build() {
    if (sl.isRegistered<EVMWalletProvider>()) {
      sl.unregister<EVMWalletProvider>();
    }
    ref.read(SessionProviders.session.notifier).cancelAllWalletsConnection();

    return const RefundFormState();
  }

  Future<void> setContractAddress(String htlcAddress) async {
    state = state.copyWith(htlcAddress: htlcAddress);
    await setStatus();
  }

  Future<void> setStatus() async {
    if (state.evmWallet == null || state.evmWallet!.isConnected == false) {
      return;
    }

    state = state.copyWith(
      refundTxAddress: null,
      isAlreadyRefunded: false,
      isAlreadyWithdrawn: false,
    );

    final chainId = sl.get<EVMWalletProvider>().currentChain ?? 0;

    if (await control()) {
      final evmHTLC = EVMHTLC(
        state.evmWallet!.providerEndpoint,
        state.htlcAddress,
        chainId,
      );

      int? status;
      try {
        status = await evmHTLC.getStatus();
      } catch (e) {
        setFailure(const Failure.notHTLC());
        throw const Failure.notHTLC();
      }
      if (status == 2) {
        final refundTxAddress = await evmHTLC.getTxRefund();

        state = state.copyWith(
          refundTxAddress: refundTxAddress,
          isAlreadyRefunded: true,
        );
        return;
      }
      if (status == 1) {
        state = state.copyWith(
          isAlreadyWithdrawn: true,
        );
      }

      final resultLockTime = await evmHTLC.getHTLCLockTimeAndRefundState();
      resultLockTime.map(
        success: (locktime) {
          state = state.copyWith(
            htlcDateLock: locktime.dateLockTime,
            htlcCanRefund: locktime.canRefund,
          );
        },
        failure: setFailure,
      );

      final resultAmount = await evmHTLC.getAmount();
      resultAmount.map(
        success: (amount) {
          setAmount(amount);
        },
        failure: setFailure,
      );

      final blockchain = await ref.read(
        BridgeBlockchainsProviders.getBlockchainFromChainId(chainId).future,
      );

      final resultAmountCurrency =
          await evmHTLC.getAmountCurrency(blockchain!.nativeCurrency);
      resultAmountCurrency.map(
        success: (currency) {
          setAmountCurrency(currency);
        },
        failure: setFailure,
      );

      if (state.amountCurrency == 'UCO') {
        final evmHTLCERC = EVMHTLCERC(
          state.evmWallet!.providerEndpoint!,
          state.htlcAddress,
          chainId,
        );
        final resultFee = await evmHTLCERC.getFee();
        resultFee.map(
          success: (fee) {
            setFee(fee);
          },
          failure: setFailure,
        );
      } else {
        final evmHTLCNative = EVMHTLCNative(
          state.evmWallet!.providerEndpoint!,
          state.htlcAddress,
          chainId,
        );
        final resultFee = await evmHTLCNative.getFee();
        resultFee.map(
          success: (fee) {
            setFee(fee);
          },
          failure: setFailure,
        );
      }
    }
  }

  void setWalletConfirmation(
    WalletConfirmationRefund? walletConfirmation,
  ) {
    state = state.copyWith(
      walletConfirmation: walletConfirmation,
    );
  }

  void setFailure(
    Failure? failure,
  ) {
    state = state.copyWith(
      failure: failure,
    );
  }

  void setRefundInProgress(bool refundInProgress) {
    state = state.copyWith(refundInProgress: refundInProgress);
  }

  void setAmount(double amount) {
    state = state.copyWith(amount: amount);
  }

  void setAmountCurrency(String amountCurrency) {
    state = state.copyWith(amountCurrency: amountCurrency);
  }

  void setFee(double fee) {
    state = state.copyWith(fee: fee);
  }

  void setRefundOk(bool refundOk) {
    state = state.copyWith(refundOk: refundOk);
  }

  void setRefundTxAddress(String? refundTxAddress) {
    state = state.copyWith(refundTxAddress: refundTxAddress);
  }

  ({bool result, Failure? failure}) _controlAddress() {
    if (state.htlcAddress.isEmpty) {
      return (
        result: false,
        failure: const Failure.other(cause: 'Please enter a contract address.'),
      );
    }

    try {
      webthree.EthereumAddress.fromHex(state.htlcAddress);
    } catch (e) {
      return (
        result: false,
        failure: const Failure.other(cause: 'Malformated address.'),
      );
    }

    return (result: true, failure: null);
  }

  Future<bool> control() async {
    state = state.copyWith(
      refundOk: false,
      refundTxAddress: null,
      isAlreadyRefunded: false,
      htlcDateLock: null,
      htlcCanRefund: false,
      amount: 0,
      failure: null,
      addressOk: null,
    );

    final controlAddress = _controlAddress();
    if (controlAddress.failure != null) {
      state = state.copyWith(
        failure: controlAddress.failure,
      );
    } else {
      state = state.copyWith(
        addressOk: true,
      );
    }

    return controlAddress.result;
  }

  Future<void> refund(BuildContext context, WidgetRef ref) async {
    //
    if (state.chainId == null) {
      return;
    }

    await RefunEVMCase().run(
      ref,
      state.evmWallet!.providerEndpoint!,
      state.htlcAddress,
      state.chainId!,
    );
  }

  Future<Result<void, Failure>> connectToEVMWallet() async {
    return Result.guard(
      () async {
        var evmWallet = const BridgeWallet();
        evmWallet = evmWallet.copyWith(
          isConnected: false,
          error: '',
        );
        state = state.copyWith(evmWallet: evmWallet);
        final evmWalletProvider = EVMWalletProvider();

        try {
          final currentChainId = await evmWalletProvider.getChainId();
          final bridgeBlockchain = await ref.read(
            BridgeBlockchainsProviders.getBlockchainFromChainId(
              currentChainId,
            ).future,
          );
          await evmWalletProvider.connect(currentChainId);
          if (evmWalletProvider.walletConnected) {
            evmWallet = evmWallet.copyWith(
              wallet: 'evmWallet',
              isConnected: true,
              error: '',
              nameAccount: evmWalletProvider.accountName!,
              genesisAddress: evmWalletProvider.currentAddress!,
              endpoint: bridgeBlockchain!.name,
              providerEndpoint: bridgeBlockchain.providerEndpoint,
            );
            state = state.copyWith(
              evmWallet: evmWallet,
              chainId: currentChainId,
            );
            if (sl.isRegistered<EVMWalletProvider>()) {
              await sl.unregister<EVMWalletProvider>();
            }
            sl.registerLazySingleton<EVMWalletProvider>(
              () => evmWalletProvider,
            );
            await setStatus();
          }
        } catch (e) {
          throw const Failure.connectivityEVM();
        }
      },
    );
  }
}

abstract class RefundFormProvider {
  static final refundForm = _refundFormNotifierProvider;
}
