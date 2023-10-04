/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class PopupCloseButton extends StatelessWidget {
  const PopupCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.btn_close,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
