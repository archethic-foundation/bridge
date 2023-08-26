/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class LocalHistoryCardTrfInfos extends StatelessWidget {
  const LocalHistoryCardTrfInfos({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;
  @override
  Widget build(BuildContext context) {
    if (bridge.tokenToBridge != null && bridge.blockchainTo != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            SelectableText(
              '${bridge.tokenToBridgeAmount.toString().formatNumber()} ${bridge.tokenToBridge!.symbol} ${AppLocalizations.of(context)!.localHistoryToLbl} ',
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
