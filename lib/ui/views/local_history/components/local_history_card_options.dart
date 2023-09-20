/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';

import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/bridge_in_progress/bridge_in_progress_popup.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_logs_popup.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/components/icon_animated.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistoryCardOptions extends ConsumerWidget {
  const LocalHistoryCardOptions({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    return Row(
      children: [
        InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return ScaffoldMessenger(
                  key: scaffoldMessengerKey,
                  child: Builder(
                    builder: (context) {
                      return Scaffold(
                        backgroundColor: Colors.transparent,
                        body: AlertDialog(
                          backgroundColor: BridgeThemeBase.backgroundPopupColor,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                          ),
                          content: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .confirmationPopupTitle,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .bridgeClearWarning,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                    bottom: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppButton(
                                        labelBtn:
                                            AppLocalizations.of(context)!.no,
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      AppButton(
                                        labelBtn:
                                            AppLocalizations.of(context)!.yes,
                                        onPressed: () {
                                          ref
                                              .read(
                                                BridgeHistoryProviders
                                                    .bridgeHistoryRepository,
                                              )
                                              .removeBridge(
                                                timestampExec:
                                                    bridge.timestampExec!,
                                              );
                                          ref.invalidate(
                                            BridgeHistoryProviders
                                                .fetchBridgesList,
                                          );
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
          child: IconAnimated(
            icon: Iconsax.trash,
            color: Colors.white,
            tooltip: AppLocalizations.of(context)!.local_history_option_delete,
          ),
        ),
        if (bridge.failure != null && bridge.failure is UserRejected)
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
                    .setWidget(const BridgeSheet());
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
        if (bridge.failure != null && bridge.htlcEVMAddress != null)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () async {
                ref
                    .read(
                      MainScreenWidgetDisplayedProviders
                          .mainScreenWidgetDisplayedProvider.notifier,
                    )
                    .setWidget(
                      RefundSheet(contractAddress: bridge.htlcEVMAddress),
                    );
              },
              child: IconAnimated(
                icon: Iconsax.empty_wallet_change,
                color: Colors.white,
                tooltip:
                    AppLocalizations.of(context)!.local_history_option_refund,
              ),
            ),
          ),
        if (bridge.failure != null)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () async {
                final formattedJson =
                    const JsonEncoder.withIndent('  ').convert(bridge);
                debugPrint('$formattedJson}');
                await LocalHistoryLogsPopup.getDialog(
                  context,
                  ref,
                  formattedJson,
                );
              },
              child: IconAnimated(
                icon: Iconsax.code,
                color: Colors.white,
                tooltip:
                    AppLocalizations.of(context)!.local_history_option_logs,
              ),
            ),
          ),
      ],
    );
  }
}
