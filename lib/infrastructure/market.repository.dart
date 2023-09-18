// ignore_for_file: avoid_redundant_argument_values

import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/repositories/market.repository.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:coingecko_api/coingecko_api.dart';

class MarketRepositoryImpl implements MarketRepository {
  CoinGeckoApi? _coinGeckoApi;
  CoinGeckoApi get coinGeckoApi => _coinGeckoApi ??= sl.get<CoinGeckoApi>();

  @override
  Future<Result<double, Failure>> getPrice(
    String coinId,
  ) async =>
      Result.guard(
        () async {
          final coinResult = await coinGeckoApi.simple.listPrices(
            ids: [coinId],
            vsCurrencies: ['usd'],
            include24hChange: false,
            include24hVol: false,
            includeLastUpdatedAt: false,
            includeMarketCap: false,
          );
          final price = coinResult.data.isNotEmpty
              ? coinResult.data[0].getPriceIn('usd')
              : null;

          if (price == null) throw const Failure.invalidValue();
          return price;
        },
      );
}
