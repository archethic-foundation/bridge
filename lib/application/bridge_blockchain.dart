/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';

import 'package:aebridge/model/bridge_blockchain.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bridge_blockchain.g.dart';

@riverpod
BridgeBlockchainsRepository _bridgeBlockchainsRepository(
  _BridgeBlockchainsRepositoryRef ref,
) =>
    BridgeBlockchainsRepository();

@riverpod
Future<List<BridgeBlockchain>> _getBlockchainsList(
  _GetBlockchainsListRef ref,
) async {
  return ref.watch(_bridgeBlockchainsRepositoryProvider).getBlockchainsList();
}

class BridgeBlockchainsRepository {
  Future<List<BridgeBlockchain>> getBlockchainsList() async {
    final jsonContent = await rootBundle
        .loadString('lib/domain/repositories/blockchains_list.json');

    final jsonData = jsonDecode(jsonContent);

    final blockchainsList =
        List<Map<String, dynamic>>.from(jsonData['blockchains']);

    final blockchainsListToSort =
        blockchainsList.map(BridgeBlockchain.fromJson).toList()
          ..sort((a, b) {
            final compareEnv = a.env.compareTo(b.env);
            if (compareEnv != 0) {
              return compareEnv;
            } else {
              return a.name.compareTo(b.name);
            }
          });

    return blockchainsListToSort;
  }
}

abstract class BridgeBlockchainsProviders {
  static final getBlockchainsList = _getBlockchainsListProvider;
}
