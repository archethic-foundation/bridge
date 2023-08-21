/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BridgeInProgressWalletConfirm extends ConsumerWidget {
  const BridgeInProgressWalletConfirm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.isTransferInProgress == false) {
      return const SizedBox();
    }

    return SizedBox(
      height: 50,
      child: Row(
        children: [
          if (bridge.waitForWalletConfirmation ==
              WaitForWalletConfirmation.archethic)
            Text(
              AppLocalizations.of(context)!.bridgeInProgressConfirmAEWallet,
            ),
          if (bridge.waitForWalletConfirmation == WaitForWalletConfirmation.evm)
            Text(
              AppLocalizations.of(context)!.bridgeInProgressConfirmEVMWallet,
            ),
          if (bridge.waitForWalletConfirmation != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 3,
                top: 10,
              ),
              child: LoadingAnimationWidget.prograssiveDots(
                color: Theme.of(context).colorScheme.primary,
                size: 12,
              ),
            ),
        ],
      ),
    );
  }
}
