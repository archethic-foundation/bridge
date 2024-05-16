class FaucetUtil {
  static ({Uri uri, bool executeCatch}) getUrl(
    String env,
    Map<String, dynamic> queryParameters,
  ) {
    if (env == '1-mainnet') {
      return (
        uri: Uri.https(
          'faucet.bridge.archethic.net',
          '/api/faucet',
          queryParameters,
        ),
        executeCatch: true
      );
    } else {
      if (env == '2-testnet') {
        return (
          uri: Uri.https(
            'faucet.bridge.testnet.archethic.net',
            '/api/faucet',
            queryParameters,
          ),
          executeCatch: true
        );
      } else {
        return (
          uri: Uri.http(
            'localhost:8080',
            '/api/faucet',
            queryParameters,
          ),
          // Because of CORS policy
          executeCatch: false
        );
      }
    }
  }
}
