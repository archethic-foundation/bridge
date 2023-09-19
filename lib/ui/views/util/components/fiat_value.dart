import 'package:aebridge/application/market.dart';
import 'package:aebridge/application/oracle/provider.dart';
import 'package:aebridge/ui/views/util/generic/formatters.dart';
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
          ref.watch(ArchethicOracleUCOProviders.archethicOracleUCO);

      final fiatValue = archethicOracleUCO.usd * amount;
      return '(\$${fiatValue.toStringAsFixed(2).formatNumber()})';
    } else {
      final price =
          await ref.watch(MarketProviders.getPriceFromSymbol(symbol).future);

      final fiatValue = price * amount;
      if (withParenthesis) {
        return '(\$${fiatValue.toStringAsFixed(2).formatNumber()})';
      } else {
        return '\$${fiatValue.toStringAsFixed(2).formatNumber()}';
      }
    }
  }
}
