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
    switch (refund.isArchethic) {
      case true:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Iconsax.tick_circle5,
              size: 12,
              color: ArchethicThemeBase.systemPositive500,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              AppLocalizations.of(context)!.refundTypeAddressArchethicAddress,
              style: TextStyle(color: ArchethicThemeBase.systemPositive500),
            ),
          ],
        );
      case false:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Iconsax.tick_circle5,
              size: 12,
              color: ArchethicThemeBase.systemPositive500,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              AppLocalizations.of(context)!.refundTypeAddressEVMAddress,
              style: TextStyle(color: ArchethicThemeBase.systemPositive500),
            ),
          ],
        );
      default:
        if (refund.contractAddress.isNotEmpty) {
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
                AppLocalizations.of(context)!
                    .refundTypeAddressMalformatedAddress,
                style: TextStyle(color: ArchethicThemeBase.systemDanger300),
              ),
            ],
          );
        } else {
          return const SizedBox(
            height: 20,
          );
        }
    }
  }
}
