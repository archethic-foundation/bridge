/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_in_progress_popup.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundButton extends ConsumerWidget {
  const RefundButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refund = ref.watch(RefundFormProvider.refundForm);
    if (refund.evmWallet == null ||
        refund.evmWallet!.isConnected == false ||
        refund.htlcAddress.isEmpty ||
        refund.refundTxAddress != null ||
        (refund.isAlreadyRefunded != null &&
            refund.isAlreadyRefunded == true)) {
      return const SizedBox.shrink();
    }

    return refund.htlcCanRefund == false
        ? aedappfm.AppButton(
            labelBtn: AppLocalizations.of(context)!.btn_refund,
            disabled: true,
          )
        : aedappfm.AppButton(
            labelBtn: AppLocalizations.of(context)!.btn_refund,
            onPressed: () async {
              final refundNotifier =
                  ref.read(RefundFormProvider.refundForm.notifier);
              unawaited(refundNotifier.refund(context, ref));
              await RefundInProgressPopup.getDialog(
                context,
                ref,
              );
            },
          );
  }
}
