/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:aebridge/ui/views/token_selection/components/token_list.dart';
import 'package:aebridge/ui/views/util/components/popup_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenSelectionPopup {
  static Future<BridgeToken?> getDialog(
    BuildContext context,
    WidgetRef ref,
    String? direction,
  ) async {
    return showDialog<BridgeToken>(
      context: context,
      builder: (context) {
        return PopupTemplate(
          popupTitle: AppLocalizations.of(context)!.token_selection_title,
          popupHeight: 220,
          popupContent: Expanded(
            child: TokenList(direction: direction),
          ),
        );
      },
    );
  }
}
