/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/repositories/bridge_blockchain.repository.dart';
import 'package:aebridge/infrastructure/bridge_blockchain.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bridge_blockchain.g.dart';

@riverpod
Future<List<BridgeBlockchain>> _getBlockchainsListConf(
  _GetBlockchainsListConfRef ref,
) async {
  return ref
      .watch(_bridgeBlockchainsRepositoryProvider)
      .getBlockchainsListConf();
}

@riverpod
BridgeBlockchainsRepository _bridgeBlockchainsRepository(
  _BridgeBlockchainsRepositoryRef ref,
) =>
    BridgeBlockchainsRepositoryImpl();

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
Future<Map<int, BridgeBlockchain>> _getBlockchainsMap(
  _GetBlockchainsMapRef ref,
) async {
  final blockchainsListConf = await ref
      .watch(_bridgeBlockchainsRepositoryProvider)
      .getBlockchainsListConf();
  final blockchainsList = ref
      .watch(_bridgeBlockchainsRepositoryProvider)
      .getBlockchainsList(blockchainsListConf);

  Map<int, BridgeBlockchain> convertListToMap(List<BridgeBlockchain> list) {
    return {
      for (final bridgeBlockchain in list)
        bridgeBlockchain.chainId: bridgeBlockchain,
    };
  }

  return convertListToMap(blockchainsList);
}

@riverpod
Future<BridgeBlockchain?> _getBlockchainFromChainId(
  _GetBlockchainFromChainIdRef ref,
  int chainId,
) async {
  final blockchainsList = await ref
      .watch(_bridgeBlockchainsRepositoryProvider)
      .getBlockchainsListConf();

  return ref
      .watch(_bridgeBlockchainsRepositoryProvider)
      .getBlockchainFromChainId(blockchainsList, chainId);
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

abstract class BridgeBlockchainsProviders {
  static final getBlockchainsList = _getBlockchainsListProvider;
  static final getBlockchainsMap = _getBlockchainsMapProvider;
  static const getBlockchainFromChainId = _getBlockchainFromChainIdProvider;
  static final getBlockchainsListConf = _getBlockchainsListConfProvider;
  static const getArchethicBlockchainFromEVM =
      _getArchethicBlockchainFromEVMProvider;
}
