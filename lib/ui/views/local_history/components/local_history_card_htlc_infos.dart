/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class LocalHistoryCardHTLCInfos extends StatelessWidget {
  const LocalHistoryCardHTLCInfos({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;
  @override
  Widget build(BuildContext context) {
    if (bridge.blockchainFrom == null || bridge.blockchainTo == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (bridge.blockchainFrom != null &&
              bridge.blockchainFrom!.htlcAddress != null &&
              bridge.blockchainFrom!.htlcAddress!.isNotEmpty)
            Wrap(
              children: [
                SelectableText(
                  '${bridge.blockchainFrom!.name} ${AppLocalizations.of(context)!.localHistoryContractLbl}:',
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
                FormatAddressLinkCopy(
                  address: bridge.blockchainFrom!.htlcAddress!,
                  chainId: bridge.blockchainFrom!.chainId,
                ),
              ],
            ),
          if (bridge.blockchainTo != null &&
              bridge.blockchainTo!.htlcAddress != null &&
              bridge.blockchainTo!.htlcAddress!.isNotEmpty)
            Wrap(
              children: [
                SelectableText(
                  '${bridge.blockchainTo!.name} ${AppLocalizations.of(context)!.localHistoryContractLbl}:',
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
                FormatAddressLinkCopy(
                  address: bridge.blockchainTo!.htlcAddress!,
                  chainId: bridge.blockchainTo!.chainId,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
