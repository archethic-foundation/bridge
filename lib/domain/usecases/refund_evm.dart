/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/contracts/evm_contract.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefunEVMCase {
  Future<void> run(
    WidgetRef ref,
    String htlcContractAddress,
  ) async {
    final refundNotifier = ref.read(RefundFormProvider.refundForm.notifier);

    final result =
        await HTLCUtil('http://127.0.0.1:7545').refund(htlcContractAddress);
    result.map(
      success: (refundTxAddress) {
        refundNotifier
          ..setRefundTxAddress(refundTxAddress)
          ..setRefundOk(true);
      },
      failure: refundNotifier.setFailure,
    );
  }
}
