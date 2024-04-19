abstract class PoolsRepository {
  Future<String?> getPoolAddress(int chainId, String symbol);

  Future<String?> getSymbolFromPoolAddress(
    int chainId,
    String poolAddress,
  );
}
