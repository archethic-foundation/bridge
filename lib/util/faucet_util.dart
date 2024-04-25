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
        // TODO(redwwarf03): MAINNET
        return Uri.https(
          'faucet.bridge.archethic.net',
          '/api/faucet',
          queryParameters,
        );
      }
    }
  }
}
