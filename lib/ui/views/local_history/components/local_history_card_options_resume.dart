/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:aebridge/ui/views/util/components/icon_animated.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:busy/busy.dart';
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
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              startBusyContext(
                functionToCall: () async {
                  try {
                    final state = await ref
                        .read(BridgeFormProvider.bridgeForm.notifier)
                        .resume(bridge);

                    ref
                        .read(
                          MainScreenWidgetDisplayedProviders
                              .mainScreenWidgetDisplayedProvider.notifier,
                        )
                        .setWidget(
                          BridgeSheet(initialState: state),
                          ref,
                        );
                  } catch (exc) {
                    debugPrint(exc.toString());
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                            Theme.of(context).snackBarTheme.backgroundColor,
                        content: Text(
                          AppLocalizations.of(context)!
                              .anErrorOccurred(exc.toString()),
                          style:
                              Theme.of(context).snackBarTheme.contentTextStyle,
                        ),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          label: AppLocalizations.of(context)!.ok,
                          onPressed: () {},
                        ),
                      ),
                    );
                  }
                },
                isBusyValueChanged: (isBusy) {
                  ref.read(isLoadingMainScreenProvider.notifier).state = isBusy;
                },
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
