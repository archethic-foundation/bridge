import 'package:aebridge/domain/models/bridge_token.dart';

abstract class BridgeTokensRepository {
  Future<List<BridgeToken>> getTokensListPerBridge(String? direction);
}
