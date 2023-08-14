/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeConfirmBackButton extends ConsumerWidget {
  const BridgeConfirmBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    final session = ref.watch(SessionProviders.session);
    if (session.allWalletsIsConnected == false) {
      return const SizedBox();
    }
    if (bridge.tokenToBridge == null) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_back,
        icon: Iconsax.back_square,
        disabled: true,
      );
    }

    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_back,
      icon: Iconsax.back_square,
      onPressed: () {
        ref.watch(BridgeFormProvider.bridgeForm.notifier).setBridgeProcessStep(
              BridgeProcessStep.form,
            );
      },
    );
  }
}
