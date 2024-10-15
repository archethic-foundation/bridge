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
      // https://explorer.walletconnect.com/
      includeWalletIds: [
        'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96', // Metamask
        '4622a2b2d6af1c9844944291e5e7351a6aa24cd7b23099efac1b2fd875da31a0', // TrustWallet
        '971e689d0a5be527bac79629b4ee9b925e82208e5168b733496a09c0faed0709', // OKSWallet
        '8a0ee50d1f22f6651afcae7eb4253e52a3310b90af5daef78a8c4929a9bb99d4', // Binance WEB3 Wallet
        'c03dfee351b6fcc421b4494ea33b9d4b92a984f87aa76d1663bb28705e95034a', // Uniswap
        'a9751f17a3292f2d1493927f0555603d69e9a3fcbcdf5626f01b49afa21ced91', // Frame
        '0b415a746fb9ee99cce155c2ceca0c6f6061b1dbca2d722b3ba16381d0562150', // SafePAL
        '1ae92b26df02f0abca6304df07debccd18262fdf5fe82daa81593582dac9a369', // Rainbow
        'e9ff15be73584489ca4a66f64d32c4537711797e30b6660dbcb71ea72a42b1f4', // Exodus
        'fd20dc426fb37566d803205b19bbc1d4096b248ac04548e3cfb6b3a38bd033aa', // Coinbase
        'a797aa35c0fadbfc1a53e7f675162ed5226968b44a19ee3d24385c64d1d3c393', // Phantom
        '225affb176778569276e484e1b92637ad061b01e13a048b35a9d280c3b58970f', // Safe
      ],
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
      if (account.connector != null) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              'Chain Id: ${account.connector!.getChainId} - ${account.connector!.type} - ${account.connector!.name} - ${account.connector!.supportsSimulation}',
              level: aedappfm.LogLevel.debug,
              name: 'EVMWalletProvider - _waitForConnection',
            );
      }
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
    aedappfm.sl.get<aedappfm.LogManager>().log(
          'Before useChain : Chain Id: ${chain.chainId}',
          level: aedappfm.LogLevel.debug,
          name: 'EVMWalletProvider - _waitForConnection',
        );
    await useChain(chain.chainId);
    aedappfm.sl.get<aedappfm.LogManager>().log(
          'After useChain : Chain Id: ${chain.chainId}',
          level: aedappfm.LogLevel.debug,
          name: 'EVMWalletProvider - _waitForConnection',
        );
    notifyListeners();
  }

  Future<void> useChain(int chainId) async {
    _requestedChainId = chainId;
    if (wagmi.Core.getChainId() == chainId) return;
    aedappfm.sl.get<aedappfm.LogManager>().log(
          'Before switchChain : walletConnector: $walletConnector - ${walletConnector?.name}',
          level: aedappfm.LogLevel.debug,
          name: 'EVMWalletProvider - _waitForConnection',
        );
    await wagmi.Core.switchChain(
      wagmi.SwitchChainParameters(
        connector: walletConnector,
        chainId: chainId,
      ),
    );
  }

  Future<void> useAccount(wagmi.Account account) async {
    _requestedAccount = account;
    if (account.connector != null) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'Start useAccount : Chain Id: ${account.connector!.getChainId} - ${account.connector!.type} - ${account.connector!.name} - ${account.connector!.supportsSimulation}',
            level: aedappfm.LogLevel.debug,
            name: 'EVMWalletProvider - _waitForConnection',
          );
    }
    await wagmi.Core.switchAccount(
      wagmi.SwitchAccountParameters(
        connector: account.connector,
      ),
    );
    aedappfm.sl.get<aedappfm.LogManager>().log(
          'End useAccount : Chain Id: ${account.connector!.getChainId} - ${account.connector!.type} - ${account.connector!.name} - ${account.connector!.supportsSimulation}',
          level: aedappfm.LogLevel.debug,
          name: 'EVMWalletProvider - _waitForConnection',
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
