import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/repositories/token_decimals.repository.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class TokenDecimalsRepositoryImpl implements TokenDecimalsRepository {
  @override
  Future<int> getTokenDecimals(
    bool isArchethic,
    String typeToken,
    String tokenAddress, {
    String? providerEndpoint,
  }) async {
    if (isArchethic) {
      final balanceGetResponseMap = await sl
          .get<ApiService>()
          .getToken([tokenAddress], request: 'decimals');
      if (balanceGetResponseMap[tokenAddress] == null) {
        return 8;
      }

      return balanceGetResponseMap[tokenAddress]!.decimals ?? 8;
    } else {
      switch (typeToken) {
        case 'Native':
          final decimals = await sl.get<EVMWalletProvider>().getTokenDecimals(
                providerEndpoint!,
                typeToken,
              );
          return decimals;

        case 'ERC20':
        case 'Wrapped':
          final decimals = await sl.get<EVMWalletProvider>().getTokenDecimals(
                providerEndpoint!,
                typeToken,
                erc20address: tokenAddress,
              );
          return decimals;
        default:
      }
    }
    return 8;
  }
}
