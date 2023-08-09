import 'package:aebridge/application/metamask.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'balance.g.dart';

@riverpod
BalanceRepository _balanceRepository(_BalanceRepositoryRef ref) =>
    BalanceRepository();

@riverpod
Future<double> _getBalance(
  _GetBalanceRef ref,
  bool isArchethic,
  String address,
  String typeToken,
  String tokenAddress,
) async {
  return ref
      .watch(_balanceRepositoryProvider)
      .getBalance(isArchethic, address, typeToken, tokenAddress);
}

class BalanceRepository {
  Future<double> getBalance(
    bool isArchethic,
    String address,
    String typeToken,
    String tokenAddress,
  ) async {
    if (isArchethic) {
      final balanceGetResponseMap =
          await sl.get<ApiService>().fetchBalance([address]);
      if (balanceGetResponseMap[address] == null) {
        return 0.0;
      }
      final balanceGetResponse = balanceGetResponseMap[address];
      if (tokenAddress.isEmpty) {
        return fromBigInt(balanceGetResponse!.uco).toDouble();
      }

      for (final balanceToken in balanceGetResponse!.token) {
        if (balanceToken.address == tokenAddress) {
          return fromBigInt(balanceToken.amount).toDouble();
        }
      }
    } else {
      switch (typeToken) {
        case 'Native':
          final balance = await sl.get<MetaMaskProvider>().getBalance(
                typeToken,
              );
          return balance;

        case 'ERC20':
          final balance = await sl.get<MetaMaskProvider>().getBalance(
                typeToken,
                erc20address: tokenAddress,
              );
          return balance;
        default:
      }
    }
    return 0.0;
  }
}

abstract class BalanceProviders {
  static const getBalance = _getBalanceProvider;
  static final balanceRepository = _balanceRepositoryProvider;
}
