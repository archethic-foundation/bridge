/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/oracle/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistoryCardTrfInfos extends ConsumerWidget {
  const LocalHistoryCardTrfInfos({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (bridge.tokenToBridge != null && bridge.blockchainTo != null) {
      final archethicOracleUCO =
          ref.watch(ArchethicOracleUCOProviders.archethicOracleUCO);

      final tokenToBridgeAmountFiat =
          archethicOracleUCO.usd * bridge.tokenToBridgeAmount;

      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            SelectableText(
              '${bridge.tokenToBridgeAmount.toString().formatNumber()} ${bridge.tokenToBridge!.symbol} (\$${tokenToBridgeAmountFiat.toStringAsFixed(2).formatNumber()}) ${AppLocalizations.of(context)!.localHistoryToLbl} ',
            ),
            FormatAddressLinkCopy(
              address: bridge.targetAddress,
              chainId: bridge.blockchainTo!.chainId,
              expanded: false,
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}