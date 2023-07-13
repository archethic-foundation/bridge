import 'package:aebridge/model/bridge_blockchain.dart';
import 'package:aebridge/ui/views/blockchain_selection/components/blockchain_list.dart';
import 'package:aebridge/ui/views/blockchain_selection/components/blockchain_selection_close_btn.dart';
import 'package:aebridge/ui/views/blockchain_selection/components/blockchain_testnet_included_switch.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/localizations.dart';

class BlockchainSelectionPopup {
  static Future<BridgeBlockchain?> getDialog(
    BuildContext context,
    List<String> blockchainsExcluded, {
    String? env,
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
                  content: Container(
                    width: 600,
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
                                    const EdgeInsets.only(left: 15, right: 15),
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
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0x003C89B9),
                                        Color(0xFFCC00FF),
                                      ],
                                      stops: [0, 1],
                                      begin: AlignmentDirectional.centerEnd,
                                      end: AlignmentDirectional.centerStart,
                                    ),
                                  ),
                                ),
                              ),
                              const BlockchainTestnetIncludedSwitch(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BlockchainList(
                          blockchainsExcluded: blockchainsExcluded,
                          env: env,
                        ),
                        const BlockchainSelectionCloseBtn(),
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
