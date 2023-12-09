/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
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

    return Stack(
      children: [
        Center(
          child: Text(
            AppLocalizations.of(context)!.bridgeConfirmTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        BackButton(
          onPressed: bridge.tokenToBridge == null
              ? null
              : () {
                  ref
                      .read(BridgeFormProvider.bridgeForm.notifier)
                      .setBridgeProcessStep(
                        BridgeProcessStep.form,
                      );
                },
        ),
      ],
    );
  }
}
