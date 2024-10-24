/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundEVMCase {
  Future<void> run(
    WidgetRef ref,
    String htlcContractAddress,
    int chaindId,
    bool isERC20,
  ) async {
    final refundNotifier = ref.read(RefundFormProvider.refundForm.notifier)
      ..setRefundTxAddress(null)
      ..setRefundInProgress(true)
      ..setFailure(null)
      ..setRefundOk(false)
      ..setWalletConfirmation(null);

    final result = await EVMHTLC(
      htlcContractAddress,
    ).refund(
      ref,
      isERC20,
    );

    result.map(
      success: (refundTxAddress) {
        refundNotifier
          ..setRefundTxAddress(refundTxAddress)
          ..setRefundInProgress(false)
          ..setFailure(null)
          ..setRefundOk(true)
          ..setWalletConfirmation(null);
      },
      failure: (failure) {
        refundNotifier
          ..setRefundTxAddress(null)
          ..setRefundInProgress(false)
          ..setFailure(failure)
          ..setRefundOk(false)
          ..setWalletConfirmation(null);
      },
    );
  }
}
