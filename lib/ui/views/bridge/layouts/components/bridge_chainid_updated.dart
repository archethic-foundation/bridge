import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/main_screen/layouts/switch_evm_context_popup.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeChainIdUpdated extends ConsumerWidget {
  const BridgeChainIdUpdated({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(bridgeFormNotifierProvider, (previous, next) {
      if (next.chainIdUpdated == true && previous?.chainIdUpdated == false) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SwitchEVMContextPopup(
              switchEVMContextDesc:
                  AppLocalizations.of(context)!.switchNetworkDescBridge,
              onEVMContextSwitched: () async {
                final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
                await evmWalletProvider.useRequestedChain();

                ref
                    .read(bridgeFormNotifierProvider.notifier)
                    .setChainIdUpdated(false);

                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
              switchEVMContextBtnLabel:
                  AppLocalizations.of(context)!.btn_switch_network,
            );
          },
        );
      }
    });

    return const SizedBox.shrink();
  }
}
