/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/local_history/components/local_history_logs_copy_btn.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistoryLogsPopup {
  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
    String? logs,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return aedappfm.PopupTemplate(
          popupTitle: AppLocalizations.of(context)!.local_history_logs_title,
          popupHeight: 500,
          popupContent: Column(
            children: [
              SelectableText(
                AppLocalizations.of(context)!.local_history_logs_desc,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Expanded(
                child: Container(
                  width: aedappfm.AppThemeBase.sizeBoxComponentWidth,
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(30),
                  child: aedappfm.ArchethicScrollbar(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SelectableText(
                          logs!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                fontSize:
                                    aedappfm.Responsive.fontSizeFromTextStyle(
                                  context,
                                  Theme.of(context).textTheme.bodySmall!,
                                ),
                              ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              LocalHistoryLogCopyBtn(
                content: logs,
              ),
            ],
          ),
        );
      },
    );
  }
}
