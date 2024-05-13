class FaucetUtil {
  static ({Uri uri, bool executeCatch}) getUrl(
    Map<String, dynamic> queryParameters,
  ) {
    if (Uri.base.toString().toLowerCase().contains('bridge.archethic')) {
      return (
        uri: Uri.https(
          'faucet.bridge.archethic.net',
          '/api/faucet',
          queryParameters,
        ),
        executeCatch: true
      );
    } else {
      if (Uri.base
          .toString()
          .toLowerCase()
          .contains('bridge.testnet.archethic')) {
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
