/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/swap.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_balance_warning.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_blockchain_from_selection.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_blockchain_to_selection.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_btn.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_error_message.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_icon_direction.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_textfield_target_address.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_textfield_token_amount.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_address.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_bridged.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_bridged_balance.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_bridged_pool_balance.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_to_bridge_balance.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_to_bridge_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeFormSheet extends ConsumerWidget {
  const BridgeFormSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    BridgeTokenToBridgeBalance(),
                    BridgeBalanceWarning(
                      swapProcess: SwapProcess.signed,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BridgeTokenBridgedBalance(),
                    BridgeBalanceWarning(
                      swapProcess: SwapProcess.chargeable,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              SizedBox(width: 20),
              BridgeTokenBridgedPoolBalance(),
            ],
          ),
          BridgeTokenAddress(),
          SizedBox(
            height: 10,
          ),
          BridgeTargetAddress(),
          SizedBox(
            height: 10,
          ),
          BridgeTokenAmount(),
          BridgeErrorMessage(),
          Spacer(),
          BridgeButton(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
