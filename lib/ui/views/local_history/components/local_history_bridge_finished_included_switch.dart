/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/local_history/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistoryBridgeFinishedIncludedSwitch extends ConsumerStatefulWidget {
  const LocalHistoryBridgeFinishedIncludedSwitch({
    super.key,
  });

  @override
  ConsumerState<LocalHistoryBridgeFinishedIncludedSwitch> createState() =>
      _LocalHistoryBridgeFinishedIncludedSwitchState();
}

class _LocalHistoryBridgeFinishedIncludedSwitchState
    extends ConsumerState<LocalHistoryBridgeFinishedIncludedSwitch> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final localHistoryNotifier = ref.watch(
      localHistoryFormNotifierProvider.notifier,
    );

    final localHistory = ref.watch(localHistoryFormNotifierProvider);
    final thumbIcon = WidgetStateProperty.resolveWith<Icon?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: AppLocalizations.of(context)!
                .local_history_selection_transfer_completed_included_lbl,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              padding: const EdgeInsets.only(left: 2),
              height: 30,
              child: Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Switch(
                      thumbIcon: thumbIcon,
                      value: localHistory.processCompletedIncluded,
                      onChanged:
                          localHistoryNotifier.setProcessCompletedIncluded,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
