/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';

import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/local_history/bloc/provider.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_bridge_finished_included_switch.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_clear_btn.dart';
import 'package:aebridge/ui/views/util/components/main_screen_background.dart';
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

    return Stack(
      alignment: Alignment.center,
      children: [
        const MainScreenBackground(),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 130,
          ),
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
                  const SizedBox(
                    width: 300,
                    child: LocalHistoryClearButton(),
                  ),
                ],
              ),
              const LocalHistoryBridgeFinishedIncludedSwitch(),
              const SizedBox(
                height: 30,
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
      ],
    );
  }
}
