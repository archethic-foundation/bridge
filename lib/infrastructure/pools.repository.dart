import 'dart:convert';
import 'package:aebridge/domain/repositories/pools.repository.dart';
import 'package:flutter/services.dart';

class PoolsRepositoryImpl implements PoolsRepository {
  @override
  Future<String?> getPoolAddress(int chainId, String symbol) async {
    final jsonContent =
        await rootBundle.loadString('lib/domain/repositories/pools.json');

    final jsonData = jsonDecode(jsonContent);

    return jsonData['pools'][chainId.toString()]?[symbol];
  }

  @override
  Future<String?> getSymbolFromPoolAddress(
    int chainId,
    String poolAddress,
  ) async {
    final jsonContent =
        await rootBundle.loadString('lib/domain/repositories/pools.json');

    final jsonData = jsonDecode(jsonContent);

    String? symbol;
    (jsonData['pools'][chainId.toString()] as Map).forEach((key, value) {
      if (value.toUpperCase() == poolAddress.toUpperCase()) {
        symbol = key;
        return;
      }
    });

    return symbol!;
  }
}
