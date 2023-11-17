/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/util/custom_logs.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coin_price.g.dart';

@Riverpod(keepAlive: true)
class _CoinPriceNotifier extends Notifier<Map<String, double?>> {
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
    await fetchPrices(['polygon', 'ethereum', 'bnb']);
    _timer = Timer.periodic(const Duration(minutes: 1), (_) async {
      await fetchPrices(['polygon', 'ethereum', 'bnb']);
    });
  }

  Future<Map<String, dynamic>> fetchPrices(List<String> pairs) async {
    final prices = <String, dynamic>{};

    for (final pair in pairs) {
      final price = await _fetchPrice(pair);
      if (price != null) {
        sl.get<LogManager>().log(
              '$pair = $price',
              level: LogLevel.debug,
              name: 'CoinPriceNotifier - _fetchPrices',
            );

        state[pair] = price;
      }
    }

    return prices;
  }

  Future<dynamic> _fetchPrice(String coin) async {
    final url = 'https://coinmarketcap.com/currencies/$coin/markets/';
    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36',
      'Accept': 'text/html',
      'Accept-Language': 'en-US,en;q=0.9',
      'Upgrade-Insecure-Requests': '1',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return _extractPriceMethods(response.body);
      }
    } catch (e, stacktrace) {
      sl.get<LogManager>().log(
            e.toString(),
            stackTrace: stacktrace,
            level: LogLevel.error,
            name: 'CoinPriceNotifier - _fetchPrices',
          );
    }
    return null;
  }

  dynamic _extractPriceMethods(String body) {
    final document = parse(body);

    var price = _extractMethod1(document);
    if (price != null) {
      return price;
    }
    price = _extractMethod2(document);
    if (price != null) {
      return price;
    }
    throw Exception('Failed to parse price');
  }

  double? _extractMethod1(Document document) {
    final descriptionElement =
        document.querySelector("meta[name='description']");
    if (descriptionElement != null) {
      final match = RegExp('price today is (.+) with a')
          .firstMatch(descriptionElement.attributes['content']!);
      if (match != null) {
        return double.tryParse(_filterNumbers(match.group(1)!));
      }
    }
    return null;
  }

  double? _extractMethod2(Document document) {
    final priceElement =
        document.querySelector('div.priceTitle > div.priceValue > span');
    if (priceElement != null) {
      return double.tryParse(_filterNumbers(priceElement.text));
    }
    return null;
  }

  String _filterNumbers(String input) {
    return input.replaceAll(RegExp('[^0-9.]'), '');
  }
}

abstract class CoinPriceProviders {
  static final coinPrice = _coinPriceNotifierProvider;
}
