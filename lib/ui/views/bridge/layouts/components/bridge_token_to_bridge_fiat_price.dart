/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BridgeTokenToBridgeFiatPrice extends ConsumerWidget {
  const BridgeTokenToBridgeFiatPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    if (bridge.tokenToBridge == null || bridge.tokenToBridge!.symbol == 'UCO') {
      return const SizedBox.shrink();
    }

    final prices = ref.watch(aedappfm.CoinPriceProviders.coinPrice);

    var price = 0.0;

    switch (bridge.tokenToBridge!.symbol) {
      case 'ETH':
      case 'aeETH':
        price = prices.ethereum;
        break;
      case 'BNB':
      case 'aeBNB':
        price = prices.bsc;
        break;
      case 'MATIC':
      case 'aeMATIC':
        price = prices.polygon;
        break;
    }
    if (price == 0) {
      return const SizedBox.shrink();
    }

    final timestamp = DateFormat.yMMMEd(
      Localizations.localeOf(context).languageCode,
    ).add_Hm().format(
          DateTime.now(),
        );

    return SelectableText(
      '1 ${bridge.tokenToBridge!.symbol} = \$${price.formatNumber(precision: 2)} ($timestamp)',
      style: TextStyle(
        fontSize: aedappfm.Responsive.fontSizeFromValue(
          context,
          desktopValue: Theme.of(context).textTheme.labelSmall!.fontSize!,
        ),
      ),
    );
  }
}
