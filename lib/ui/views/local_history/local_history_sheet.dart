/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';

import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/local_history/bloc/provider.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_bridge_finished_included_switch.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_clear_btn.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_period_filter.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistorySheet extends ConsumerWidget {
  const LocalHistorySheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridgesList =
        ref.watch(BridgeHistoryProviders.fetchBridgesList(asc: false));

    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Align(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!Responsive.isDesktop(context)) const SizedBox(width: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SelectionArea(
                    child: Text(
                      AppLocalizations.of(context)!.bridgesListTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 25,
                    height: 1,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0x003C89B9),
                          Color(0xFFCC00FF),
                        ],
                        stops: [0, 1],
                        begin: AlignmentDirectional.centerEnd,
                        end: AlignmentDirectional.centerStart,
                      ),
                    ),
                  ),
                ),
                MenuAnchor(
                  style: MenuStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  alignmentOffset: const Offset(0, 10),
                  builder: (context, controller, child) {
                    return IconButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      icon: Icon(
                        Icons.more_vert_outlined,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    );
                  },
                  menuChildren: const [
                    LocalHistoryPeriodFilter(),
                    LocalHistoryClearButton(),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  LocalHistoryBridgeFinishedIncludedSwitch(),
                ],
              ),
            ),
            bridgesList.map(
              data: (data) {
                final localHistory =
                    ref.read(LocalHistoryFormProvider.localHistoryForm);
                return Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: data.value.length,
                      itemBuilder: (context, index) {
                        debugPrint(json.encode(data.value[index]));
                        // Conversion LinkedMap to Map
                        final bridge = BridgeFormState.fromJson(
                          json.decode(json.encode(data.value[index]))
                              as Map<String, dynamic>,
                        );
                        if (localHistory.processCompletedIncluded == false &&
                            bridge.failure == null) return const SizedBox();
                        if (localHistory.filterPeriodStart != null &&
                            bridge.timestampExec != null &&
                            DateTime.fromMillisecondsSinceEpoch(
                              bridge.timestampExec!,
                            ).isBefore(localHistory.filterPeriodStart!)) {
                          return const SizedBox();
                        }
                        if (localHistory.filterPeriodEnd != null &&
                            bridge.timestampExec != null &&
                            DateTime.fromMillisecondsSinceEpoch(
                              bridge.timestampExec!,
                            ).isAfter(localHistory.filterPeriodEnd!)) {
                          return const SizedBox();
                        }

                        return LocalHistoryCard(bridge: bridge);
                      },
                    ),
                  ),
                );
              },
              error: (error) => const SizedBox(),
              loading: (loading) => const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
