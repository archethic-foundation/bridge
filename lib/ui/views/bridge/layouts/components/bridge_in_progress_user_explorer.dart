/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/ui/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressUserExplorer extends ConsumerWidget {
  const BridgeInProgressUserExplorer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    final session = ref.watch(SessionProviders.session);

    if (bridge.requestTooLong == true ||
        (bridge.failure != null && bridge.failure is aedappfm.Timeout)) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                FormatAddressLinkCopy(
                  address: bridge.blockchainFrom!.isArchethic == false
                      ? session.walletFrom!.genesisAddress
                      : session.walletTo!.genesisAddress,
                  chainId: bridge.blockchainFrom!.isArchethic == false
                      ? bridge.blockchainFrom!.chainId
                      : bridge.blockchainTo!.chainId,
                  reduceAddress: true,
                  typeAddress: TypeAddress.chain,
                  header:
                      AppLocalizations.of(context)!.goToExplorer.replaceFirst(
                            '%1',
                            bridge.blockchainFrom!.isArchethic == false
                                ? bridge.blockchainFrom!.name
                                : bridge.blockchainTo!.name,
                          ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return SizedBox.fromSize();
  }
}
