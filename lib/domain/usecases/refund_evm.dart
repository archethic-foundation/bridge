/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefunEVMCase {
  Future<void> run(
    WidgetRef ref,
    String htlcContractAddress,
    int chaindId,
  ) async {
    final refundNotifier = ref.read(RefundFormProvider.refundForm.notifier);

    final web3Client = sl.get<EVMWalletProvider>().web3Client;

    final result = await EVMHTLC(
      null,
      htlcContractAddress,
      chaindId,
      web3ClientProvided: web3Client,
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
