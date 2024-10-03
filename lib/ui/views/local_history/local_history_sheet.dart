/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';

import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/local_history/bloc/provider.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_bridge_finished_included_switch.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_clear_btn.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_period_filter.dart';
import 'package:aebridge/ui/views/main_screen/layouts/main_screen_list.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LocalHistorySheet extends ConsumerWidget {
  const LocalHistorySheet({
    super.key,
  });

  static const routerPage = '/localHistory';

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return MainScreenList(
      body: _body(context, ref),
    );
  }
}

Widget _body(BuildContext context, WidgetRef ref) {
  final bridgesList = ref.watch(fetchBridgesListProvider(asc: false));

  return Padding(
    padding: const EdgeInsets.only(top: 90, left: 50, right: 50),
    child: Align(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!aedappfm.Responsive.isDesktop(context))
            const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 5),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: aedappfm.AppThemeBase.secondaryColor,
                          size: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.backToBridge,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.labelMedium!.fontSize,
                          color: aedappfm.AppThemeBase.secondaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SelectionArea(
                  child: SelectableText(
                    AppLocalizations.of(context)!.bridgesListTitle,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 25,
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: aedappfm.AppThemeBase.gradient,
                  ),
                ),
              ),
              MenuAnchor(
                style: MenuStyle(
                  shape: WidgetStateProperty.all(
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
                  width: 700,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: data.value.length,
                    itemBuilder: (context, index) {
                      // Conversion LinkedMap to Map
                      final bridge = BridgeFormState.fromJson(
                        json.decode(json.encode(data.value[index]))
                            as Map<String, dynamic>,
                      );
                      if (localHistory.processCompletedIncluded == false &&
                          bridge.failure == null &&
                          bridge.currentStep == 8) {
                        return const SizedBox.shrink();
                      }
                      if (localHistory.filterPeriodStart != null &&
                          bridge.timestampExec != null &&
                          DateTime.fromMillisecondsSinceEpoch(
                            bridge.timestampExec!,
                          ).isBefore(localHistory.filterPeriodStart!)) {
                        return const SizedBox.shrink();
                      }
                      if (localHistory.filterPeriodEnd != null &&
                          bridge.timestampExec != null &&
                          DateTime.fromMillisecondsSinceEpoch(
                            bridge.timestampExec!,
                          ).isAfter(localHistory.filterPeriodEnd!)) {
                        return const SizedBox.shrink();
                      }

                      return LocalHistoryCard(
                        bridge: bridge,
                        key: ValueKey(bridge.timestampExec),
                      );
                    },
                  ),
                ),
              );
            },
            error: (error) => const SizedBox.shrink(),
            loading: (loading) => const SizedBox.shrink(),
          ),
        ],
      ),
    ),
  );
}
