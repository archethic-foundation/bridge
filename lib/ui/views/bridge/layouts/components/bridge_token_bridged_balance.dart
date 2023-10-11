/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/components/fiat_value.dart';
import 'package:aebridge/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeTokenBridgedBalance extends ConsumerWidget {
  const BridgeTokenBridgedBalance({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    if (bridge.blockchainFrom == null || bridge.tokenToBridge == null) {
      return const SizedBox();
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
              '${AppLocalizations.of(context)!.balance_title_infos} ${bridge.tokenBridgedBalance.toStringAsFixed(2).replaceAll(RegExp(r"0*$"), "").replaceAll(RegExp(r"\.$"), "").formatNumber()} ${bridge.tokenToBridge!.targetTokenSymbol} ${snapshot.data}',
              overflow: TextOverflow.visible,
              textAlign: TextAlign.end,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
