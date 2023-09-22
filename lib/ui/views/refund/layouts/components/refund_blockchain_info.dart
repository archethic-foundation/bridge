/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundBlockchainInfo extends ConsumerWidget {
  const RefundBlockchainInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refund = ref.watch(RefundFormProvider.refundForm);
    if (refund.contractAddress.isEmpty || refund.isControlsOk == true) {
      return const SizedBox();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Iconsax.close_circle5,
          size: 12,
          color: ArchethicThemeBase.systemDanger300,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          AppLocalizations.of(context)!.refundTypeAddressMalformatedAddress,
          style: TextStyle(color: ArchethicThemeBase.systemDanger300),
        ),
      ],
    );
  }
}
