/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_back_btn.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_btn.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_sheet_fees.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/blockchain_label.dart';
import 'package:aebridge/ui/views/util/components/fiat_value.dart';
import 'package:aebridge/ui/views/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeConfirmSheet extends ConsumerWidget {
  const BridgeConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SelectionArea(
              child: Text(
                AppLocalizations.of(context)!.bridgeConfirmTitle,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(
              width: 5,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.bridge_blockchain_from_lbl,
            ),
            BlockchainLabel(
              chainId: bridge.blockchainFrom!.chainId,
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.bridge_blockchain_to_lbl,
            ),
            BlockchainLabel(
              chainId: bridge.blockchainTo!.chainId,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.bridge_token_amount_lbl,
            ),
            FutureBuilder<String>(
              future: FiatValue().display(
                ref,
                bridge.tokenToBridge!.symbol,
                bridge.tokenToBridgeAmount,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${bridge.tokenToBridgeAmount.toString().formatNumber()} ${bridge.tokenToBridge!.symbol} ${snapshot.data}',
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        if (bridge.targetAddress.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.bridge_target_address_lbl,
              ),
              FormatAddressLinkCopy(
                address: bridge.targetAddress,
                chainId: bridge.blockchainTo!.chainId,
                expanded: false,
                reduceAddress: true,
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 1,
            child: Container(
              decoration: BoxDecoration(
                gradient: BridgeThemeBase.gradient,
              ),
            ),
          ),
        ),
        const BridgeConfirmSheetFees(),
        const Expanded(
          child: SizedBox(),
        ),
        const BridgeConfirmButton(),
        const SizedBox(height: 10),
        const BridgeConfirmBackButton(),
        const SizedBox(height: 40),
      ],
    );
  }
}
