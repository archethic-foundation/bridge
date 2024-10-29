import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_evm_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BridgeLinkToWormhole extends ConsumerWidget {
  const BridgeLinkToWormhole({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAppMobileFormat = aedappfm.Responsive.isMobile(context);

    final bridge = ref.watch(bridgeFormNotifierProvider);
    final session = ref.watch(sessionNotifierProvider);

    if (bridge.blockchainFrom == null ||
        bridge.blockchainTo == null ||
        session.allWalletsIsConnected == false) {
      return const SizedBox.shrink();
    }

    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 5,
            top: 10,
            bottom: isAppMobileFormat ? 30 : 0,
          ),
          child: InkWell(
            onTap: () async {
              context.go(
                Uri(
                  path: BridgeEVMSheet.navPage,
                  queryParameters: {
                    'fromNetwork': bridge.blockchainFrom!.wormholeId ?? '',
                    'toNetwork': bridge.blockchainTo!.wormholeId ?? '',
                  },
                ).toString(),
              );
            },
            child: Text(
              textAlign: isAppMobileFormat ? TextAlign.center : null,
              AppLocalizations.of(context)!
                  .goToEVMBridgeWithBC
                  .replaceFirst(
                    '%1',
                    bridge.blockchainFrom!.name,
                  )
                  .replaceFirst(
                    '%2',
                    bridge.blockchainTo!.name,
                  ),
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                color: aedappfm.AppThemeBase.secondaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
