import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/repositories/market.repository.dart';
import 'package:aebridge/infrastructure/market.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'market.g.dart';

@riverpod
MarketRepository _marketRepository(_MarketRepositoryRef ref) =>
    MarketRepositoryImpl();

@riverpod
Future<Result<double, Failure>> _getPrice(
  _GetPriceRef ref,
  String coinId,
) async {
  return ref.read(_marketRepositoryProvider).getPrice(
        coinId,
      );
}

abstract class MarketProviders {
  static const getPrice = _getPriceProvider;
  static final marketRepository = _marketRepositoryProvider;
}
