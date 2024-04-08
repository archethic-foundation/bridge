import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/repositories/token_decimals.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class TokenDecimalsRepositoryImpl implements TokenDecimalsRepository {
  @override
  Future<int> getTokenDecimals(
    bool isArchethic,
    String typeToken,
    String tokenAddress,
  ) async {
    if (isArchethic) {
      final balanceGetResponseMap = await aedappfm.sl
          .get<ApiService>()
          .getToken([tokenAddress], request: 'decimals');
      if (balanceGetResponseMap[tokenAddress] == null) {
        return 8;
      }

      return balanceGetResponseMap[tokenAddress]!.decimals ?? 8;
    } else {
      switch (typeToken) {
        case 'Native':
          final decimals =
              await aedappfm.sl.get<EVMWalletProvider>().getTokenDecimals(
                    typeToken,
                  );
          return decimals;
        case 'Wrapped':
          final decimals =
              await aedappfm.sl.get<EVMWalletProvider>().getTokenDecimals(
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
