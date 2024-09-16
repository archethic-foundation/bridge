import 'dart:convert';

import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:js/js.dart';
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;
import 'package:webthree/browser.dart';
import 'package:webthree/webthree.dart';

class EVMWalletProvider extends ChangeNotifier with EVMBridgeProcessMixin {
  String? currentAddress;
  String? get accountName => currentAddress;
  int? currentChain;
  bool walletConnected = false;
  Ethereum? eth;
  BinanceChainWallet? bsc;
  OkxWallet? okx;

  Future<int> getChainId() async => wagmi.Core.getChainId();

  // TODO: Utiliser une écoute plutot que du pooling
  Future<wagmi.Account> _waitForConnexion() async {
    while (true) {
      final account = wagmi.Core.getAccount();
      if (account.isConnected) return account;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> connect(BridgeBlockchain chain) async {
    walletConnected = false;

    wagmi.Web3Modal.init(
      projectId: 'f642e3f39ba3e375f8f714f18354faa4',
      chains: [chain.chainId],
      enableAnalytics: true,
      enableOnRamp: true,
      metadata: wagmi.Web3ModalMetadata(
        name: 'Archethic Bridge',
        description:
            'Enable interoperability and facilitate the transfer of data and assets between the two blockchains.',
        url: 'https://bridge.archethic.net',
        icons: ['https://bridge.archethic.net/favicon.png'],
      ),
      email: false,
      showWallets: true,
      walletFeatures: true,
      transportBuilder: (chainId) => wagmi.Transport.websocket(
        url:
            Uri.parse(chain.providerEndpoint).replace(scheme: 'wss').toString(),
      ),
    );

    wagmi.Web3Modal.open();

    final currentAccount = await _waitForConnexion();

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
    String providerEndpoint,
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
        // TODO(Chralu): what is the difference between erc20, wrapped and native ?
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
              contractNameIERC20,
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
          final tokenBalance = balanceResponse[0] as BigInt;
          final adjustedBalance = (Decimal.parse('$tokenBalance') /
                  Decimal.fromBigInt(BigInt.from(10).pow(decimal)))
              .toDouble();
          return adjustedBalance;

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
    String providerEndpoint,
    String typeToken, {
    String erc20address = '',
  }) async {
    const defaultDecimal = 8;

    try {
      switch (typeToken) {
        case 'Native':
          return 18;
        case 'ERC20':
        case 'Wrapped':
          if (erc20address.isEmpty) {
            return defaultDecimal;
          }

          final contractToken = await loadAbi(contractNameERC20);

          final params = wagmi.ReadContractParameters(
            abi: contractToken,
            address: erc20address,
            functionName: 'decimals',
            args: [],
          );
          final decimalsResponse = await wagmi.Core.readContract(params);

          return decimalsResponse.toInt();
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

@JS()
@anonymous
class JSrawRequestParams {
  external factory JSrawRequestParams({String chainId});
  external String get chainId;
}
