abstract class BalanceRepository {
  Future<double> getBalance(
    bool isArchethic,
    String address,
    String typeToken,
    String tokenAddress,
  );
}
