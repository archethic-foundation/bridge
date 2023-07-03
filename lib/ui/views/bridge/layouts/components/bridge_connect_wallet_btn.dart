/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
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
    final session = ref.watch(SessionProviders.session);
    if (session.isConnected == false) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_connect_wallet,
        icon: Iconsax.empty_wallet,
      );
    }

    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_connect_wallet,
      icon: Iconsax.wallet,
      onPressed: () {},
    );
  }
}
