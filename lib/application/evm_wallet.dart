import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:aebridge/util/custom_logs.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
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
  BinanceChainWallet? bsc;
  OkxWallet? okx;

  Web3Client? web3Client;
  CredentialsWithKnownAddress? credentials;

  Future<int> getChainId() async {
    if (window.OkxChainWallet != null) {
      try {
        okx = window.OkxChainWallet;
        final okxRPC = okx!.asRpcService();

        web3Client = Web3Client.custom(okxRPC);
        if (web3Client == null) {
          throw Exception('EVM Wallet is not available');
        }
        final currentChain = await web3Client!.getChainId();
        return currentChain.toInt();
      } catch (e) {
        throw Exception('Please, connect your Wallet.');
      }
    } else {
      if (window.BinanceChain != null) {
        try {
          bsc = window.BinanceChain;
          final bscRPC = bsc!.asRpcService();

          web3Client = Web3Client.custom(bscRPC);
          if (web3Client == null) {
            throw Exception('EVM Wallet is not available');
          }
          final currentChain = await web3Client!.getChainId();
          return currentChain.toInt();
        } catch (e) {
          throw Exception('Please, connect your Wallet.');
        }
      } else {
        if (window.ethereum != null) {
          try {
            eth = window.ethereum;
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
    }
  }

  Future<void> connect(int chainId) async {
    walletConnected = false;

    currentChain = await getChainId();
    if (currentChain != chainId) {
      await changeChainId(chainId);
    }

    var credentialsList = <CredentialsWithKnownAddress>[];
    if (okx != null) {
      credentialsList = await okx!.requestAccounts();
    } else {
      if (bsc != null) {
        credentialsList = await bsc!.requestAccounts();
      } else {
        if (eth != null) {
          credentialsList = await eth!.requestAccounts();
        }
      }
    }

    if (credentialsList.isNotEmpty) {
      credentials = credentialsList.first;
      currentAddress = credentials!.address.hex;
      walletConnected = true;

      notifyListeners();
    }
  }

  Future<void> changeChainId(int chainId) async {
    if (okx != null) {
      await okx!.rawRequest(
        'wallet_switchEthereumChain',
        params: [
          JSrawRequestParams(chainId: '0x${chainId.toRadixString(16)}'),
        ],
      );
    } else {
      if (bsc != null) {
        await bsc!.rawRequest(
          'wallet_switchEthereumChain',
          params: [
            JSrawRequestParams(chainId: '0x${chainId.toRadixString(16)}'),
          ],
        );
      } else {
        if (eth != null) {
          await eth!.rawRequest(
            'wallet_switchEthereumChain',
            params: [
              JSrawRequestParams(chainId: '0x${chainId.toRadixString(16)}'),
            ],
          );
        }
      }
    }

    currentChain = chainId;
    notifyListeners();
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
      sl.get<LogManager>().log(
            '$e',
            stackTrace: stackTrace,
            level: LogLevel.error,
            name: 'EVMWalletProvider - getBalance',
          );
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
              'contracts/evm/artifacts/@openzeppelin/contracts/token/ERC20/ERC20.sol/ERC20.json',
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
      sl.get<LogManager>().log(
            '$e',
            stackTrace: stackTrace,
            level: LogLevel.error,
            name: 'EVMWalletProvider - getTokenDecimals',
          );
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
