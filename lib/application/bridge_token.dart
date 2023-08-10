/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';

import 'package:aebridge/model/bridge_token.dart';
import 'package:aebridge/model/bridge_token_per_bridge.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bridge_token.g.dart';

@riverpod
BridgeTokensRepository _bridgeTokensRepository(
  _BridgeTokensRepositoryRef ref,
) =>
    BridgeTokensRepository();

@riverpod
Future<List<BridgeToken>> _getTokensListPerBridge(
  _GetTokensListPerBridgeRef ref,
  String direction,
) async {
  return ref
      .watch(_bridgeTokensRepositoryProvider)
      .getTokensListPerBridge(direction);
}

class BridgeTokensRepository {
  Future<List<BridgeToken>> getTokensListPerBridge(String? direction) async {
    if (direction == null) {
      return [];
    }

    final jsonContent = await rootBundle
        .loadString('lib/domain/repositories/tokens_list_per_bridge.json');

    final jsonData = jsonDecode(jsonContent);
    final tokens = BridgeTokensPerBridge.fromJson(jsonData);

    final bridgeTokens = <BridgeToken>[];

    tokens.tokens!.forEach((key, value) {
      if (key == direction) {
        for (final token in value) {
          bridgeTokens.add(
            BridgeToken(
              name: token.name,
              symbol: token.symbol,
              targetTokenName: token.targetTokenName,
              targetTokenSymbol: token.targetTokenSymbol,
              type: token.type,
              poolAddressFrom: token.poolAddressFrom,
              poolAddressTo: token.poolAddressTo,
              tokenAddress: token.tokenAddress,
            ),
          );
        }
      }
    });

    return bridgeTokens;
  }
}

abstract class BridgeTokensProviders {
  static const getTokensListPerBridge = _getTokensListPerBridgeProvider;
}
