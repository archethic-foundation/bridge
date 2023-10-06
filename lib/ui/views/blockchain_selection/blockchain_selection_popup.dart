/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/ui/views/blockchain_selection/components/blockchain_list.dart';
import 'package:aebridge/ui/views/blockchain_selection/components/blockchain_testnet_included_switch.dart';
import 'package:aebridge/ui/views/util/components/popup_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlockchainSelectionPopup {
  static Future<BridgeBlockchain?> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    return showDialog<BridgeBlockchain>(
      context: context,
      builder: (context) {
        return PopupTemplate(
          popupTitle: AppLocalizations.of(context)!.blockchain_selection_title,
          popupHeight: 350,
          popupContent: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: BlockchainTestnetIncludedSwitch(),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlockchainList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
