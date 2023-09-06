import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge_in_progress/bridge_in_progress_popup.dart';
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressResumeBtn extends ConsumerWidget {
  const BridgeInProgressResumeBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    if (bridge.isTransferInProgress == false &&
        bridge.failure != null &&
        bridge.currentStep > 0) {
      return AppButton(
        labelBtn: AppLocalizations.of(context)!.btn_resume_bridge,
        icon: Iconsax.recovery_convert,
        onPressed: () async {
          await ref
              .read(BridgeFormProvider.bridgeForm.notifier)
              .bridge(context, ref);

          if (!context.mounted) return;
          await BridgeInProgressPopup.getDialog(
            context,
            ref,
          );
        },
      );
    }
    return const SizedBox();
  }
}
