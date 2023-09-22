import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/contracts/evm_lp_erc.dart';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/usecases/refund_evm.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webthree/webthree.dart' as webthree;

final _initialRefundFormProvider = Provider<RefundFormState>(
  (ref) {
    throw UnimplementedError();
  },
);

final _refundFormProvider =
    NotifierProvider.autoDispose<RefundFormNotifier, RefundFormState>(
  () {
    return RefundFormNotifier();
  },
  dependencies: [
    RefundFormProvider.initialRefundForm,
  ],
);

class RefundFormNotifier extends AutoDisposeNotifier<RefundFormState> {
  RefundFormNotifier();

  @override
  RefundFormState build() {
    return ref.watch(
      RefundFormProvider.initialRefundForm,
    );
  }

  Future<void> setContractAddress(String contractAddress) async {
    state = state.copyWith(contractAddress: contractAddress);
    await setStatus();
  }

  Future<void> setStatus() async {
    if (await control()) {
      final resultLockTime = await EVMHTLC('http://127.0.0.1:7545')
          .getHTLCLockTime(state.contractAddress);
      resultLockTime.map(
        success: (locktime) {
          state = state.copyWith(
            htlcDateLock: locktime.$1,
            htlcCanRefund: locktime.$2,
          );
        },
        failure: setFailure,
      );
      final resultAmount = await EVMHTLC('http://127.0.0.1:7545')
          .getAmount(state.contractAddress);
      resultAmount.map(
        success: (amount) {
          setAmount(amount);
        },
        failure: setFailure,
      );
      final resultFee =
          await EVMLPERC('http://127.0.0.1:7545').getFee(state.contractAddress);
      resultFee.map(
        success: (fee) {
          setFee(fee);
        },
        failure: setFailure,
      );
      final refundTxAddress = await EVMHTLC('http://127.0.0.1:7545')
          .getTxRefund(state.contractAddress);
      if (refundTxAddress.isNotEmpty) {
        state = state.copyWith(
          refundTxAddress: refundTxAddress,
          isAlwaysRefunded: true,
        );
      }
    }
  }

  void setFailure(
    Failure failure,
  ) {
    state = state.copyWith(
      failure: failure,
    );
  }

  void setAmount(double amount) {
    state = state.copyWith(amount: amount);
  }

  void setFee(double fee) {
    state = state.copyWith(fee: fee);
  }

  void setRefundOk(bool refundOk) {
    state = state.copyWith(refundOk: refundOk);
  }

  void setRefundTxAddress(String refundTxAddress) {
    state = state.copyWith(refundTxAddress: refundTxAddress);
  }

  Future<bool> control() async {
    state = state.copyWith(
      refundOk: false,
      refundTxAddress: null,
      isAlwaysRefunded: false,
      htlcDateLock: null,
      htlcCanRefund: false,
      amount: 0,
      failure: null,
      addressOk: null,
    );

    if (state.contractAddress.isEmpty) {
      state = state.copyWith(
        failure: const Failure.other(cause: 'Please enter a contract address.'),
      );
      return false;
    }

    var addressOk = false;

    if (archethic.Address(address: state.contractAddress).isValid()) {
      addressOk = true;
    }

    if (addressOk == false) {
      try {
        webthree.EthereumAddress.fromHex(state.contractAddress);
        addressOk = true;
        // ignore: empty_catches
      } catch (e) {
        addressOk = false;
      }
    }

    state = state.copyWith(addressOk: addressOk);
    return addressOk;
  }

  Future<void> refund(BuildContext context, WidgetRef ref) async {
    //
    if (await control() == false) {
      return;
    }
    late int currentChain;
    if (sl.isRegistered<EVMWalletProvider>()) {
      currentChain = await sl.get<EVMWalletProvider>().getChainId();
    } else {
      currentChain = await EVMWalletProvider().getChainId();
      final evmWalletProvider = EVMWalletProvider();
      await evmWalletProvider.connect(currentChain);
      sl.registerLazySingleton<EVMWalletProvider>(
        () => evmWalletProvider,
      );
    }

    await EVMWalletProvider().connect(currentChain);
    await RefunEVMCase().run(ref, state.contractAddress);
  }
}

abstract class RefundFormProvider {
  static final refundForm = _refundFormProvider;
  static final initialRefundForm = _initialRefundFormProvider;
}
