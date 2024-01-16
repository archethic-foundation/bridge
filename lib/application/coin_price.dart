/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'package:aebridge/domain/models/crypto_price.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coin_price.g.dart';

@Riverpod(keepAlive: true)
class _CoinPriceNotifier extends Notifier<CryptoPrice> {
  Timer? _timer;

  @override
  CryptoPrice build() {
    ref.onDispose(() {
      if (_timer != null) {
        _timer!.cancel();
      }
    });
    return CryptoPrice();
  }

  Future<void> init() async {
    await fetchPrices();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) async {
      await fetchPrices();
    });
  }

  Future<CryptoPrice?> fetchPrices() async {
    // UCIDs
    // 3890 : Polygon
    // 1027 : Ethereum
    // 1839 : BSC
    const url =
        'https://fas.archethic.net/api/v1/quotes/latest?ucids=1027,3890,1839';
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final pricesMap = _extractPriceMethods(response.body);
        return CryptoPrice.fromJson(pricesMap);
      }
      // ignore: unused_catch_stack
    } catch (e, stacktrace) {
      /*  sl.get<LogManager>().log(
            e.toString(),
            stackTrace: stacktrace,
            level: LogLevel.error,
            name: 'CoinPriceNotifier - _fetchPrices',
          );*/
    }

    return CryptoPrice();
  }

  Map<String, double> _extractPriceMethods(String responseBody) {
    final jsonData = json.decode(responseBody) as Map<String, dynamic>;
    return {
      'polygon': jsonData['3890'],
      'ethereum': jsonData['1027'],
      'bsc': jsonData['1839'],
    };
  }
}

abstract class CoinPriceProviders {
  static final coinPrice = _coinPriceNotifierProvider;
}
