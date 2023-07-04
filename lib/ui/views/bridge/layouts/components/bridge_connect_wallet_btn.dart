/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeConnectWalletButton extends ConsumerWidget {
  const BridgeConnectWalletButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    final session = ref.watch(SessionProviders.session);
    if (session.isConnected) {
      return const SizedBox();
    }
    if (bridge.blockchainFrom == null) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_connect_wallet,
        icon: Iconsax.empty_wallet,
        disabled: true,
      );
    }

    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_connect_wallet,
      icon: Iconsax.wallet,
      onPressed: () async {
        final sessionNotifier = ref.read(SessionProviders.session.notifier);
        if (bridge.blockchainFrom!.name == 'Archethic') {
          await sessionNotifier.connectToArchethicWallet();
        } else {
          await sessionNotifier.connectToMetamask();
        }
        final session = ref.read(SessionProviders.session);
        if (session.error.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
              content: Text(
                session.error,
                style: Theme.of(context).snackBarTheme.contentTextStyle,
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          //
        }
      },
    );
  }
}
