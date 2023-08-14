/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';

import 'package:aebridge/model/bridge_blockchain.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bridge_blockchain.g.dart';

@riverpod
Future<List<BridgeBlockchain>> _getBlockchainsListConf(
  _GetBlockchainsListRef ref,
) async {
  return ref
      .watch(_bridgeBlockchainsRepositoryProvider)
      .getBlockchainsListConf();
}

@riverpod
BridgeBlockchainsRepository _bridgeBlockchainsRepository(
  _BridgeBlockchainsRepositoryRef ref,
) =>
    BridgeBlockchainsRepository();

@riverpod
Future<List<BridgeBlockchain>> _getBlockchainsList(
  _GetBlockchainsListRef ref,
) async {
  final blockchainsList = await ref
      .watch(_bridgeBlockchainsRepositoryProvider)
      .getBlockchainsListConf();
  return ref
      .watch(_bridgeBlockchainsRepositoryProvider)
      .getBlockchainsList(blockchainsList);
}

@riverpod
Future<BridgeBlockchain?> _getArchethicBlockchainFromEVM(
  _GetArchethicBlockchainFromEVMRef ref,
  BridgeBlockchain? evmBlockchain,
) async {
  if (evmBlockchain == null) return null;
  final blockchainsList = await ref
      .watch(_bridgeBlockchainsRepositoryProvider)
      .getBlockchainsListConf();
  return ref
      .watch(_bridgeBlockchainsRepositoryProvider)
      .getArchethicBlockchainFromEVM(
        blockchainsList,
        evmBlockchain,
      );
}

class BridgeBlockchainsRepository {
  Future<List<BridgeBlockchain>> getBlockchainsListConf() async {
    final jsonContent = await rootBundle
        .loadString('lib/domain/repositories/blockchains_list.json');

    final jsonData = jsonDecode(jsonContent);

    final blockchainsList =
        List<Map<String, dynamic>>.from(jsonData['blockchains']);

    return blockchainsList.map(BridgeBlockchain.fromJson).toList();
  }

  List<BridgeBlockchain> getBlockchainsList(
    List<BridgeBlockchain> blockchainsList,
  ) {
    blockchainsList.sort((a, b) {
      final compareEnv = a.env.compareTo(b.env);
      if (compareEnv != 0) {
        return compareEnv;
      } else {
        return a.name.compareTo(b.name);
      }
    });
    return blockchainsList;
  }

  Future<BridgeBlockchain?> getArchethicBlockchainFromEVM(
    List<BridgeBlockchain> blockchainsList,
    BridgeBlockchain evmBlockchain,
  ) async {
    blockchainsList
      ..removeWhere(
        (element) => element.env != evmBlockchain.env,
      )
      ..removeWhere((element) => element.isArchethic == false);
    if (blockchainsList.length == 1) {
      return blockchainsList[0];
    }

    return null;
  }
}

abstract class BridgeBlockchainsProviders {
  static final getBlockchainsList = _getBlockchainsListProvider;
  static final getBlockchainsListConf = _getBlockchainsListConfProvider;
  static const getArchethicBlockchainFromEVM =
      _getArchethicBlockchainFromEVMProvider;
}
