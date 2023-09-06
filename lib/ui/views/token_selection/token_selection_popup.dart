/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/token_selection/components/token_list.dart';
import 'package:aebridge/ui/views/token_selection/components/token_selection_close_btn.dart';
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
        return ScaffoldMessenger(
          child: Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: AlertDialog(
                  backgroundColor: BridgeThemeBase.backgroundPopupColor,
                  content: Container(
                    width: BridgeThemeBase.sizeBoxComponentWidth,
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 30,
                      right: 30,
                    ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: SelectionArea(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .token_selection_title,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
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
                          height: 30,
                        ),
                        TokenList(direction: direction),
                        const TokenSelectionCloseBtn(),
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
  }
}
