/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/market.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
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

    if (bridge.tokenToBridge == null) {
      return const SizedBox();
    }

    final timestamp = DateFormat.yMMMEd(
      Localizations.localeOf(context).languageCode,
    ).add_Hm().format(
          DateTime.now(),
        );

    String? coinId;
    switch (bridge.tokenToBridge!.symbol) {
      case 'ETH':
      case 'WETH':
        coinId = 'ethereum';
        break;
      case 'BSC':
        coinId = 'binance-usd';
        break;
      case 'MATIC':
        coinId = 'polygon';
        break;
    }

    if (coinId == null) {
      return const SizedBox();
    }
    return FutureBuilder<Result<double, Failure>>(
      future: ref.watch(MarketProviders.marketRepository).getPrice(coinId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.map(
            success: (price) => Text(
              '1 ${bridge.tokenToBridge!.symbol} = \$$price ($timestamp)',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
              ),
            ),
            failure: (failure) => const SizedBox(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
