/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';
import 'package:aebridge/application/metamask.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/webthree.dart';

class LPERCContract {
  LPERCContract(this.providerEndpoint);

  String? providerEndpoint;

  Future<String?> deployAndProvisionHTLC(
    String poolAddress,
    String hash,
    BigInt amount,
    String tokenAddress, {
    int lockTime = 720,
    int chainId = 1337,
  }) async {
    final metaMaskProvider = sl.get<MetaMaskProvider>();
    debugPrint('providerEndpoint: $providerEndpoint');
    final web3Client = Web3Client(providerEndpoint!, Client());
    late String htlcContractAddress;

    try {
      final abiLPERCStringJson = jsonDecode(
        await rootBundle.loadString('truffle/build/contracts/IPool.json'),
      );

      final contractLPERC = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(abiLPERCStringJson['abi']),
          abiLPERCStringJson['contractName'] as String,
        ),
        EthereumAddress.fromHex(poolAddress),
      );

      debugPrint('contractLPERC ok');

      final transactionMintHTLC = Transaction.callContract(
        contract: contractLPERC,
        function: contractLPERC.function('mintHTLC'),
        parameters: [
          hexToBytes(hash),
          EtherAmount.fromUnitAndValue(EtherUnit.ether, amount).getInWei,
          BigInt.from(lockTime),
        ],
      );

      debugPrint('contractLPERC mintHTLC ok');

      await web3Client.sendTransaction(
        metaMaskProvider.credentials!,
        transactionMintHTLC,
        chainId: chainId,
      );

      debugPrint('HTLC Contract deployed');

      // Get HTLC Contract address
      final transactionMintedSwapsHashes = await web3Client.call(
        contract: contractLPERC,
        function: contractLPERC.function('mintedSwaps'),
        params: [
          hexToBytes(hash),
        ],
      );

      htlcContractAddress = transactionMintedSwapsHashes[0].hex;
      debugPrint('HTLC Contract address: $htlcContractAddress');

      final abiDummyTokenStringJson = jsonDecode(
        await rootBundle.loadString('truffle/build/contracts/IERC20.json'),
      );

      final contractDummyToken = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(abiDummyTokenStringJson['abi']),
          abiDummyTokenStringJson['contractName'] as String,
        ),
        EthereumAddress.fromHex(tokenAddress),
      );

      final transactionTransfer = Transaction.callContract(
        contract: contractDummyToken,
        function: contractDummyToken.function('transfer'),
        parameters: [
          EthereumAddress.fromHex(htlcContractAddress),
          EtherAmount.fromUnitAndValue(EtherUnit.ether, amount).getInWei,
        ],
      );

      await web3Client.sendTransaction(
        metaMaskProvider.credentials!,
        transactionTransfer,
        chainId: chainId,
      );

      debugPrint('Token provisionned');
      return htlcContractAddress;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<void> withdraw(
    String htlcContractAddress,
    String secret, {
    int chainId = 1337,
  }) async {
    final metaMaskProvider = sl.get<MetaMaskProvider>();

    final web3Client = Web3Client(providerEndpoint!, Client());

    try {
      final abiStringJson = jsonDecode(
        await rootBundle.loadString('truffle/build/contracts/IHTLC.json'),
      );

      debugPrint('widthdraw - htlcContractAddress: $htlcContractAddress');
      debugPrint('widthdraw - secret: $secret');

      final contractHTLCERC = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(abiStringJson['abi']),
          abiStringJson['contractName'] as String,
        ),
        EthereumAddress.fromHex(htlcContractAddress),
      );

      final transactionMintHTLC = Transaction.callContract(
        contract: contractHTLCERC,
        function: contractHTLCERC.function('withdraw'),
        parameters: [
          hexToBytes(secret),
        ],
      );

      final withdrawTx = await web3Client.sendTransaction(
        metaMaskProvider.credentials!,
        transactionMintHTLC,
        chainId: chainId,
      );

      debugPrint('withdrawTx: $withdrawTx');
    } catch (e, trace) {
      debugPrint('Error: $e');
      debugPrint('Trace: $trace');
    }
  }
}
