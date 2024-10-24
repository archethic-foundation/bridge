/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/repositories/bridge_blockchain.repository.dart';
import 'package:aebridge/infrastructure/bridge_blockchain.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bridge_blockchain.g.dart';

@Riverpod(keepAlive: true)
BridgeBlockchainsRepository bridgeBlockchainsRepository(
  Ref ref,
) =>
    BridgeBlockchainsRepositoryImpl();

@riverpod
Future<List<BridgeBlockchain>> getBlockchainsList(
  Ref ref,
) async {
  final blockchainsList = await ref
      .watch(bridgeBlockchainsRepositoryProvider)
      .getBlockchainsListConf();
  return ref
      .watch(bridgeBlockchainsRepositoryProvider)
      .getBlockchainsList(blockchainsList);
}

@riverpod
Future<BridgeBlockchain?> getBlockchainFromChainId(
  Ref ref,
  int chainId,
) async {
  final blockchainsList = await ref
      .watch(bridgeBlockchainsRepositoryProvider)
      .getBlockchainsListConf();

  return ref
      .watch(bridgeBlockchainsRepositoryProvider)
      .getBlockchainFromChainId(blockchainsList, chainId);
}

@riverpod
Future<BridgeBlockchain?> getArchethicBlockchainFromEVM(
  Ref ref,
  BridgeBlockchain? evmBlockchain,
) async {
  if (evmBlockchain == null) return null;
  final blockchainsList = await ref
      .watch(bridgeBlockchainsRepositoryProvider)
      .getBlockchainsListConf();
  return ref
      .watch(bridgeBlockchainsRepositoryProvider)
      .getArchethicBlockchainFromEVM(
        blockchainsList,
        evmBlockchain,
      );
}
