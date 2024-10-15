import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/repositories/bridge_blockchain.repository.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

class EVMWalletProvider extends ChangeNotifier with EVMBridgeProcessMixin {
  bool isInit = false;

  final _logger = Logger('EVMWalletProvider');

  int? _requestedChainId;
  wagmi.Account? _requestedAccount;
  int get requestedChainId {
    if (_requestedChainId == null) {
      throw Exception(
        'You must call `EVMWalletProvider.connect` before any action',
      );
    }
    return _requestedChainId!;
  }

  wagmi.Account get requestedAccount {
    if (_requestedAccount == null) {
      throw Exception(
        'You must call `EVMWalletProvider.connect` before any action',
      );
    }
    return _requestedAccount!;
  }

  Future<void> init(BridgeBlockchainsRepository repository) async {
    if (isInit) return;

    final blockchains = await repository.getEVMBlockchains();
    wagmi.Web3Modal.init(
      projectId: _projectId,
      chains: blockchains.map((blockchain) => blockchain.chainId).toList(),
      metadata: wagmi.Web3ModalMetadata(
        name: 'Archethic Bridge',
        description:
            'Bridge in and out of the Archethic blockchain with aeBridge. Enable secure and efficient cross-chain interactions, leveraging UCO tokens to power your decentralized applications.',
        url: Uri.base.toString(),
        icons: Uri.base.toString().toLowerCase().contains('bridge.archethic')
            ? ['https://bridge.archethic.net/favicon.png']
            : ['https://bridge.testnet.archethic.net/favicon.png'],
      ),
      email: false,
      enableAnalytics: true,
      enableOnRamp: true,
      showWallets: true,
      walletFeatures: true,
      transportBuilder: (chainId) => wagmi.Transport.http(
        url: blockchains
            .firstWhere((element) => element.chainId == chainId)
            .providerEndpoint,
      ),
    );

    isInit = true;
  }

  String? get currentAddress {
    try {
      return wagmi.Core.getAccount().address;
    } catch (e) {
      return null;
    }
  }

  wagmi.Connector? get walletConnector {
    try {
      return wagmi.Core.getAccount().connector;
    } catch (e) {
      return null;
    }
  }

  bool get walletConnected => wagmi.Core.getAccount().isConnected;

  static const _projectId = 'ce9ee3c8e58873e8708247895990bc27';

  Future<int> getChainId() async => wagmi.Core.getChainId();

  // TODO(chralu): Utiliser une écoute plutot que du polling
  Future<wagmi.Account> _waitForConnection() async {
    while (true) {
      final account = wagmi.Core.getAccount();
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'account address: ${account.address}, isConnected: ${account.isConnected}, connector: ${account.connector}',
            level: aedappfm.LogLevel.debug,
            name: 'EVMWalletProvider - _waitForConnection',
          );
      if (account.isConnected && account.connector != null) {
        await useAccount(account);
        return account;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> connect(BridgeBlockchain chain) async {
    _logger.finest('Connecting to ${chain.name}');
    if (!walletConnected) {
      _logger.finest('Wallet not connected -> opening web3modal');
      wagmi.Web3Modal.open();

      await _waitForConnection();
    }
    await useChain(chain.chainId);

    notifyListeners();
  }

  Future<void> useChain(int chainId) async {
    _requestedChainId = chainId;
    if (wagmi.Core.getChainId() == chainId) return;
    await wagmi.Core.switchChain(
      wagmi.SwitchChainParameters(
        connector: walletConnector,
        chainId: chainId,
      ),
    );
  }

  Future<void> useAccount(wagmi.Account account) async {
    _requestedAccount = account;
    await wagmi.Core.switchAccount(
      wagmi.SwitchAccountParameters(
        connector: account.connector,
      ),
    );
    notifyListeners();
  }

  Future<void> useRequestedChain() async => useChain(requestedChainId);

  Future<void> useRequestedAccount() async => useAccount(requestedAccount);

  Future<void> disconnect() async {
    _logger.finest('Disconnecting wallet');

    await wagmi.Core.disconnect(wagmi.DisconnectParameters());
  }
}
