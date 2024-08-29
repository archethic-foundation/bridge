import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:aebridge/domain/models/bridge_token_per_bridge.dart';

abstract class BridgeTokensRepository {
  Future<List<BridgeToken>> getTokensListPerBridge(String? direction);

  Future<BridgeTokensPerBridge> getTokensListPerBridgeConf();
}
