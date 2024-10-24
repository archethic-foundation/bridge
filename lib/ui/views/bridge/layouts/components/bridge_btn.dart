/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeButton extends ConsumerWidget {
  const BridgeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(bridgeFormNotifierProvider);
    final session = ref.watch(sessionNotifierProvider);
    if (session.allWalletsIsConnected == false) {
      return const SizedBox.shrink();
    }
    if (bridge.tokenToBridge == null) {
      return const SizedBox.shrink();
    }

    return aedappfm.AppButton(
      disabled: !bridge.isControlsOk,
      labelBtn: AppLocalizations.of(context)!.btn_bridge,
      onPressed: () async {
        final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);
        await bridgeNotifier.validateForm(AppLocalizations.of(context)!);
      },
    );
  }
}
