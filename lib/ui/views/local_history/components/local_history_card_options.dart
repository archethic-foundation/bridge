/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .bridgeClearWarning,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
            child: const IconAnimated(
              icon: Iconsax.trash,
              iconSize: 16,
              color: Colors.white,
            ),
          ),
          if (bridge.failure != null && bridge.failure is UserRejected)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () async {
                  await ref
                      .watch(BridgeFormProvider.bridgeForm.notifier)
                      .resume(bridge);
                  ref
                      .read(
                        MainScreenWidgetDisplayedProviders
                            .mainScreenWidgetDisplayedProvider.notifier,
                      )
                      .setWidget(const BridgeSheet());
                },
                child: const IconAnimated(
                  icon: Iconsax.play_circle,
                  iconSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
