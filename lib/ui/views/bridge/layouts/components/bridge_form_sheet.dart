/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_blockchain_from_selection.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_blockchain_to_selection.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_btn.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_error_message.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_icon_direction.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_textfield_target_address.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_textfield_token_amount.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_address.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_bridged.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_to_bridge_selection.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:aebridge/ui/views/util/components/scrollbar.dart';
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
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/background-mainscreen.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: 650,
          height: 600,
          decoration: BoxDecoration(
            gradient: ThemeBase.gradientSheetBackground,
            border: GradientBoxBorder(
              gradient: ThemeBase.gradientSheetBorder,
            ),
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/background-sheet.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: ArchethicScrollbar(
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
                          decoration: BoxDecoration(
                            gradient: ThemeBase.gradient,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BridgeBlockchainFromSelection(),
                          BridgeBlockchainIconDirection(),
                          BridgeBlockchainToSelection(),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BridgeTokenToBridgeSelection(),
                          BridgeTokenBridged(),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BridgeTokenAddress(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BridgeTargetAddress(),
                      SizedBox(
                        height: 10,
                      ),
                      BridgeTokenAmount(),
                      SizedBox(
                        height: 30,
                      ),
                      BridgeButton(),
                      SizedBox(
                        height: 30,
                      ),
                      BridgeErrorMessage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
