abstract class TokenDecimalsRepository {
  Future<int> getTokenDecimals(
    bool isArchethic,
    String typeToken,
    String tokenAddress, {
    String? providerEndpoint,
  });
}
