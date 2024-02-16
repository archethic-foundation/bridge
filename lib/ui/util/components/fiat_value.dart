import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later
class FiatValue {
  Future<String> display(
    WidgetRef ref,
    String symbol,
    double amount, {
    bool withParenthesis = true,
  }) async {
    if (symbol == 'UCO') {
      final archethicOracleUCO =
          ref.watch(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO);

      final fiatValue = archethicOracleUCO.usd * amount;
      return '(\$${fiatValue.formatNumber(precision: 2)})';
    } else {
      final prices = ref.watch(aedappfm.CoinPriceProviders.coinPrice);
      var price = 0.0;

      switch (symbol) {
        case 'ETH':
        case 'aeETH':
          price = price = prices.ethereum;
          break;
        case 'BNB':
        case 'aeBNB':
          price = price = prices.bsc;
          break;
        case 'MATIC':
        case 'aeMATIC':
          price = price = prices.polygon;
          break;
      }

      final fiatValue = price * amount;
      if (withParenthesis) {
        return '(\$${fiatValue.formatNumber(precision: 2)})';
      } else {
        return '\$${fiatValue.formatNumber(precision: 2)}';
      }
    }
  }
}
