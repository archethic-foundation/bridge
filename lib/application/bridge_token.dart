/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:aebridge/domain/repositories/bridge_tokens.repository.dart';
import 'package:aebridge/infrastructure/bridge_token.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bridge_token.g.dart';

@riverpod
BridgeTokensRepository _bridgeTokensRepository(
  _BridgeTokensRepositoryRef ref,
) =>
    BridgeTokensRepositoryImpl();

@riverpod
Future<List<BridgeToken>> _getTokensListPerBridge(
  _GetTokensListPerBridgeRef ref,
  String direction,
) async {
  return ref
      .watch(_bridgeTokensRepositoryProvider)
      .getTokensListPerBridge(direction);
}

abstract class BridgeTokensProviders {
  static const getTokensListPerBridge = _getTokensListPerBridgeProvider;
}
