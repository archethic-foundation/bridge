/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/bridge_in_progress/bridge_in_progress_popup.dart';
import 'package:aebridge/ui/views/util/components/icon_animated.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistoryCardOptionsResume extends ConsumerWidget {
  const LocalHistoryCardOptionsResume({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (bridge.failure == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () async {
              await ref
                  .read(BridgeFormProvider.bridgeForm.notifier)
                  .resume(bridge);
              ref
                  .read(
                    MainScreenWidgetDisplayedProviders
                        .mainScreenWidgetDisplayedProvider.notifier,
                  )
                  .setWidget(const BridgeSheet(), ref);
              if (!context.mounted) return;
              await BridgeInProgressPopup.getDialog(
                context,
                ref,
              );
            },
            child: IconAnimated(
              icon: Iconsax.play_circle,
              color: Colors.white,
              tooltip:
                  AppLocalizations.of(context)!.local_history_option_resume,
            ),
          ),
        ),
      ],
    );
  }
}
