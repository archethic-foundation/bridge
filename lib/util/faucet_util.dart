class FaucetUtil {
  static Uri getUrl(Map<String, dynamic> queryParameters) {
    if (Uri.base.toString().toLowerCase().contains('bridge.archethic')) {
      return Uri.https(
        'faucet.bridge.archethic.net',
        '/api/faucet',
        queryParameters,
      );
    } else {
      if (Uri.base
          .toString()
          .toLowerCase()
          .contains('bridge.testnet.archethic')) {
        return Uri.https(
          'faucet.bridge.testnet.archethic.net',
          '/api/faucet',
          queryParameters,
        );
      } else {
        return Uri.http(
          'localhost:8080',
          '/api/faucet',
          queryParameters,
        );
      }
    }
  }
}
