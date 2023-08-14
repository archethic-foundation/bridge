/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_sheet.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_form_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeSheet extends ConsumerWidget {
  const BridgeSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    ref.listen<BridgeFormState>(
      BridgeFormProvider.bridgeForm,
      (_, bridge) {
        if (bridge.isControlsOk) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
            content: Text(
              bridge.errorText,
              style: Theme.of(context).snackBarTheme.contentTextStyle,
            ),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: AppLocalizations.of(context)!.ok,
              onPressed: () {},
            ),
          ),
        );

        ref.read(BridgeFormProvider.bridgeForm.notifier).setError(
              '',
            );
      },
    );

    if (bridge.bridgeProcessStep == BridgeProcessStep.form) {
      return const BridgeFormSheet();
    } else {
      return const BridgeConfirmSheet();
    }
  }
}
