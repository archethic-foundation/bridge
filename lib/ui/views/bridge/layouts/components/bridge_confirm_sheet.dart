/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/util/components/blockchain_label.dart';
import 'package:aebridge/ui/util/components/fiat_value.dart';
import 'package:aebridge/ui/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_back_btn.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_btn.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_sheet_fees.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeConfirmSheet extends ConsumerWidget {
  const BridgeConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.blockchainFrom == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BridgeConfirmBackButton(),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                AppLocalizations.of(context)!.bridge_blockchain_from_lbl,
              ),
              const SizedBox(width: 8),
              BlockchainLabel(
                chainId: bridge.blockchainFrom!.chainId,
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                AppLocalizations.of(context)!.bridge_blockchain_to_lbl,
              ),
              const SizedBox(width: 8),
              BlockchainLabel(
                chainId: bridge.blockchainTo!.chainId,
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
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
                    return SelectableText(
                      '${bridge.tokenToBridgeAmount.formatNumber(precision: 8)} ${bridge.tokenToBridge!.symbol} ${snapshot.data}',
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          if (bridge.targetAddress.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SelectableText(
                    AppLocalizations.of(context)!.bridge_target_address_lbl,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                FormatAddressLinkCopy(
                  address: bridge.targetAddress,
                  chainId: bridge.blockchainTo!.chainId,
                  reduceAddress: true,
                ),
              ],
            ),
          const SizedBox(
            height: 10,
          ),
          const BridgeConfirmSheetFees(),
          if (bridge.messageMaxHalfUCO)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 45,
                child: aedappfm.InfoBanner(
                  'The UCO amount you entered has been reduced to include Archethic transaction fees.',
                  aedappfm.InfoBannerType.request,
                ),
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          const Spacer(),
          const BridgeConfirmButton(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
