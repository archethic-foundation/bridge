/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aebridge/ui/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/util/components/format_address_link_copy_big_icon.dart';
import 'package:aebridge/ui/util/components/htlc_status.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistoryCardHTLCInfos extends ConsumerWidget {
  const LocalHistoryCardHTLCInfos({
    required this.bridge,
    required this.statusEVM,
    required this.statusAE,
    super.key,
  });
  final BridgeFormState bridge;
  final int? statusEVM;
  final int? statusAE;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (bridge.blockchainFrom == null || bridge.blockchainTo == null) {
      return const SizedBox.shrink();
    }

    final isAppMobileFormat = aedappfm.Responsive.isMobile(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (bridge.blockchainFrom != null &&
              bridge.blockchainFrom!.htlcAddress != null &&
              bridge.blockchainFrom!.htlcAddress!.isNotEmpty)
            isAppMobileFormat
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${bridge.blockchainFrom!.name} ${AppLocalizations.of(context)!.localHistoryContractLbl}:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          FormatAddressLinkCopyBigIcon(
                            address: bridge.blockchainFrom!.htlcAddress!,
                            chainId: bridge.blockchainFrom!.chainId,
                            typeAddress: bridge.blockchainFrom!.isArchethic
                                ? TypeAddressLinkCopyBigIcon.chain
                                : TypeAddressLinkCopyBigIcon.address,
                            reduceAddress: true,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      if (bridge.blockchainFrom!.isArchethic == false)
                        HTLCStatus(status: statusEVM)
                      else
                        HTLCStatus(status: statusAE),
                    ],
                  )
                : Wrap(
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
                        HTLCStatus(status: statusEVM)
                      else
                        HTLCStatus(status: statusAE),
                    ],
                  ),
          if (bridge.blockchainTo != null &&
              bridge.blockchainTo!.htlcAddress != null &&
              bridge.blockchainTo!.htlcAddress!.isNotEmpty)
            isAppMobileFormat
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${bridge.blockchainTo!.name} ${AppLocalizations.of(context)!.localHistoryContractLbl}:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          FormatAddressLinkCopyBigIcon(
                            address: bridge.blockchainTo!.htlcAddress!,
                            chainId: bridge.blockchainTo!.chainId,
                            typeAddress: bridge.blockchainTo!.isArchethic
                                ? TypeAddressLinkCopyBigIcon.chain
                                : TypeAddressLinkCopyBigIcon.address,
                            reduceAddress: true,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      if (bridge.blockchainTo!.isArchethic == false)
                        HTLCStatus(status: statusEVM)
                      else
                        HTLCStatus(status: statusAE),
                    ],
                  )
                : Wrap(
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
                        HTLCStatus(status: statusEVM)
                      else
                        HTLCStatus(status: statusAE),
                    ],
                  ),
        ],
      ),
    );
  }
}
