import 'package:aebridge/domain/repositories/token_decimals.repository.dart';
import 'package:aebridge/infrastructure/token_decimals.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_decimals.g.dart';

@riverpod
TokenDecimalsRepository _tokenDecimalsRepository(
  Ref ref,
) =>
    TokenDecimalsRepositoryImpl();

@riverpod
Future<int> getTokenDecimals(
  Ref ref,
  bool isArchethic,
  String typeToken,
  String tokenAddress,
) async {
  return ref.read(_tokenDecimalsRepositoryProvider).getTokenDecimals(
        isArchethic,
        typeToken,
        tokenAddress,
      );
}
