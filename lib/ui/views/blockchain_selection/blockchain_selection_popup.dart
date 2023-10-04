/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/ui/views/blockchain_selection/components/blockchain_list.dart';
import 'package:aebridge/ui/views/blockchain_selection/components/blockchain_testnet_included_switch.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/popup_close_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlockchainSelectionPopup {
  static Future<BridgeBlockchain?> getDialog(
    BuildContext context,
    WidgetRef ref, {
    String? env,
    bool? shouldBeArchethic,
  }) async {
    return showDialog<BridgeBlockchain>(
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
                    height: 400,
                    width: BridgeThemeBase.sizeBoxComponentWidth,
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const PopupCloseButton(),
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
                                        .blockchain_selection_title,
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
                              const BlockchainTestnetIncludedSwitch(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: BlockchainList(
                            env: env,
                            shouldBeArchethic: shouldBeArchethic,
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
  }
}
