/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/util/components/info_banner.dart';
import 'package:aebridge/ui/views/util/failure_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressInfosBanner extends ConsumerWidget {
  const BridgeInProgressInfosBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    if (bridge.failure != null) {
      return InfoBanner(
        FailureMessage(
          context: context,
          failure: bridge.failure,
        ).getMessage(),
        InfoBannerType.error,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (bridge.walletConfirmation == WalletConfirmation.archethic) {
      return InfoBanner(
        AppLocalizations.of(context)!.bridgeInProgressConfirmAEWallet,
        InfoBannerType.request,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (bridge.walletConfirmation == WalletConfirmation.evm) {
      return InfoBanner(
        AppLocalizations.of(context)!.bridgeInProgressConfirmEVMWallet,
        InfoBannerType.request,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (bridge.failure == null && bridge.isTransferInProgress == false) {
      return InfoBanner(
        AppLocalizations.of(context)!.bridgeInProgressInfoFinished,
        InfoBannerType.success,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    return InfoBanner(
      AppLocalizations.of(context)!.bridgeInProgressWaitConfirmWallet,
      InfoBannerType.request,
      width: MediaQuery.of(context).size.width * 0.9,
      waitAnimation: true,
    );
  }
}
