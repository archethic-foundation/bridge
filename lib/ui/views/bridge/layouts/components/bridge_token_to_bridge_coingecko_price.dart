/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/coingecko.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BridgeTokenToBridgeCoingeckoPrice extends ConsumerWidget {
  const BridgeTokenToBridgeCoingeckoPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    if (bridge.tokenToBridge == null || bridge.tokenToBridge!.symbol == 'UCO') {
      return const SizedBox.shrink();
    }

    final prices = ref.watch(CoinPriceProviders.coinPrice);

    var price = 0.0;

    switch (bridge.tokenToBridge!.symbol) {
      case 'ETH':
      case 'aeETH':
        if (prices['ethereum'] != null) price = prices['ethereum']!;
        break;
      case 'BNB':
      case 'aeBNB':
        if (prices['binancecoin'] != null) price = prices['binancecoin']!;
        break;
      case 'MATIC':
      case 'aeMATIC':
        if (prices['matic-network'] != null) price = prices['matic-network']!;
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

    return Text(
      '1 ${bridge.tokenToBridge!.symbol} = \$$price ($timestamp)',
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
      ),
    );
  }
}
