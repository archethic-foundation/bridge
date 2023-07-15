/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'package:webthree/browser.dart';
import 'package:webthree/webthree.dart';

class MetaMaskProvider extends ChangeNotifier {
  String? currentAddress;
  String? get accountName => currentAddress;
  int? currentChain;
  bool walletConnected = false;
  Ethereum? eth;
  Web3Client? web3Client;
  CredentialsWithKnownAddress? credentials;

  Future<void> connect(int chainId) async {
    walletConnected = false;
    if (window.ethereum != null) {
      eth = window.ethereum;

      if (eth == null) {
        debugPrint('MetaMask is not available');
        return;
      }

      final ethRPC = eth!.asRpcService();

      web3Client = Web3Client.custom(ethRPC);
      if (web3Client == null) {
        return;
      }
      final currentChain = await web3Client!.getChainId();
      debugPrint(
        'chainId: $chainId, currentChain: $currentChain',
      );
      if (currentChain.toInt() != chainId) {
        final changeOk = await changeChainId(chainId);
        if (changeOk == false) {
          return;
        }
      }

      try {
        credentials = await eth!.requestAccount();
        currentAddress = credentials!.address.hex.toUpperCase();
        walletConnected = true;
      } catch (e) {
        debugPrint(e.toString());
        return;
      }

      notifyListeners();
    }
  }

  Future<bool> changeChainId(int chainId) async {
    if (chainId != currentChain) {
      try {
        await eth!.rawRequest(
          'wallet_switchEthereumChain',
          params: [
            JSrawRequestParams(chainId: '0x${chainId.toRadixString(16)}')
          ],
        );

        currentChain = chainId;
        notifyListeners();
        return true;
      } catch (e) {
        debugPrint(e.toString());
        return false;
      }
    }

    return false;
  }

  Future<void> disconnect() async {
    walletConnected = false;
    currentAddress = null;
    notifyListeners();
  }
}

@JS()
@anonymous
class JSrawRequestParams {
  external factory JSrawRequestParams({String chainId});
  external String get chainId;
}
