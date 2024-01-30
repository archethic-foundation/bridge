/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/util/components/fiat_value.dart';
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
      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            Flexible(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      bridge.tokenToBridge!.symbol,
                      bridge.tokenToBridgeAmount,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SelectableText(
                          '${bridge.tokenToBridgeAmount.formatNumber()} ${bridge.tokenToBridge!.symbol} ${snapshot.data} ${AppLocalizations.of(context)!.localHistoryToLbl}',
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  FormatAddressLinkCopy(
                    address: bridge.targetAddress,
                    chainId: bridge.blockchainTo!.chainId,
                    typeAddress: bridge.blockchainTo!.isArchethic
                        ? TypeAddress.chain
                        : TypeAddress.address,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
