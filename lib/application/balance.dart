import 'package:aebridge/domain/repositories/balance.repository.dart';
import 'package:aebridge/infrastructure/balance.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'balance.g.dart';

@riverpod
BalanceRepository _balanceRepository(Ref ref) => BalanceRepositoryImpl();

@riverpod
Future<double> getBalance(
  Ref ref,
  bool isArchethic,
  String address,
  String typeToken,
  String tokenAddress,
  int decimal,
) async {
  return ref.read(_balanceRepositoryProvider).getBalance(
        isArchethic,
        address,
        typeToken,
        tokenAddress,
        decimal,
      );
}
