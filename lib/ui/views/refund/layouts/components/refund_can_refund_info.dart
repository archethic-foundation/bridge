/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RefundCanRefundInfo extends ConsumerWidget {
  const RefundCanRefundInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refund = ref.watch(RefundFormProvider.refundForm);
    if (refund.isAlreadyRefunded != null && refund.isAlreadyRefunded == true) {
      return const SizedBox(
        height: 20,
      );
    }
    if (refund.htlcCanRefund) {
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
            '${AppLocalizations.of(context)!.refundCanRefundYes} ${refund.amount + refund.fee} UCO',
            style: TextStyle(color: ArchethicThemeBase.systemPositive500),
          ),
        ],
      );
    } else {
      if (refund.htlcDateLock != null) {
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
              AppLocalizations.of(context)!.refundCanRefundDateLock.replaceAll(
                    '%1',
                    DateFormat.yMd(
                      Localizations.localeOf(context).languageCode,
                    ).add_Hms().format(
                          refund.htlcDateLock!.toLocal(),
                        ),
                  ),
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
