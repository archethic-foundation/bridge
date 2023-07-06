/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ETHSwapHTLCModel extends ChangeNotifier {
  ETHSwapHTLCModel({
    required this.startTime,
    required this.lockTime,
    required this.secret,
    required this.hash,
    required this.recipient,
    required this.amount,
    required this.finished,
  }) {
    init();
  }

  final int? startTime;
  final int? lockTime;
  final String? secret;
  final String? hash;
  final String? recipient;
  final int? amount;
  final bool? finished;

  final String rpcUrl = 'http://127.0.0.1:7545';
  final String wsUrl = 'ws://127.0.0.1:7545/';

  final String privateKey =
      'f9af969c5294cb200d7f97d9b178937c96d36b0697639f71285224...';

  Web3Client? client;
  late String abiCode;

  late Credentials credentials;
  late EthereumAddress contractAddress;
  EthereumAddress? ownAddress;
  late DeployedContract contract;

  ContractFunction? withdraw;
  ContractFunction? canWithdraw;
  ContractFunction? canRefund;
  ContractFunction? refund;
  ContractFunction? enoughFunds;
  ContractFunction? beforeLockTime;
  ContractFunction? signatureHash;

  Future<void> init() async {
    client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    final abiStringFile =
        await rootBundle.loadString('truffle/build/contracts/ETHSwapHTLC.json');
    final jsonAbi = jsonDecode(abiStringFile);
    abiCode = jsonEncode(jsonAbi['abi']);
    contractAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
  }

  Future<void> getCredentials() async {
    credentials = EthPrivateKey.fromHex(privateKey);
    ownAddress = credentials.address;
  }

  Future<void> getDeployedContract() async {
    contract = DeployedContract(
      ContractAbi.fromJson(abiCode, 'ETHSwapHTLC'),
      contractAddress,
    );
    withdraw = contract.function('withdraw');
    canWithdraw = contract.function('canWithdraw');
    canRefund = contract.function('canRefund');
    refund = contract.function('refund');
    enoughFunds = contract.function('enoughFunds');
    beforeLockTime = contract.function('beforeLockTime');
    signatureHash = contract.function('signatureHash');
  }
}
