import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/repositories/balance.repository.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  @override
  Future<double> getBalance(
    bool isArchethic,
    String address,
    String typeToken,
    String tokenAddress, {
    String? providerEndpoint,
  }) async {
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
        if (balanceToken.address!.toUpperCase() == tokenAddress.toUpperCase()) {
          return fromBigInt(balanceToken.amount).toDouble();
        }
      }
    } else {
      switch (typeToken) {
        case 'Native':
          final balance = await sl.get<EVMWalletProvider>().getBalance(
                providerEndpoint!,
                typeToken,
              );
          return balance;

        case 'ERC20':
        case 'Wrapped':
          final balance = await sl.get<EVMWalletProvider>().getBalance(
                providerEndpoint!,
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
