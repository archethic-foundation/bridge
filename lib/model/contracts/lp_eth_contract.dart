import 'dart:convert';
import 'package:aebridge/application/metamask.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/webthree.dart';

class LPETHContract {
  final String apiUrl = 'http://127.0.0.1:7545';

  Future<void> deployAndProvisionHTLC(
    String poolAddress,
    String hash,
    BigInt amount, {
    int lockTime = 720,
    int chainId = 1337,
  }) async {
    final metaMaskProvider = sl.get<MetaMaskProvider>();

    final web3Client = Web3Client(apiUrl, Client());

    final abiStringJson = jsonDecode(
      await rootBundle.loadString('truffle/build/contracts/LP_ETH.json'),
    );

    final contract = DeployedContract(
      ContractAbi.fromJson(
        jsonEncode(abiStringJson['abi']),
        abiStringJson['contractName'] as String,
      ),
      EthereumAddress.fromHex(poolAddress),
    );

    debugPrint('deployed contract ok');

    final transaction = Transaction.callContract(
      contract: contract,
      function: contract.function('mintHTLC'),
      parameters: [
        hexToBytes(hash),
        EtherAmount.inWei(amount).getInWei,
        lockTime,
      ],
    );

    debugPrint('transaction ok');

    final transactionHash = await web3Client.sendTransaction(
      metaMaskProvider.credentials!,
      transaction,
      chainId: chainId,
    );

    debugPrint('transaction sent ');
    final receipt = await web3Client.getTransactionReceipt(transactionHash);

    debugPrint('HTLC contract deployed at ${receipt!.contractAddress!.hex}');
  }
}
