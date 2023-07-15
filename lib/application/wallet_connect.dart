/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';

class WalletConnectProvider extends ChangeNotifier {
  bool walletConnected = false;

  late EthereumWalletConnectProvider provider;
  late WalletConnectSession? session;
  late WalletConnectSecureStorage sessionStorage;
  late WalletConnect connector;

  Future<void> connect(int chainId) async {
    walletConnected = false;
    sessionStorage = WalletConnectSecureStorage();
    session = await sessionStorage.getSession();
    connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      session: session,
      sessionStorage: sessionStorage,
      clientMeta: const PeerMeta(
        name: 'Archethic Bridge',
        description: 'Archethic Bridge WalletConnect',
        url: 'https://bridge.archethic.net',
        icons: [
          'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
        ],
      ),
    );
    provider = EthereumWalletConnectProvider(connector);
    connector
      ..on(
        'connect',
        (session) {
          walletConnected = true;
          debugPrint(session.toString());
        },
      )
      ..on('session_update', (session) => debugPrint(session.toString()))
      ..on('disconnect', (session) => debugPrint(session.toString()));

    notifyListeners();

    // Create a new session
    if (!connector.connected) {
      await connector.createSession(
        chainId: chainId,
        onDisplayUri: (uri) => debugPrint(uri),
      );
    }
  }

  Future<void> disconnect() async {
    walletConnected = false;

    notifyListeners();
  }
}
