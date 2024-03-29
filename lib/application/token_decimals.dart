import 'package:aebridge/domain/repositories/token_decimals.repository.dart';
import 'package:aebridge/infrastructure/token_decimals.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_decimals.g.dart';

@riverpod
TokenDecimalsRepository _tokenDecimalsRepository(
  _TokenDecimalsRepositoryRef ref,
) =>
    TokenDecimalsRepositoryImpl();

@riverpod
Future<int> _getTokenDecimals(
  _GetTokenDecimalsRef ref,
  bool isArchethic,
  String typeToken,
  String tokenAddress, {
  String? providerEndpoint,
}) async {
  return ref.read(_tokenDecimalsRepositoryProvider).getTokenDecimals(
        isArchethic,
        typeToken,
        tokenAddress,
        providerEndpoint: providerEndpoint,
      );
}

abstract class TokenDecimalsProviders {
  static const getTokenDecimals = _getTokenDecimalsProvider;
  static final tokenDecimalsRepository = _tokenDecimalsRepositoryProvider;
}
