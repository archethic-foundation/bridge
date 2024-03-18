import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;

class FaucetUtil {
  static Uri getUrl(Map<String, dynamic> queryParameters) {
    final environment = aedappfm.EndpointUtil.getEnvironnement();

    switch (environment) {
      case 'mainnet':
        return Uri.https(
          'faucet.bridge.archethic.net',
          '/api/faucet',
          queryParameters,
        );
      case 'testnet':
        return Uri.https(
          'faucet.bridge.testnet.archethic.net',
          '/api/faucet',
          queryParameters,
        );
      default:
        return Uri.http(
          'localhost:8080',
          '/api/faucet',
          queryParameters,
        );
    }
  }
}
