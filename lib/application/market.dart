import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/repositories/market.repository.dart';
import 'package:aebridge/infrastructure/market.repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'market.g.dart';

@riverpod
MarketRepository _marketRepository(_MarketRepositoryRef ref) =>
    MarketRepositoryImpl();

@riverpod
Future<Result<double, Failure>> _getPriceFromCoinId(
  _GetPriceFromCoinIdRef ref,
  String coinId,
) async {
  debugPrint('_getPriceFromCoinId');
  return ref.read(_marketRepositoryProvider).getPrice(
        coinId,
      );
}

@riverpod
Future<double> _getPriceFromSymbol(
  _GetPriceFromSymbolRef ref,
  String symbol,
) async {
  String? coinId;
  switch (symbol) {
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
    return 0;
  }
  final result = await ref.read(
    MarketProviders.getPriceFromCoindId(coinId).future,
  );

  return result.map(success: (price) => price, failure: (failure) => 0);
}

abstract class MarketProviders {
  static const getPriceFromCoindId = _getPriceFromCoinIdProvider;
  static final marketRepository = _marketRepositoryProvider;
  static const getPriceFromSymbol = _getPriceFromSymbolProvider;
}
