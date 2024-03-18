/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class LocalHistoryLogCopyBtn extends StatelessWidget {
  const LocalHistoryLogCopyBtn({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return aedappfm.AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_copy,
      onPressed: () {
        Clipboard.setData(
          ClipboardData(text: content),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
            content: SelectableText(
              AppLocalizations.of(context)!.local_history_logs_copied,
              style: Theme.of(context).snackBarTheme.contentTextStyle!.copyWith(
                    fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                      context,
                      Theme.of(context).snackBarTheme.contentTextStyle!,
                    ),
                  ),
            ),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: AppLocalizations.of(context)!.ok,
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}
