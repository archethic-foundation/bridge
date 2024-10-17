import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/repositories/balance.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();

  @override
  Future<double> getBalance(
    bool isArchethic,
    String address,
    String typeToken,
    String tokenAddress,
    int decimal,
  ) async {
    if (isArchethic) {
      final balanceGetResponseMap =
          await aedappfm.sl.get<ApiService>().fetchBalance([address]);
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
          final balance = await evmWalletProvider.getBalance(
            address,
            typeToken,
            decimal,
          );
          return balance;
        case 'Wrapped':
          final balance = await evmWalletProvider.getBalance(
            address,
            typeToken,
            decimal,
            erc20address: tokenAddress,
          );
          return balance;
        default:
      }
    }
    return 0.0;
  }
}
