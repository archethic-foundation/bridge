/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefunEVMCase {
  Future<void> run(
    WidgetRef ref,
    String providerEndPoint,
    String htlcContractAddress,
    int chaindId,
  ) async {
    final refundNotifier = ref.read(RefundFormProvider.refundForm.notifier);

    final result = await EVMHTLC(
      providerEndPoint,
      htlcContractAddress,
      chaindId,
    ).refund(ref);
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
