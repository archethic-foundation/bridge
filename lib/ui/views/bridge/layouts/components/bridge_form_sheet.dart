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
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_uco_v1_warning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class BridgeFormSheet extends ConsumerWidget {
  const BridgeFormSheet({this.w3mService, super.key});

  final W3MService? w3mService;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              W3MConnectWalletButton(
                service: w3mService!,
              ),
            ],
          ),
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
          const Row(
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              SizedBox(width: 20),
              BridgeTokenBridgedPoolBalance(),
            ],
          ),
          const BridgeTokenAddress(),
          BridgeUCOV1Warning(),
          SizedBox(
            height: 10,
          ),
          const BridgeTargetAddress(),
          const SizedBox(
            height: 10,
          ),
          const BridgeTokenAmount(),
          const BridgeErrorMessage(),
          const Spacer(),
          const BridgeButton(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
