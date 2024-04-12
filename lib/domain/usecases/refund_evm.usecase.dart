/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/domain/usecases/bridge_ae_process_mixin.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefunEVMCase with ArchethicBridgeProcessMixin {
  Future<void> run(
    WidgetRef ref,
    String providerEndPoint,
    String htlcContractAddress,
    int chaindId,
    ProcessRefund processRefund,
    bool isERC,
  ) async {
    final refundNotifier = ref.read(RefundFormProvider.refundForm.notifier)
      ..setRefundTxAddress(null)
      ..setRefundInProgress(true)
      ..setFailure(null)
      ..setRefundOk(false)
      ..setWalletConfirmation(null);

    var _htlcContractAddress = htlcContractAddress;
    if (processRefund == ProcessRefund.signed) {
      final dataAEHTLC = await getProvisionData(htlcContractAddress);
      if (dataAEHTLC.evmHTLCAddress != null) {
        _htlcContractAddress = dataAEHTLC.evmHTLCAddress!;
      }
    }

    final result = await EVMHTLC(
      providerEndPoint,
      _htlcContractAddress,
      chaindId,
    ).refund(ref, processRefund, isERC);

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
