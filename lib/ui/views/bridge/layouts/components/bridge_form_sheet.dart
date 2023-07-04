import 'package:aebridge/ui/views/bridge/layouts/components/bridge_blockchain_from_selection.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_blockchain_to_selection.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_btn.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_connect_wallet_btn.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_icon_direction.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_address.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_to_bridge_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';

class BridgeFormSheet extends ConsumerWidget {
  const BridgeFormSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 5,
            right: 5,
          ),
          decoration: BoxDecoration(
            border: const GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  Color(0x003C89B9),
                  Color(0xFFCC00FF),
                ],
                stops: [0, 1],
              ),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.background.withOpacity(0.9),
                Theme.of(context).colorScheme.background.withOpacity(0.2),
              ],
              stops: const [0, 1],
            ),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.background.withOpacity(0.7),
                  Theme.of(context).colorScheme.background.withOpacity(1),
                ],
                stops: const [0, 1],
              ),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: SelectionArea(
                        child: Text(
                          AppLocalizations.of(context)!.bridgeFormTitle,
                          style: Theme.of(context).textTheme.titleSmall,
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
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                child: Column(
                  children: [
                    BridgeBlockchainFromSelection(),
                    SizedBox(
                      height: 5,
                    ),
                    BridgeBlockchainIconDirection(),
                    SizedBox(
                      height: 5,
                    ),
                    BridgeBlockchainToSelection(),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BridgeTokenToBridgeAmountFiat(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BridgeTokenToBridgeBalance(),
                            SizedBox(
                              width: 5,
                            ),
                            BridgeBalanceMaxButton(),
                          ],
                        ),
                      ],
                    ),*/

                    BridgeTokenToBridgeSelection(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BridgeTokenAddress(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    BridgeConnectWalletButton(),
                    BridgeButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
