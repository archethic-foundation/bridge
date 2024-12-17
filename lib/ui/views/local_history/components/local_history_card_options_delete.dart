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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 70,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 0.5,
          ),
          gradient: aedappfm.AppThemeBase.gradientInputFormBackground,
        ),
        child: InkWell(
          onTap: () async {
            await _ConfirmDeletePopup.getDialog(context, ref, bridge);
          },
          child: Column(
            children: [
              aedappfm.IconAnimated(
                icon: aedappfm.Iconsax.trash,
                color: Colors.white,
                tooltip:
                    AppLocalizations.of(context)!.local_history_option_delete,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  AppLocalizations.of(context)!.local_history_option_delete,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmDeletePopup {
  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
    BridgeFormState bridge,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return aedappfm.PopupTemplate(
          popupTitle: AppLocalizations.of(context)!.local_history_logs_title,
          popupHeight: 250,
          popupContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: SelectableText(
                  AppLocalizations.of(context)!.confirmationPopupTitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SelectableText(
                  AppLocalizations.of(context)!.bridgeClearWarning,
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
                              timestampExec: bridge.timestampExec!,
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
        );
      },
    );
  }
}
