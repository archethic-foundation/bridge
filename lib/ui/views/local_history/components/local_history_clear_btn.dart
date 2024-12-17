/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/bridge_history.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistoryClearButton extends ConsumerWidget {
  const LocalHistoryClearButton({
    required this.bridgesList,
    super.key,
  });

  final List<Map<String, dynamic>> bridgesList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          onPressed: () => _showConfirmationDialog(context, ref),
        ),
      ],
    );
  }

  Future<void> _showConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    await _ConfirmClearPopup.show(context, ref);
  }
}

class _ConfirmClearPopup {
  static Future<void> show(
    BuildContext context,
    WidgetRef ref,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return aedappfm.PopupTemplate(
          popupTitle: AppLocalizations.of(context)!.local_history_logs_title,
          popupHeight: 210,
          popupContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: SelectableText(
                  AppLocalizations.of(context)!.confirmationPopupTitle,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                          context,
                          Theme.of(context).textTheme.titleMedium!,
                        ),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SelectableText(
                  AppLocalizations.of(context)!.bridgesListClearWarning,
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
                    aedappfm.AppButton(
                      labelBtn: AppLocalizations.of(
                        context,
                      )!
                          .no,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    aedappfm.AppButton(
                      labelBtn: AppLocalizations.of(
                        context,
                      )!
                          .yes,
                      onPressed: () async {
                        ref.read(
                          clearBridgesListProvider,
                        );

                        if (!context.mounted) {
                          return;
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
