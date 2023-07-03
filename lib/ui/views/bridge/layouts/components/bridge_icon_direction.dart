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

    return IconButton(
      onPressed: () {
        final blockchainFrom = bridge.blockchainFrom;
        final blockchainTo = bridge.blockchainTo;
        if (blockchainFrom != null) {
          bridgeForm.setBlockchainTo(blockchainFrom);
        }

        if (blockchainTo != null) {
          bridgeForm.setBlockchainFrom(blockchainTo);
        }
      },
      icon: const Icon(Iconsax.arrange_circle),
    );
  }
}
