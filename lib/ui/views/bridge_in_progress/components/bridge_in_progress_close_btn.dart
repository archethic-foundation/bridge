/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
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

    return SizedBox(
      height: 50,
      child: AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_close,
        icon: Iconsax.close_square,
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
    );
  }
}
