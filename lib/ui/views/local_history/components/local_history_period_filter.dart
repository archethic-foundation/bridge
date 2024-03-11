/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

import 'package:aebridge/ui/views/local_history/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class LocalHistoryPeriodFilter extends ConsumerWidget {
  const LocalHistoryPeriodFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<DateTimeRange?> dateTimeRangePicker() async {
      final picked = await showDateRangePicker(
        context: context,
        confirmText: 'Select',
        cancelText: 'Cancel',
        helpText: 'Please, select a period to filter your history',
        firstDate: DateTime(2023, 8, 21),
        lastDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          23,
          59,
          59,
        ),
        initialDateRange: DateTimeRange(
          start: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day - 1,
          ),
          end: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            23,
            59,
            59,
          ),
        ),
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 400,
                  maxHeight: min(800, MediaQuery.of(context).size.height - 40),
                ),
                child: child,
              ),
            ],
          );
        },
      );
      return picked;
    }

    final localHistory = ref.watch(LocalHistoryFormProvider.localHistoryForm);

    return MenuItemButton(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const Icon(
              aedappfm.Iconsax.filter,
              size: 16,
            ),
            const SizedBox(
              width: 10,
            ),
            if (localHistory.filterPeriodStart == null ||
                localHistory.filterPeriodEnd == null)
              Text(
                AppLocalizations.of(context)!.local_history_period_date_lbl,
              )
            else
              Text('${DateFormat.yMMMEd(
                Localizations.localeOf(context).languageCode,
              ).format(
                localHistory.filterPeriodStart!.toLocal(),
              )} - ${DateFormat.yMMMEd(
                Localizations.localeOf(context).languageCode,
              ).format(
                localHistory.filterPeriodEnd!.toLocal(),
              )} '),
          ],
        ),
      ),
      onPressed: () async {
        final localHistoryNotifier = ref.read(
          LocalHistoryFormProvider.localHistoryForm.notifier,
        );

        final date = await dateTimeRangePicker();
        if (date != null) {
          localHistoryNotifier
            ..setFilterPeriodStart(
              date.start,
            )
            ..setFilterPeriodEnd(
              date.end.add(
                const Duration(
                  hours: 23,
                  minutes: 59,
                  seconds: 59,
                ),
              ),
            );
        }
      },
    );
  }
}
