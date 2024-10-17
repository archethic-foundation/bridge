/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/util/components/fiat_value.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeTokenBridgedBalance extends ConsumerWidget {
  const BridgeTokenBridgedBalance({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(bridgeFormNotifierProvider);

    if (bridge.blockchainFrom == null || bridge.tokenToBridge == null) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<String>(
      future: FiatValue().display(
        ref,
        bridge.tokenToBridge!.targetTokenSymbol,
        bridge.tokenBridgedBalance,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Flexible(
            child: Text(
              '${AppLocalizations.of(context)!.balance_title_infos} ${bridge.tokenBridgedBalance.formatNumber()} ${bridge.tokenToBridge!.targetTokenSymbol} ${snapshot.data}',
              overflow: TextOverflow.visible,
              textAlign: TextAlign.end,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
