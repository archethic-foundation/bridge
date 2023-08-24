/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/util/components/info_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressWalletConfirm extends ConsumerWidget {
  const BridgeInProgressWalletConfirm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.isTransferInProgress == false) {
      return const SizedBox(
        height: 40,
      );
    }

    if (bridge.waitForWalletConfirmation ==
        WaitForWalletConfirmation.archethic) {
      return InfoBanner(
        AppLocalizations.of(context)!.bridgeInProgressConfirmAEWallet,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }
    if (bridge.waitForWalletConfirmation == WaitForWalletConfirmation.evm) {
      return InfoBanner(
        AppLocalizations.of(context)!.bridgeInProgressConfirmEVMWallet,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    return const SizedBox(
      height: 40,
    );
  }
}
