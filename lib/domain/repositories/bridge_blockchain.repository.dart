import 'package:aebridge/domain/models/bridge_blockchain.dart';

abstract class BridgeBlockchainsRepository {
  Future<List<BridgeBlockchain>> getBlockchainsListConf();

  List<BridgeBlockchain> getBlockchainsList(
    List<BridgeBlockchain> blockchainsList,
  );

  Future<BridgeBlockchain?> getBlockchainFromChainId(
    List<BridgeBlockchain> blockchainsList,
    int chainId,
  );

  Future<BridgeBlockchain?> getArchethicBlockchainFromEVM(
    List<BridgeBlockchain> blockchainsList,
    BridgeBlockchain evmBlockchain,
  );
}
