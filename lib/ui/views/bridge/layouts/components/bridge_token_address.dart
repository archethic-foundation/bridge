/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeTokenAddress extends ConsumerWidget {
  const BridgeTokenAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    if (bridge.blockchainTo == null ||
        bridge.tokenToBridge == null ||
        bridge.tokenToBridge!.tokenAddress.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.bridge_token_address_lbl,
          ),
          FormatAddressLinkCopy(
            address: bridge.tokenToBridge!.tokenAddress,
            chainId: bridge.blockchainFrom!.chainId,
          ),
        ],
      ),
    );
  }
}
