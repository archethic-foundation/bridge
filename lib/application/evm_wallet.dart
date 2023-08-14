import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:js/js.dart';
import 'package:webthree/browser.dart';
import 'package:webthree/webthree.dart';

class EVMWalletProvider extends ChangeNotifier {
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
      try {
        eth = window.ethereum;

        if (eth == null) {
          debugPrint('EVM Wallet is not available');
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

        credentials = await eth!.requestAccount();
        currentAddress = credentials!.address.hex;
        walletConnected = true;
      } catch (e) {
        throw Exception('Please, connect your Wallet.');
      }

      notifyListeners();
    } else {
      throw Exception('No provider installed');
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

  Future<double> getBalance(
    String providerEndpoint,
    String typeToken, {
    String erc20address = '',
  }) async {
    try {
      if (web3Client == null || credentials == null) {
        return 0.0;
      }
      switch (typeToken) {
        case 'Native':
          final balance = await web3Client!.getBalance(credentials!.address);
          return balance.getValueInUnit(EtherUnit.ether);
        case 'ERC20':
          if (erc20address.isEmpty) {
            return 0.0;
          }
          final client = Web3Client(
            providerEndpoint,
            Client(),
          );

          debugPrint('erc20address $erc20address');

          final abiTokenStringJson = jsonDecode(
            await rootBundle.loadString('truffle/build/contracts/IERC20.json'),
          );

          final contractToken = DeployedContract(
            ContractAbi.fromJson(
              jsonEncode(abiTokenStringJson['abi']),
              abiTokenStringJson['contractName'] as String,
            ),
            EthereumAddress.fromHex(erc20address),
          );

          debugPrint('currentAddress $currentAddress');
          final balanceResponse = await client.call(
            contract: contractToken,
            function: contractToken.function('balanceOf'),
            params: [
              credentials!.address,
            ],
          );

          debugPrint(balanceResponse[0].toString());

          return (BigInt.parse(balanceResponse[0].toString()) ~/
                  BigInt.from(10).pow(18))
              .toDouble();
        default:
          return 0.0;
      }
    } catch (e) {
      debugPrint(e.toString());
      return 0.0;
    }
  }
}

@JS()
@anonymous
class JSrawRequestParams {
  external factory JSrawRequestParams({String chainId});
  external String get chainId;
}
