/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
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

    if (bridge.blockchainFrom == null ||
        bridge.blockchainTo == null ||
        bridge.changeDirectionInProgress) {
      return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Icon(
          Iconsax.arrow_swap_horizontal,
          color: Colors.white.withOpacity(0.2),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: IconButton(
        onPressed: () async {
          await bridgeForm.setChangeDirectionInProgress(true);
          final sessionNotifier = ref.read(SessionProviders.session.notifier);
          await sessionNotifier.cancelAllWalletsConnection();
          final blockchainFrom = bridge.blockchainFrom;
          final blockchainTo = bridge.blockchainTo;
          bridgeForm.initState();
          if (blockchainFrom != null) {
            await bridgeForm.setBlockchainToWithConnection(blockchainFrom);
          }
          if (blockchainTo != null) {
            await bridgeForm.setBlockchainFromWithConnection(blockchainTo);
          }
          await bridgeForm.setTokenToBridge(null);
          await bridgeForm.setTokenToBridgeAmount(0);
          await bridgeForm.setChangeDirectionInProgress(false);
        },
        icon: const Icon(Iconsax.arrow_swap_horizontal),
      ),
    );
  }
}
