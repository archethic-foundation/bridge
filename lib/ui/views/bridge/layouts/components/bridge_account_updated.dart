import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/main_screen/layouts/switch_evm_context_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

class BridgeAccountUpdated extends ConsumerWidget {
  const BridgeAccountUpdated({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(bridgeFormNotifierProvider, (previous, next) {
      if (next.accountUpdated == true && previous?.accountUpdated == false) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SwitchEVMContextPopup(
              switchEVMContextDesc:
                  AppLocalizations.of(context)!.switchAccountDescBridge,
              onEVMContextSwitched: () async {
                final currentAccountAddress = wagmi.Core.getAccount().address;
                if (currentAccountAddress == null ||
                    next.processCurrentAccountAddressEVM == null ||
                    currentAccountAddress.toUpperCase() !=
                        next.processCurrentAccountAddressEVM!.toUpperCase()) {
                  return;
                }

                ref
                    .read(bridgeFormNotifierProvider.notifier)
                    .setAccountUpdated(false);

                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
              switchEVMContextBtnLabel:
                  AppLocalizations.of(context)!.btn_switch_account,
            );
          },
        );
      }
    });

    return const SizedBox.shrink();
  }
}
