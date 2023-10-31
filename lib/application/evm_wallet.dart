import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:html';
import 'dart:math';

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

  Future<int> getChainId() async {
    if (window.ethereum != null) {
      try {
        eth = window.ethereum;

        if (eth == null) {
          throw Exception('EVM Wallet is not available');
        }

        final ethRPC = eth!.asRpcService();

        web3Client = Web3Client.custom(ethRPC);
        if (web3Client == null) {
          throw Exception('EVM Wallet is not available');
        }
        final currentChain = await web3Client!.getChainId();
        return currentChain.toInt();
      } catch (e) {
        throw Exception('Please, connect your Wallet.');
      }
    } else {
      throw Exception('No provider installed');
    }
  }

  Future<void> connect(int chainId) async {
    walletConnected = false;
    try {
      currentChain = await getChainId();
      if (currentChain != chainId) {
        final changeOk = await changeChainId(chainId);
        if (changeOk == false) {
          return;
        }
      }

      credentials = await eth!.requestAccount();
      currentAddress = credentials!.address.hex;
      walletConnected = true;
    } catch (e) {
      throw Exception(e);
    }

    notifyListeners();
  }

  Future<bool> changeChainId(int chainId) async {
    if (chainId != currentChain) {
      try {
        await eth!.rawRequest(
          'wallet_switchEthereumChain',
          params: [
            JSrawRequestParams(chainId: '0x${chainId.toRadixString(16)}'),
          ],
        );

        currentChain = chainId;
        notifyListeners();
        return true;
      } catch (e) {
        dev.log(e.toString());
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
    String address,
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
          final balance =
              await web3Client!.getBalance(EthereumAddress.fromHex(address));
          return balance.getValueInUnit(EtherUnit.ether);
        case 'ERC20':
        case 'Wrapped':
          if (erc20address.isEmpty) {
            return 0.0;
          }
          final client = Web3Client(
            providerEndpoint,
            Client(),
          );

          final abiTokenStringJson = jsonDecode(
            await rootBundle.loadString(
              'contracts/evm/artifacts/@openzeppelin/contracts/token/ERC20/IERC20.sol/IERC20.json',
            ),
          );

          final contractToken = DeployedContract(
            ContractAbi.fromJson(
              jsonEncode(abiTokenStringJson['abi']),
              abiTokenStringJson['contractName'] as String,
            ),
            EthereumAddress.fromHex(erc20address),
          );

          final balanceResponse = await client.call(
            contract: contractToken,
            function: contractToken.function('balanceOf'),
            params: [
              EthereumAddress.fromHex(address),
            ],
          );
          return EtherAmount.inWei(balanceResponse[0])
              .getValueInUnit(EtherUnit.ether);
        default:
          return 0.0;
      }
    } catch (e, stackTrace) {
      dev.log('$e', stackTrace: stackTrace);
      return 0.0;
    }
  }

  Future<int> getTokenDecimals(
    String providerEndpoint,
    String typeToken, {
    String erc20address = '',
  }) async {
    const defaultDecimal = 8;

    try {
      if (web3Client == null || credentials == null) {
        return 8;
      }
      switch (typeToken) {
        case 'Native':
          return defaultDecimal;
        case 'ERC20':
        case 'Wrapped':
          if (erc20address.isEmpty) {
            return defaultDecimal;
          }
          final client = Web3Client(
            providerEndpoint,
            Client(),
          );

          final abiTokenStringJson = jsonDecode(
            await rootBundle.loadString(
              'contracts/evm/artifacts/@openzeppelin/contracts/token/ERC20/IERC20.sol/IERC20.json',
            ),
          );

          final contractToken = DeployedContract(
            ContractAbi.fromJson(
              jsonEncode(abiTokenStringJson['abi']),
              abiTokenStringJson['contractName'] as String,
            ),
            EthereumAddress.fromHex(erc20address),
          );

          final decimalsResponse = await client.call(
            contract: contractToken,
            function: contractToken.function('decimals'),
            params: [],
          );

          return min(defaultDecimal, decimalsResponse[0].toInt());
        default:
          return defaultDecimal;
      }
    } catch (e, stackTrace) {
      dev.log('$e', stackTrace: stackTrace);
      return defaultDecimal;
    }
  }
}

@JS()
@anonymous
class JSrawRequestParams {
  external factory JSrawRequestParams({String chainId});
  external String get chainId;
}
