/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/balance.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeTokenToBridgeBalance extends ConsumerWidget {
  const BridgeTokenToBridgeBalance({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    if (bridge.blockchainFrom == null || bridge.tokenToBridge == null) {
      return const SizedBox();
    }

    final session = ref.watch(SessionProviders.session);

    return ref
        .watch(
      BalanceProviders.getBalance(
        bridge.blockchainFrom!.isArchethic,
        session.walletFrom!.genesisAddress,
        bridge.tokenToBridge!.type,
        bridge.tokenToBridge!.tokenAddress,
        providerEndpoint: bridge.blockchainFrom!.providerEndpoint,
      ),
    )
        .when(
      loading: () {
        debugPrint('balance loading');
        return const SizedBox(
          height: 10,
          width: 10,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
        );
      },
      error: (err, stack) {
        debugPrint('balance error');
        return Text(
          '${AppLocalizations.of(context)!.balance_title_infos} Not available',
        );
      },
      data: (data) {
        debugPrint('balance value $data');
        return Text(
          '${AppLocalizations.of(context)!.balance_title_infos} ${data.toStringAsFixed(4).replaceAll(RegExp(r"0*$"), "").replaceAll(RegExp(r"\.$"), "").formatNumber()} ${bridge.tokenToBridge!.symbol}',
        );
      },
    );
  }
}
