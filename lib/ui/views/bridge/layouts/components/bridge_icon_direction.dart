/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/app_embedded.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeBlockchainIconDirection extends ConsumerWidget {
  const BridgeBlockchainIconDirection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridgeForm = ref.watch(bridgeFormNotifierProvider.notifier);
    final bridge = ref.watch(bridgeFormNotifierProvider);
    final isAppEmbedded = ref.watch(isAppEmbeddedProvider);

    if (bridge.blockchainFrom == null ||
        bridge.blockchainTo == null ||
        bridge.changeDirectionInProgress) {
      return Padding(
        padding: EdgeInsets.only(
          top: isAppEmbedded ? 10 : 25,
          bottom: isAppEmbedded ? 10 : 0,
        ),
        child: Icon(
          isAppEmbedded
              ? aedappfm.Iconsax.arrow_swap
              : aedappfm.Iconsax.arrow_swap_horizontal,
          color: Colors.white.withOpacity(0.2),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        top: isAppEmbedded ? 0 : 25,
      ),
      child: IconButton(
        onPressed: () async {
          await bridgeForm.swapDirections(
            AppLocalizations.of(context)!,
          );
        },
        icon: Icon(
          isAppEmbedded
              ? aedappfm.Iconsax.arrow_swap
              : aedappfm.Iconsax.arrow_swap_horizontal,
        ),
      ),
    );
  }
}
