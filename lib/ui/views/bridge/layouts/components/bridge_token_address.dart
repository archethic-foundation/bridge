/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeTokenAddress extends ConsumerWidget {
  const BridgeTokenAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    if (bridge.blockchainTo == null || bridge.tokenToBridge == null) {
      return const SizedBox();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (bridge.tokenToBridge!.tokenAddressSource.isEmpty)
          const SizedBox()
        else
          FormatAddressLinkCopy(
            address: bridge.tokenToBridge!.tokenAddressSource,
            chainId: bridge.blockchainFrom!.chainId,
            reduceAddress: true,
          ),
        if (bridge.tokenToBridge!.tokenAddressTarget.isEmpty)
          const SizedBox()
        else
          FormatAddressLinkCopy(
            address: bridge.tokenToBridge!.tokenAddressTarget,
            chainId: bridge.blockchainTo!.chainId,
            reduceAddress: true,
          ),
      ],
    );
  }
}
