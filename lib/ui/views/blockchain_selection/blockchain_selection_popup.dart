/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/ui/views/blockchain_selection/components/blockchain_list.dart';
import 'package:aebridge/ui/views/blockchain_selection/components/blockchain_testnet_included_switch.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlockchainSelectionPopup {
  static Future<BridgeBlockchain?> getDialog(
    BuildContext context,
    WidgetRef ref,
    bool isFrom,
  ) async {
    return showDialog<BridgeBlockchain>(
      context: context,
      builder: (context) {
        return aedappfm.PopupTemplate(
          popupTitle: AppLocalizations.of(context)!.blockchain_selection_title,
          popupHeight: 350,
          popupContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Align(
                alignment: Alignment.centerRight,
                child: BlockchainTestnetIncludedSwitch(),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlockchainList(isFrom: isFrom),
              ),
            ],
          ),
        );
      },
    );
  }
}
