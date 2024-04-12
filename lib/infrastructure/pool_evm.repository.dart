import 'dart:convert';
import 'package:aebridge/domain/repositories/pool_evm.repository.dart';
import 'package:flutter/services.dart';

class PoolsEVMRepositoryImpl implements PoolsEVMRepository {
  @override
  Future<String?> getPoolEVMAddress(int chainId, String symbol) async {
    final jsonContent =
        await rootBundle.loadString('lib/domain/repositories/pool_evm.json');

    final jsonData = jsonDecode(jsonContent);

    return jsonData['poolsEVM'][chainId.toString()]?[symbol];
  }
}
