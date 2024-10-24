enum BridgeBlockchainEnvironment {
  mainnet(
    name: '1-mainnet',
  ),
  testnet(
    name: '2-testnet',
  ),
  devnet(
    name: '3-devnet',
  );

  const BridgeBlockchainEnvironment({
    required this.name,
  });

  final String name;

  static BridgeBlockchainEnvironment byName(String name) =>
      BridgeBlockchainEnvironment.values.firstWhere(
        (environment) => environment.name == name,
      );
}
