/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeButton extends ConsumerWidget {
  const BridgeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.newBridgeForm);
    final session = ref.watch(SessionProviders.session);
    if (session.allWalletsIsConnected == false) {
      return const SizedBox();
    }
    if (bridge.tokenToBridge == null) {
      return const SizedBox();
    }

    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_bridge,
      icon: Iconsax.recovery_convert,
      onPressed: () async {
        final bridgeNotifier =
            ref.read(BridgeFormProvider.newBridgeForm.notifier);
        await bridgeNotifier.validateForm();
      },
    );
  }
}
