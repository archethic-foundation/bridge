/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_circular_step_progress_indicator.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_close_btn.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_contracts.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_infos.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_wallet_confirm.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressPopup {
  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
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
                  backgroundColor: ThemeBase.backgroundPopupColor,
                  content: Container(
                    height: 400,
                    width: ThemeBase.sizeBoxComponentWidth,
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 30,
                      right: 30,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        BridgeInProgressInfos(),
                        BridgeInProgressCircularStepProgressIndicator(),
                        BridgeInProgressWalletConfirm(),
                        BridgeInProgressContracts(),
                        BridgeInProgressCloseBtn(),
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
