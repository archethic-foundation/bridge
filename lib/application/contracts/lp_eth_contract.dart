/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';
import 'package:aebridge/application/metamask.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/webthree.dart';

class LPETHContract {
  LPETHContract(this.providerEndpoint);

  String? providerEndpoint;

  Future<String?> deployAndProvisionHTLC(
    String poolAddress,
    String hash,
    BigInt amount, {
    int lockTime = 720,
    int chainId = 1337,
  }) async {
    final metaMaskProvider = sl.get<MetaMaskProvider>();
    debugPrint('providerEndpoint: $providerEndpoint');
    final web3Client = Web3Client(providerEndpoint!, Client());
    late String htlcContractAddress;

    try {
      final abiLPETHStringJson = jsonDecode(
        await rootBundle.loadString('truffle/build/contracts/IPool.json'),
      );

      final contractLPETH = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(abiLPETHStringJson['abi']),
          abiLPETHStringJson['contractName'] as String,
        ),
        EthereumAddress.fromHex(poolAddress),
      );

      final transactionMintHTLC = Transaction.callContract(
        contract: contractLPETH,
        function: contractLPETH.function('mintHTLC'),
        parameters: [
          hexToBytes(hash),
          EtherAmount.fromUnitAndValue(EtherUnit.ether, amount).getInWei,
          BigInt.from(lockTime),
        ],
      );

      await web3Client.sendTransaction(
        metaMaskProvider.credentials!,
        transactionMintHTLC,
        chainId: chainId,
      );

      debugPrint('HTLC Contract deployed');

      // Get HTLC Contract address
      final transactionMintedSwapsHashes = await web3Client.call(
        contract: contractLPETH,
        function: contractLPETH.function('mintedSwaps'),
        params: [
          hexToBytes(hash),
        ],
      );

      htlcContractAddress = transactionMintedSwapsHashes[0].hex;
      debugPrint('HTLC Contract address: $htlcContractAddress');

      // Provisionning HTLC Contract
      await web3Client.sendTransaction(
        metaMaskProvider.credentials!,
        Transaction(
          to: EthereumAddress.fromHex(htlcContractAddress),
          gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, 10),
          maxGas: 500000,
          value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amount),
        ),
        chainId: chainId,
      );
      debugPrint('HTLC contract provisionned');
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
      final abiHTLCETHStringJson = jsonDecode(
        await rootBundle.loadString('truffle/build/contracts/IHTLC.json'),
      );

      debugPrint('widthdraw - htlcContractAddress: $htlcContractAddress');
      debugPrint('widthdraw - secret: $secret');

      final contractHTLCETH = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(abiHTLCETHStringJson['abi']),
          abiHTLCETHStringJson['contractName'] as String,
        ),
        EthereumAddress.fromHex(htlcContractAddress),
      );

      final transactionMintHTLC = Transaction.callContract(
        contract: contractHTLCETH,
        function: contractHTLCETH.function('withdraw'),
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