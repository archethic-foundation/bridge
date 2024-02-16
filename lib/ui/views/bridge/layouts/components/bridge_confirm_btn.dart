/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_in_progress_popup.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeConfirmButton extends ConsumerWidget {
  const BridgeConfirmButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    final session = ref.watch(SessionProviders.session);
    if (session.allWalletsIsConnected == false) {
      return const SizedBox.shrink();
    }
    if (bridge.tokenToBridge == null) {
      return aedappfm.AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_confirm_bridge,
        disabled: true,
      );
    }

    if (bridge.currentStep > 0) {
      return aedappfm.AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_resume_bridge,
        onPressed: () async {
          ref
              .read(BridgeFormProvider.bridgeForm.notifier)
              .setResumeProcess(true);
          unawaited(
            ref
                .read(BridgeFormProvider.bridgeForm.notifier)
                .bridge(context, ref),
          );

          if (!context.mounted) return;
          await BridgeInProgressPopup.getDialog(
            context,
            ref,
          );
        },
      );
    }

    return aedappfm.AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_confirm_bridge,
      onPressed: () async {
        ref
            .read(BridgeFormProvider.bridgeForm.notifier)
            .setResumeProcess(false);
        unawaited(
          ref.read(BridgeFormProvider.bridgeForm.notifier).bridge(context, ref),
        );

        if (!context.mounted) return;
        await BridgeInProgressPopup.getDialog(
          context,
          ref,
        );
      },
    );
  }
}
