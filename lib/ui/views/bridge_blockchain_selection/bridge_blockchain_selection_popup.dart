/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/ui/views/bridge_blockchain_selection/components/bridge_blockchain_list.dart';
import 'package:aebridge/ui/views/util/blockchain_testnet_included_switch.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class BridgeBlockchainSelectionPopup {
  static Future<BridgeBlockchain?> getDialog(
    BuildContext context,
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
                child: BridgeBlockchainList(isFrom: isFrom),
              ),
            ],
          ),
        );
      },
    );
  }
}
