/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
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
    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_copy,
      icon: Iconsax.copy,
      onPressed: () {
        Clipboard.setData(
          ClipboardData(text: content),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
            content: Text(
              AppLocalizations.of(context)!.local_history_logs_copied,
              style: Theme.of(context).snackBarTheme.contentTextStyle,
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
