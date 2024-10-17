/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/app_mobile_format.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
    if (refund.isAlreadyRefunded == true ||
        refund.isAlreadyWithdrawn == true ||
        refund.processRefund == null ||
        refund.defineStatusInProgress == true) {
      return const SizedBox.shrink();
    }
    final isAppMobileFormat = ref.watch(isAppMobileFormatProvider(context));

    if (refund.htlcCanRefund) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Icon(
              aedappfm.Iconsax.tick_circle5,
              size: isAppMobileFormat
                  ? 12
                  : aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: 12,
                    ),
              color: aedappfm.ArchethicThemeBase.systemPositive500,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Flexible(
            child: SelectableText(
              '${AppLocalizations.of(context)!.refundCanRefundYes} ${refund.totalAmountToRefund.formatNumber()} ${refund.amountCurrency}',
              style: TextStyle(
                color: aedappfm.ArchethicThemeBase.systemPositive500,
                fontSize: isAppMobileFormat
                    ? 13
                    : aedappfm.Responsive.fontSizeFromValue(
                        context,
                        desktopValue: 13,
                      ),
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      );
    } else {
      if (refund.htlcDateLock != null) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Icon(
                aedappfm.Iconsax.close_circle5,
                size: isAppMobileFormat
                    ? 12
                    : aedappfm.Responsive.fontSizeFromValue(
                        context,
                        desktopValue: 12,
                      ),
                color: aedappfm.ArchethicThemeBase.systemDanger300,
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Flexible(
              child: SelectableText(
                AppLocalizations.of(context)!
                    .refundCanRefundDateLock
                    .replaceAll(
                      '%1',
                      '${refund.totalAmountToRefund.formatNumber()} ${refund.amountCurrency}',
                    )
                    .replaceAll(
                      '%2',
                      DateFormat.yMd(
                        Localizations.localeOf(context).languageCode,
                      ).add_Hm().format(
                            DateTime.fromMillisecondsSinceEpoch(
                              refund.htlcDateLock! * 1000,
                            ).toLocal(),
                          ),
                    ),
                style: TextStyle(
                  color: aedappfm.ArchethicThemeBase.systemDanger300,
                  fontSize: isAppMobileFormat
                      ? 13
                      : aedappfm.Responsive.fontSizeFromValue(
                          context,
                          desktopValue: 13,
                        ),
                ),
                textAlign: TextAlign.end,
              ),
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
