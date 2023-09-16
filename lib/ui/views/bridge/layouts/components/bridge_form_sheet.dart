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
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeFormSheet extends ConsumerWidget {
  const BridgeFormSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SelectionArea(
              child: Text(
                AppLocalizations.of(context)!.bridgeFormTitle,
                style: Theme.of(context).textTheme.titleSmall,
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
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BridgeBlockchainFromSelection(),
            BridgeBlockchainIconDirection(),
            BridgeBlockchainToSelection(),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BridgeTokenToBridgeSelection(),
            BridgeTokenBridged(),
          ],
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: BridgeTokenAddress(),
        ),
        const SizedBox(
          height: 10,
        ),
        const BridgeTargetAddress(),
        const SizedBox(
          height: 10,
        ),
        const BridgeTokenAmount(),
        const SizedBox(
          height: 10,
        ),
        const BridgeErrorMessage(),
        const SizedBox(
          height: 20,
        ),
        const BridgeButton(),
        const SizedBox(height: 10),
      ],
    );
  }
}
