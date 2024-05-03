/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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

    if (bridge.blockchainFrom == null ||
        bridge.blockchainTo == null ||
        bridge.changeDirectionInProgress) {
      return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Icon(
          aedappfm.Iconsax.arrow_swap_horizontal,
          color: Colors.white.withOpacity(0.2),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: IconButton(
        onPressed: () async {
          await bridgeForm.swapDirections(
            context,
          );
        },
        icon: const Icon(aedappfm.Iconsax.arrow_swap_horizontal),
      ),
    );
  }
}
