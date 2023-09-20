/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/local_history/components/local_history_logs_close_btn.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_logs_copy_btn.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/scrollbar.dart';
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
        return ScaffoldMessenger(
          child: Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: AlertDialog(
                  backgroundColor: BridgeThemeBase.backgroundPopupColor,
                  content: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: BridgeThemeBase.sizeBoxComponentWidth,
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(30),
                          child: ArchethicScrollbar(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      SelectionArea(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .local_history_logs_title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 50,
                                          height: 1,
                                          decoration: BoxDecoration(
                                            gradient: BridgeThemeBase.gradient,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .local_history_logs_desc,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SelectableText(
                                  logs!,
                                  style: Theme.of(context).textTheme.bodySmall,
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
                      const SizedBox(
                        height: 10,
                      ),
                      const LocalHistoryLogCloseBtn(),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
