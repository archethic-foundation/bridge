import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

class EVMWalletProvider extends ChangeNotifier with EVMBridgeProcessMixin {
  String? currentAddress;
  String? get accountName => currentAddress;
  bool walletConnected = false;
  wagmi.Config? wagmiConfig;

  final _projectId = 'f642e3f39ba3e375f8f714f18354faa4';

  Future<int> getChainId() async => wagmi.Core.getChainId(wagmiConfig!);

  // TODO(chralu): Utiliser une écoute plutot que du polling
  Future<wagmi.Account> _waitForConnection() async {
    while (true) {
      final account = wagmi.Core.getAccount(wagmiConfig!);
      if (account.isConnected) return account;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> connect(BridgeBlockchain chain) async {
    walletConnected = false;

    wagmiConfig = wagmi.Web3Modal.defaultWagmiConfig(
      projectId: _projectId,
      chains: [chain.chainId],
      metadata: wagmi.Web3ModalMetadata(
        name: 'Archethic Bridge',
        description:
            'Bridge in and out of the Archethic blockchain with aeBridge. Enable secure and efficient cross-chain interactions, leveraging UCO tokens to power your decentralized applications.',
        url: Uri.base.toString().toLowerCase().contains('bridge.archethic')
            ? 'https://bridge.archethic.net'
            : 'https://testnet.bridge.archethic.net',
        icons: Uri.base.toString().toLowerCase().contains('bridge.archethic')
            ? ['https://bridge.archethic.net/favicon.png']
            : ['https://testnet.bridge.archethic.net/favicon.png'],
      ),
      email: false,
      showWallets: true,
      walletFeatures: true,
      transportBuilder: (chainId) => wagmi.Transport.websocket(
        url:
            Uri.parse(chain.providerEndpoint).replace(scheme: 'wss').toString(),
      ),
    );

    wagmi.Web3Modal.createWeb3Modal(
      config: wagmiConfig!,
      projectId: _projectId,
    ).open();

    final currentAccount = await _waitForConnection();

    currentAddress = currentAccount.address;
    walletConnected = true;

    notifyListeners();
  }

  Future<void> disconnect() async {
    wagmi.Web3Modal.close();
    walletConnected = false;
    currentAddress = null;
    notifyListeners();
  }

  Future<double> getBalance(
    String address,
    String typeToken,
    int decimal, {
    String erc20address = '',
  }) async {
    try {
      switch (typeToken) {
        case 'Native':
          return double.tryParse(
                (await wagmi.Core.getBalance(
                  wagmiConfig!,
                  wagmi.GetBalanceParameters(address: address),
                ))
                    .formatted,
              ) ??
              0;
        case 'Wrapped':
          if (erc20address.isEmpty) {
            return 0.0;
          }
          return double.tryParse(
                (await wagmi.Core.getBalance(
                  wagmiConfig!,
                  wagmi.GetBalanceParameters(
                    address: address,
                    token: erc20address,
                  ),
                ))
                    .formatted,
              ) ??
              0;
        default:
          return 0.0;
      }
    } catch (e, stackTrace) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            '$e',
            stackTrace: stackTrace,
            level: aedappfm.LogLevel.error,
            name: 'EVMWalletProvider - getBalance',
          );
      return 0.0;
    }
  }

  Future<int> getTokenDecimals(
    String typeToken, {
    String erc20address = '',
  }) async {
    const defaultDecimal = 8;

    try {
      switch (typeToken) {
        case 'Native':
          return 18;
        case 'Wrapped':
          if (erc20address.isEmpty) {
            return defaultDecimal;
          }
          final token = await wagmi.Core.getToken(
            wagmiConfig!,
            wagmi.GetTokenParameters(address: erc20address),
          );
          return token.decimals;
        default:
          return defaultDecimal;
      }
    } catch (e, stackTrace) {
      aedappfm.sl.get<aedappfm.LogManager>().log(
            '$e',
            stackTrace: stackTrace,
            level: aedappfm.LogLevel.error,
            name: 'EVMWalletProvider - getTokenDecimals',
          );
      return defaultDecimal;
    }
  }
}
