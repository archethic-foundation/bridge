/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/util/components/evm_htlc_status.dart';
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
      return const SizedBox.shrink();
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
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FormatAddressLinkCopy(
                  address: bridge.blockchainFrom!.htlcAddress!,
                  chainId: bridge.blockchainFrom!.chainId,
                  typeAddress: bridge.blockchainFrom!.isArchethic
                      ? TypeAddress.chain
                      : TypeAddress.address,
                  header:
                      '${bridge.blockchainFrom!.name} ${AppLocalizations.of(context)!.localHistoryContractLbl}:',
                  reduceAddress: true,
                ),
                if (bridge.blockchainFrom!.isArchethic == false)
                  EVMHTLCStatus(
                    providerEndpoint: bridge.blockchainFrom!.providerEndpoint,
                    htlcAddress: bridge.blockchainFrom!.htlcAddress!,
                    chainId: bridge.blockchainFrom!.chainId,
                  ),
              ],
            ),
          if (bridge.blockchainTo != null &&
              bridge.blockchainTo!.htlcAddress != null &&
              bridge.blockchainTo!.htlcAddress!.isNotEmpty)
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FormatAddressLinkCopy(
                  address: bridge.blockchainTo!.htlcAddress!,
                  chainId: bridge.blockchainTo!.chainId,
                  typeAddress: bridge.blockchainTo!.isArchethic
                      ? TypeAddress.chain
                      : TypeAddress.address,
                  header:
                      '${bridge.blockchainTo!.name} ${AppLocalizations.of(context)!.localHistoryContractLbl}:',
                  reduceAddress: true,
                ),
                if (bridge.blockchainTo!.isArchethic == false)
                  EVMHTLCStatus(
                    providerEndpoint: bridge.blockchainTo!.providerEndpoint,
                    htlcAddress: bridge.blockchainTo!.htlcAddress!,
                    chainId: bridge.blockchainTo!.chainId,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
