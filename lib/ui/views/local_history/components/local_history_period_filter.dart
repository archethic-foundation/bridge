/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

import 'package:aebridge/ui/views/local_history/bloc/provider.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      debugPrint(picked.toString());
      return picked;
    }

    final localHistory = ref.watch(LocalHistoryFormProvider.localHistoryForm);
    return SizedBox(
      width: 280,
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          width: 0.5,
                        ),
                        gradient: BridgeThemeBase.gradientInputFormBackground,
                      ),
                      child: InkWell(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 45,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: (localHistory.filterPeriodStart == null ||
                                    localHistory.filterPeriodEnd == null)
                                ? Text(
                                    AppLocalizations.of(context)!
                                        .local_history_period_date_lbl,
                                  )
                                : Text('${DateFormat.yMMMEd(
                                    Localizations.localeOf(context)
                                        .languageCode,
                                  ).format(
                                    localHistory.filterPeriodStart!.toLocal(),
                                  )} - ${DateFormat.yMMMEd(
                                    Localizations.localeOf(context)
                                        .languageCode,
                                  ).format(
                                    localHistory.filterPeriodEnd!.toLocal(),
                                  )} '),
                          ),
                        ),
                        onTap: () async {
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 300))
        .scale(duration: const Duration(milliseconds: 300));
  }
}
