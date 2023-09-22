/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
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
    if (refund.refundTxAddress != null ||
        (refund.isAlwaysRefunded != null && refund.isAlwaysRefunded == true)) {
      return const SizedBox();
    }

    if (refund.isControlsOk == false || refund.htlcCanRefund == false) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_refund,
        icon: Iconsax.empty_wallet_change,
        disabled: true,
      );
    }

    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_refund,
      icon: Iconsax.empty_wallet_change,
      onPressed: () async {
        final refundNotifier = ref.read(RefundFormProvider.refundForm.notifier);
        await refundNotifier.refund(context, ref);
      },
    );
  }
}
