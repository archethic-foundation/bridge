/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
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
              return const SizedBox();
            }
            return AppButton(
              labelBtn: AppLocalizations.of(context)!.btn_clear_local_history,
              icon: Iconsax.eraser,
              onPressed: () async {
                return showDialog(
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
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
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
                                          AppButton(
                                            labelBtn:
                                                AppLocalizations.of(context)!
                                                    .no,
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          AppButton(
                                            labelBtn:
                                                AppLocalizations.of(context)!
                                                    .yes,
                                            onPressed: () async {
                                              ref.read(
                                                BridgeHistoryProviders
                                                    .clearBridgesList,
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
            );
          },
          error: (error) => const SizedBox(),
          loading: (loading) => const SizedBox(),
        );
  }
}
