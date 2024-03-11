/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressContracts extends ConsumerWidget {
  const BridgeInProgressContracts({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((bridge.blockchainFrom != null &&
                  bridge.blockchainFrom!.htlcAddress != null &&
                  bridge.blockchainFrom!.htlcAddress!.isNotEmpty) ||
              bridge.blockchainTo != null &&
                  bridge.blockchainTo!.htlcAddress != null &&
                  bridge.blockchainTo!.htlcAddress!.isNotEmpty)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SelectionArea(
                    child: Text(
                      AppLocalizations.of(context)!
                          .bridgeInProgressContractsLink,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: aedappfm.AppThemeBase.gradient,
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (bridge.blockchainFrom != null &&
                  bridge.blockchainFrom!.htlcAddress != null &&
                  bridge.blockchainFrom!.htlcAddress!.isNotEmpty)
                FormatAddressLinkCopy(
                  address: bridge.blockchainFrom!.htlcAddress!,
                  chainId: bridge.blockchainFrom!.chainId,
                  reduceAddress: true,
                  header:
                      '${bridge.blockchainFrom!.name} ${AppLocalizations.of(context)!.localHistoryContractLbl}:',
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              if (bridge.blockchainTo != null &&
                  bridge.blockchainTo!.htlcAddress != null &&
                  bridge.blockchainTo!.htlcAddress!.isNotEmpty)
                FormatAddressLinkCopy(
                  address: bridge.blockchainTo!.htlcAddress!,
                  chainId: bridge.blockchainTo!.chainId,
                  reduceAddress: true,
                  header:
                      '${bridge.blockchainTo!.name} ${AppLocalizations.of(context)!.localHistoryContractLbl}:',
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
