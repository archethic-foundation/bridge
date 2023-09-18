import 'package:aebridge/domain/repositories/balance.repository.dart';
import 'package:aebridge/infrastructure/balance.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'balance.g.dart';

@riverpod
BalanceRepository _balanceRepository(_BalanceRepositoryRef ref) =>
    BalanceRepositoryImpl();

@riverpod
Future<double> _getBalance(
  _GetBalanceRef ref,
  bool isArchethic,
  String address,
  String typeToken,
  String tokenAddress, {
  String? providerEndpoint,
}) async {
  return ref.read(_balanceRepositoryProvider).getBalance(
        isArchethic,
        address,
        typeToken,
        tokenAddress,
        providerEndpoint: providerEndpoint,
      );
}

abstract class BalanceProviders {
  static const getBalance = _getBalanceProvider;
  static final balanceRepository = _balanceRepositoryProvider;
}
