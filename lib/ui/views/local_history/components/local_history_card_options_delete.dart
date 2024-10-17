/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistoryCardOptionsDelete extends ConsumerWidget {
  const LocalHistoryCardOptionsDelete({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    return InkWell(
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
                      backgroundColor:
                          aedappfm.AppThemeBase.backgroundPopupColor,
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
                              child: SelectableText(
                                AppLocalizations.of(context)!
                                    .confirmationPopupTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: aedappfm.Responsive
                                          .fontSizeFromTextStyle(
                                        context,
                                        Theme.of(context)
                                            .textTheme
                                            .titleMedium!,
                                      ),
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SelectableText(
                                AppLocalizations.of(context)!
                                    .bridgeClearWarning,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: aedappfm.Responsive
                                          .fontSizeFromTextStyle(
                                        context,
                                        Theme.of(context).textTheme.bodyMedium!,
                                      ),
                                    ),
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
                                  aedappfm.AppButton(
                                    labelBtn: AppLocalizations.of(context)!.no,
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  aedappfm.AppButton(
                                    labelBtn: AppLocalizations.of(context)!.yes,
                                    onPressed: () async {
                                      await ref
                                          .read(
                                            bridgeHistoryRepositoryProvider,
                                          )
                                          .removeBridge(
                                            timestampExec:
                                                bridge.timestampExec!,
                                          );

                                      ref.invalidate(
                                        fetchBridgesListProvider,
                                      );
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
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
      child: aedappfm.IconAnimated(
        icon: aedappfm.Iconsax.trash,
        color: Colors.white,
        tooltip: AppLocalizations.of(context)!.local_history_option_delete,
      ),
    );
  }
}
