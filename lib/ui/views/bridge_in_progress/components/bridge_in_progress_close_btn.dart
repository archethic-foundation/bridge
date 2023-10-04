/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressCloseBtn extends ConsumerWidget {
  const BridgeInProgressCloseBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    if (bridge.isTransferInProgress) {
      return const SizedBox();
    }

    return Row(
      children: [
        const Spacer(),
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.btn_close,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onPressed: () async {
            final bridgeNotifier =
                ref.read(BridgeFormProvider.bridgeForm.notifier);
            await bridgeNotifier.initState();

            if (!context.mounted) return;

            Navigator.of(context).pop();
            if (bridge.resumeProcess) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
