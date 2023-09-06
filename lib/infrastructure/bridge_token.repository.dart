import 'dart:convert';

import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:aebridge/domain/models/bridge_token_per_bridge.dart';
import 'package:aebridge/domain/repositories/bridge_tokens.repository.dart';
import 'package:flutter/services.dart';

class BridgeTokensRepositoryImpl implements BridgeTokensRepository {
  @override
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
