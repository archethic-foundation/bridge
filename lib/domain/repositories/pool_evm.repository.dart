abstract class PoolsEVMRepository {
  Future<String?> getPoolEVMAddress(int chainId, String symbol);
}
