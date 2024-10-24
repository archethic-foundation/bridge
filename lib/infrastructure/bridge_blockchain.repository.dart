import 'dart:convert';

import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/repositories/bridge_blockchain.repository.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';

class BridgeBlockchainsRepositoryImpl implements BridgeBlockchainsRepository {
  @override
  Future<List<BridgeBlockchain>> getBlockchainsListConf() async {
    final jsonContent = await rootBundle
        .loadString('lib/domain/repositories/blockchains_list.json');

    final jsonData = jsonDecode(jsonContent);

    final blockchainsList =
        List<Map<String, dynamic>>.from(jsonData['blockchains']);

    return blockchainsList.map(BridgeBlockchain.fromJson).toList();
  }

  @override
  Future<List<BridgeBlockchain>> getEVMBlockchains() async {
    final blockchains = await getBlockchainsListConf();
    return blockchains.where((blockchain) => !blockchain.isArchethic).toList();
  }

  @override
  List<BridgeBlockchain> getBlockchainsList(
    List<BridgeBlockchain> blockchainsList,
  ) {
    final sortedList = [...blockchainsList]..sort((a, b) {
        final compareEnv = a.env.index.compareTo(b.env.index);
        if (compareEnv != 0) {
          return compareEnv;
        } else {
          return a.name.compareTo(b.name);
        }
      });
    return sortedList;
  }

  @override
  Future<BridgeBlockchain?> getBlockchainFromChainId(
    List<BridgeBlockchain> blockchainsList,
    int chainId,
  ) async =>
      blockchainsList.firstWhereOrNull(
        (element) => element.chainId == chainId,
      );

  @override
  Future<BridgeBlockchain?> getArchethicBlockchainFromEVM(
    List<BridgeBlockchain> blockchainsList,
    BridgeBlockchain evmBlockchain,
  ) async =>
      blockchainsList.firstWhereOrNull(
        (element) => element.env == evmBlockchain.env && element.isArchethic,
      );
}
