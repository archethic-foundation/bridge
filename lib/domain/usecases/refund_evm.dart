/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefunEVMCase {
  Future<void> run(
    WidgetRef ref,
    String htlcContractAddress,
    int chaindId,
  ) async {
    final refundNotifier = ref.read(RefundFormProvider.refundForm.notifier);

    // TODO(reddwarf03): Use dynamic provider
    final result = await EVMHTLC(
      'http://127.0.0.1:7545',
      htlcContractAddress,
      chaindId,
    ).refund();
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
