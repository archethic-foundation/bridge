/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/app_embedded.dart';
import 'package:aebridge/domain/models/swap.dart';
import 'package:aebridge/ui/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
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

class BridgeFormSheet extends ConsumerWidget {
  const BridgeFormSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAppEmbedded = ref.watch(isAppEmbeddedProvider);
    final bridge = ref.watch(bridgeFormNotifierProvider);

    return isAppEmbedded
        ? Column(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: BridgeBlockchainFromSelection()),
                      SizedBox(
                        width: 5,
                      ),
                      BridgeBlockchainIconDirection(),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BridgeBlockchainToSelection(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BridgeTokenToBridgeSelection(),
                  const Row(
                    children: [
                      BridgeTokenToBridgeBalance(),
                      BridgeBalanceWarning(
                        swapProcess: SwapProcess.signed,
                      ),
                    ],
                  ),
                  if (bridge.tokenToBridge != null &&
                      bridge.blockchainFrom != null &&
                      bridge.tokenToBridge!.tokenAddressSource.isNotEmpty)
                    FormatAddressLinkCopy(
                      address: bridge.tokenToBridge!.tokenAddressSource,
                      chainId: bridge.blockchainFrom!.chainId,
                      reduceAddress: true,
                      fontSize: 16,
                    ),
                  const SizedBox(height: 20),
                  const BridgeTokenBridged(),
                  const Row(
                    children: [
                      BridgeTokenBridgedBalance(),
                      BridgeBalanceWarning(
                        swapProcess: SwapProcess.chargeable,
                      ),
                    ],
                  ),
                  if (bridge.tokenToBridge != null &&
                      bridge.blockchainTo != null &&
                      bridge.tokenToBridge!.tokenAddressTarget.isNotEmpty)
                    FormatAddressLinkCopy(
                      address: bridge.tokenToBridge!.tokenAddressTarget,
                      chainId: bridge.blockchainTo!.chainId,
                      reduceAddress: true,
                      fontSize: 16,
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
              const BridgeUCOV1Warning(),
              const SizedBox(
                height: 20,
              ),
              const BridgeTargetAddress(),
              const SizedBox(
                height: 20,
              ),
              const BridgeTokenAmount(),
              const BridgeErrorMessage(),
              const Spacer(),
              const BridgeButton(),
              const SizedBox(height: 10),
            ],
          )
        : const Column(
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
              BridgeUCOV1Warning(),
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
          );
  }
}
