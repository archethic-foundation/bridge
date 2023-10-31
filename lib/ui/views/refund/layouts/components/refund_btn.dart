/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_in_progress_popup.dart';
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
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
        ? AppButton(
            labelBtn: AppLocalizations.of(context)!.btn_refund,
            icon: Iconsax.empty_wallet_change,
            disabled: true,
          )
        : AppButton(
            labelBtn: AppLocalizations.of(context)!.btn_refund,
            icon: Iconsax.empty_wallet_change,
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
