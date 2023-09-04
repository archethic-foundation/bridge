/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/usecases/evm_mixin.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/webthree.dart';

class LPETHContract with EVMBridgeProcessMixin {
  LPETHContract(this.providerEndpoint);

  String? providerEndpoint;

  Future<String?> deployAndProvisionHTLC(
    String poolAddress,
    String hash,
    BigInt amount, {
    int lockTime = 720,
    int chainId = 1337,
  }) async {
    final evmWalletProvider = sl.get<EVMWalletProvider>();
    debugPrint('providerEndpoint: $providerEndpoint');
    final web3Client = Web3Client(providerEndpoint!, Client());
    late String htlcContractAddress;

    final abiLPETHStringJson = jsonDecode(
      await rootBundle.loadString('contracts/evm/build/contracts/IPool.json'),
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

    await sendTransactionWithErrorManagement(
      web3Client,
      evmWalletProvider.credentials!,
      transactionMintHTLC,
      chainId,
    );

    // Get HTLC address
    final transactionMintedSwapsHashes = await web3Client.call(
      contract: contractLPETH,
      function: contractLPETH.function('mintedSwaps'),
      params: [
        hexToBytes(hash),
      ],
    );

    htlcContractAddress = transactionMintedSwapsHashes[0].hex;
    debugPrint('HTLC address: $htlcContractAddress');

    // Provisionning HTLC Contract
    await sendTransactionWithErrorManagement(
      web3Client,
      evmWalletProvider.credentials!,
      Transaction(
        to: EthereumAddress.fromHex(htlcContractAddress),
        gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, 10),
        maxGas: 500000,
        value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amount),
      ),
      chainId,
    );
    debugPrint('HTLC contract provisionned');
    return htlcContractAddress;
  }

  Future<void> withdraw(
    String htlcContractAddress,
    String secret, {
    int chainId = 1337,
  }) async {
    final evmWalletProvider = sl.get<EVMWalletProvider>();

    final web3Client = Web3Client(providerEndpoint!, Client());

    final abiHTLCETHStringJson = jsonDecode(
      await rootBundle.loadString('contracts/evm/build/contracts/IHTLC.json'),
    );

    debugPrint('withdraw - htlcContractAddress: $htlcContractAddress');
    debugPrint('withdraw - secret: $secret');

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
    final withdrawTx = await sendTransactionWithErrorManagement(
      web3Client,
      evmWalletProvider.credentials!,
      transactionMintHTLC,
      chainId,
    );
    debugPrint('withdrawTx: $withdrawTx');
  }
}
