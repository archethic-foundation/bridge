import 'package:aebridge/domain/models/bridge_blockchain_environment.dart';

class FaucetUtil {
  static ({Uri uri, bool executeCatch}) getUrl(
    BridgeBlockchainEnvironment env,
    Map<String, dynamic> queryParameters,
  ) {
    if (env == BridgeBlockchainEnvironment.mainnet) {
      return (
        uri: Uri.https(
          'faucet.bridge.archethic.net',
          '/api/faucet',
          queryParameters,
        ),
        executeCatch: true
      );
    } else {
      if (env == BridgeBlockchainEnvironment.testnet) {
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
