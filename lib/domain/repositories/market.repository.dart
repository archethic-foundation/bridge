import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';

abstract class MarketRepository {
  Future<Result<double, Failure>> getPrice(
    String coinId,
  );
}
