import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

class EVMWalletProvider extends ChangeNotifier with EVMBridgeProcessMixin {
  Future<void> init(Ref ref) async {
    final repository = ref.watch(bridgeBlockchainsRepositoryProvider);
    final blockchains = await repository.getEVMBlockchains();
    wagmi.Web3Modal.init(
      projectId: _projectId,
      chains: blockchains.map((blockchain) => blockchain.chainId).toList(),
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
      enableAnalytics: true,
      enableOnRamp: true,
      showWallets: true,
      walletFeatures: true,
      transportBuilder: (chainId) {
        final chain =
            blockchains.firstWhereOrNull((chain) => chain.chainId == chainId);
        if (chain == null) {
          throw Exception('Chain $chainId not found in predefined setups.');
        }
        return wagmi.Transport.websocket(
          url: Uri.parse(chain.providerEndpoint)
              .replace(scheme: 'wss')
              .toString(),
        );
      },
    );
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

  bool get walletConnected => walletConnector != null;

  static const _projectId = 'f642e3f39ba3e375f8f714f18354faa4';

  Future<int> getChainId() async => wagmi.Core.getChainId();

  // TODO(chralu): Utiliser une écoute plutot que du polling
  Future<wagmi.Account> _waitForConnection() async {
    while (true) {
      final account = wagmi.Core.getAccount();
      if (account.isConnected) return account;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> connect(BridgeBlockchain chain) async {
    if (walletConnector == null) {
      wagmi.Web3Modal.open();

      await _waitForConnection();
    }
    if (wagmi.Core.getChainId() == chain.chainId) return;
    await wagmi.Core.switchChain(
      wagmi.SwitchChainParameters(
        connector: walletConnector,
        chainId: chain.chainId,
      ),
    );

    notifyListeners();
  }

  Future<void> disconnect() async {}

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
