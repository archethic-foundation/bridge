/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/bridge_history.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistoryClearButton extends ConsumerWidget {
  const LocalHistoryClearButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    return ref.watch(BridgeHistoryProviders.fetchBridgesList()).map(
          data: (data) {
            if (data.value.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                const Divider(),
                MenuItemButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete_forever_outlined,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.btn_clear_local_history,
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return ScaffoldMessenger(
                          key: scaffoldMessengerKey,
                          child: Builder(
                            builder: (context) {
                              return Consumer(
                                builder: (context, ref, _) {
                                  return Scaffold(
                                    backgroundColor: Colors.transparent,
                                    body: AlertDialog(
                                      backgroundColor: aedappfm
                                          .AppThemeBase.backgroundPopupColor,
                                      contentPadding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      content: Container(
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: SelectableText(
                                                AppLocalizations.of(context)!
                                                    .confirmationPopupTitle,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: SelectableText(
                                                AppLocalizations.of(context)!
                                                    .bridgesListClearWarning,
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
                                                  aedappfm.AppButton(
                                                    labelBtn:
                                                        AppLocalizations.of(
                                                      context,
                                                    )!
                                                            .no,
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  aedappfm.AppButton(
                                                    labelBtn:
                                                        AppLocalizations.of(
                                                      context,
                                                    )!
                                                            .yes,
                                                    onPressed: () async {
                                                      ref.read(
                                                        BridgeHistoryProviders
                                                            .clearBridgesList,
                                                      );

                                                      if (!context.mounted) {
                                                        return;
                                                      }
                                                      Navigator.of(context)
                                                          .pop();
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
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
          error: (error) => const SizedBox.shrink(),
          loading: (loading) => const SizedBox.shrink(),
        );
  }
}
