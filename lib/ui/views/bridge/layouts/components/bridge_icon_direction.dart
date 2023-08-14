/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeBlockchainIconDirection extends ConsumerWidget {
  const BridgeBlockchainIconDirection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridgeForm = ref.watch(BridgeFormProvider.bridgeForm.notifier);
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    if (bridge.blockchainFrom == null || bridge.blockchainTo == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Icon(
          Iconsax.arrange_circle,
          color: Colors.white.withOpacity(0.2),
        ),
      );
    }

    return IconButton(
      onPressed: () async {
        final blockchainFrom = bridge.blockchainFrom;
        final blockchainTo = bridge.blockchainTo;
        if (blockchainFrom != null) {
          await bridgeForm.setBlockchainTo(blockchainFrom);
        }

        if (blockchainTo != null) {
          await bridgeForm.setBlockchainFrom(blockchainTo);
        }

        bridgeForm
          ..setTokenToBridge(null)
          ..setTargetAddress('');
        await bridgeForm.setTokenToBridgeAmount(0);
      },
      icon: const Icon(Iconsax.arrange_circle),
    );
  }
}
