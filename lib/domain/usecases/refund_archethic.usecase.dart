/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundArchethicCase {
  RefundArchethicCase({
    required this.dappClient,
  });

  final awc.ArchethicDAppClient dappClient;

  Future<void> run(
    WidgetRef ref,
    String currentNameAccount,
    String htlcContractAddressAE,
  ) async {
    final refundNotifier = ref.read(RefundFormProvider.refundForm.notifier)
      ..setRefundTxAddress(null)
      ..setRefundInProgress(true)
      ..setFailure(null)
      ..setRefundOk(false)
      ..setWalletConfirmation(null);

    final result = await ArchethicContract().refund(
      dappClient,
      ref,
      currentNameAccount,
      htlcContractAddressAE,
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
