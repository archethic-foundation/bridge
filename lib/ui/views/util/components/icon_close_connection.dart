/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/components/icon_button_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IconCloseConnection extends ConsumerWidget {
  const IconCloseConnection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionNotifier = ref.watch(SessionProviders.session.notifier);

    return IconButtonAnimated(
      onPressed: () async {
        return showDialog(
          context: context,
          builder: (context) {
            return ScaffoldMessenger(
              child: Builder(
                builder: (context) {
                  return AlertDialog(
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
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .connectionWalletDisconnectWarning,
                              style: Theme.of(context).textTheme.bodyMedium,
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
                                  labelBtn: AppLocalizations.of(context)!.no,
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                AppButton(
                                  labelBtn: AppLocalizations.of(context)!.yes,
                                  onPressed: () async {
                                    await sessionNotifier
                                        .cancelAllWalletsConnection();

                                    if (!context.mounted) return;
                                    context.go('/welcome');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.power_settings_new_rounded),
      color: ArchethicThemeBase.raspberry50,
      tooltip: AppLocalizations.of(context)!.connectionWalletDisconnect,
    );
  }
}
