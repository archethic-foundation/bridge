/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/util/custom_logs.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:coingecko_api/coingecko_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coingecko.g.dart';

@Riverpod(keepAlive: true)
class _CoinPriceNotifier extends Notifier<Map<String, double?>> {
  final CoinGeckoApi _api = CoinGeckoApi();
  Timer? _timer;

  @override
  Map<String, double?> build() {
    ref.onDispose(() {
      if (_timer != null) {
        _timer!.cancel();
      }
    });
    return <String, double?>{};
  }

  Future<void> init() async {
    await _fetchPrices();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) async {
      await _fetchPrices();
    });
  }

  Future<void> _fetchPrices() async {
    try {
      final coinResult = await _api.simple.listPrices(
        ids: ['ethereum', 'binancecoin', 'matic-network'],
        vsCurrencies: ['usd'],
      );
      if (coinResult.data.isNotEmpty) {
        state[coinResult.data[0].id] = coinResult.data[0].getPriceIn('usd');
        state[coinResult.data[1].id] = coinResult.data[1].getPriceIn('usd');
        state[coinResult.data[2].id] = coinResult.data[2].getPriceIn('usd');
      }
    } catch (e) {
      sl.get<LogManager>().log(
            e.toString(),
            level: LogLevel.error,
            name: 'CoinPriceNotifier - _fetchPrices',
          );
    }
  }
}

abstract class CoinPriceProviders {
  static final coinPrice = _coinPriceNotifierProvider;
}
