/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';

import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/usecases/evm_mixin.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:webthree/webthree.dart';

class HTLCUtil with EVMBridgeProcessMixin {
  HTLCUtil(this.providerEndpoint);

  String? providerEndpoint;

  Future<Result<String, Failure>> refund(
    String htlcContractAddress, {
    int chainId = 1337,
  }) async {
    return Result.guard(
      () async {
        final evmWalletProvider = sl.get<EVMWalletProvider>();

        final web3Client = Web3Client(providerEndpoint!, Client());

        await refundedEvent(htlcContractAddress);

        final abiStringJson = jsonDecode(
          await rootBundle
              .loadString('contracts/evm/build/contracts/IHTLC.json'),
        );

        debugPrint('refund - htlcContractAddress: $htlcContractAddress');

        final contractHTLCERC = DeployedContract(
          ContractAbi.fromJson(
            jsonEncode(abiStringJson['abi']),
            abiStringJson['contractName'] as String,
          ),
          EthereumAddress.fromHex(htlcContractAddress),
        );

        final transactionRefund = Transaction.callContract(
          contract: contractHTLCERC,
          function: contractHTLCERC.function('refund'),
          parameters: [],
        );

        final refundTx = await sendTransactionWithErrorManagement(
          web3Client,
          evmWalletProvider.credentials!,
          transactionRefund,
          chainId,
        );
        debugPrint('refundTx: $refundTx');
        return refundTx;
      },
    );
  }

  Future<Result<(DateTime, bool), Failure>> getHTLCLockTime(
    String htlcContractAddress,
  ) async {
    return Result.guard(
      () async {
        final web3Client = Web3Client(providerEndpoint!, Client());

        final abiStringJson = jsonDecode(
          await rootBundle
              .loadString('contracts/evm/build/contracts/IHTLC.json'),
        );

        debugPrint(
          'getHTLCContract - htlcContractAddress: $htlcContractAddress',
        );

        final contractHTLC = DeployedContract(
          ContractAbi.fromJson(
            jsonEncode(abiStringJson['abi']),
            abiStringJson['contractName'] as String,
          ),
          EthereumAddress.fromHex(htlcContractAddress),
        );

        return (
          await getDateLockTime(web3Client, contractHTLC),
          await isCanRefund(web3Client, contractHTLC),
        );
      },
    );
  }

  Future<int> _getStartTime(
    Web3Client web3Client,
    DeployedContract contract,
  ) async {
    final startTimeMap = await web3Client.call(
      contract: contract,
      function: contract.function('startTime'),
      params: [],
    );

    final BigInt startTime = startTimeMap[0];
    debugPrint('HTLC startTime: $startTime');

    return startTime.toInt();
  }

  Future<int> _getLockTime(
    Web3Client web3Client,
    DeployedContract contract,
  ) async {
    final lockTimeMap = await web3Client.call(
      contract: contract,
      function: contract.function('lockTime'),
      params: [],
    );

    final BigInt lockTime = lockTimeMap[0];
    debugPrint('HTLC lockTime: $lockTime');

    return lockTime.toInt();
  }

  Future<Result<double, Failure>> getAmount(
    String htlcContractAddress,
  ) async {
    return Result.guard(
      () async {
        final web3Client = Web3Client(providerEndpoint!, Client());

        final abiStringJson = jsonDecode(
          await rootBundle
              .loadString('contracts/evm/build/contracts/IHTLC.json'),
        );

        debugPrint(
          'getAmount - htlcContractAddress: $htlcContractAddress',
        );

        final contractHTLC = DeployedContract(
          ContractAbi.fromJson(
            jsonEncode(abiStringJson['abi']),
            abiStringJson['contractName'] as String,
          ),
          EthereumAddress.fromHex(htlcContractAddress),
        );

        final amountMap = await web3Client.call(
          contract: contractHTLC,
          function: contractHTLC.function('amount'),
          params: [],
        );

        final BigInt amount = amountMap[0];
        debugPrint('HTLC amount: $amount');

        final etherAmount = EtherAmount.fromBigInt(EtherUnit.wei, amount);
        return etherAmount.getValueInUnit(EtherUnit.ether);
      },
    );
  }

  Future<DateTime> getDateLockTime(
    Web3Client web3Client,
    DeployedContract contract,
  ) async {
    final startTime = await _getStartTime(web3Client, contract);
    final lockTime = await _getLockTime(web3Client, contract);
    final timestampInSec = startTime + lockTime;
    final dateLockTime =
        DateTime.fromMillisecondsSinceEpoch(timestampInSec * 1000);
    debugPrint('HTLC DateLockTime: $dateLockTime');
    return dateLockTime;
  }

  Future<bool> isCanRefund(
    Web3Client web3Client,
    DeployedContract contract,
  ) async {
    final canRefundMap = await web3Client.call(
      contract: contract,
      function: contract.function('canRefund'),
      params: [],
    );

    final bool canRefund = canRefundMap[0];
    debugPrint('HTLC canRefund: $canRefund');

    return canRefund;
  }

  Future<void> refundedEvent(
    String htlcContractAddress,
  ) async {
    final web3Client = Web3Client(providerEndpoint!, Client());

    final abiStringJson = jsonDecode(
      await rootBundle
          .loadString('contracts/evm/build/contracts/HTLC_ERC.json'),
    );

    debugPrint(
      'refundedEvent - htlcContractAddress: $htlcContractAddress',
    );

    final contractHTLC = DeployedContract(
      ContractAbi.fromJson(
        jsonEncode(abiStringJson['abi']),
        abiStringJson['contractName'] as String,
      ),
      EthereumAddress.fromHex(htlcContractAddress),
    );

    final event = contractHTLC.event('Refunded');
    web3Client
        .events(
      FilterOptions.events(contract: contractHTLC, event: event),
    )
        .listen((event) {
      debugPrint('event: $event');
    });
  }

  Future<String> getTxRefund(
    String htlcContractAddress,
  ) async {
    final web3Client = Web3Client(providerEndpoint!, Client());

    final abiStringJson = jsonDecode(
      await rootBundle
          .loadString('contracts/evm/build/contracts/HTLC_ERC.json'),
    );

    debugPrint(
      'refundedEvent - htlcContractAddress: $htlcContractAddress',
    );

    final contractHTLC = DeployedContract(
      ContractAbi.fromJson(
        jsonEncode(abiStringJson['abi']),
        abiStringJson['contractName'] as String,
      ),
      EthereumAddress.fromHex(htlcContractAddress),
    );

    final events = await web3Client.getLogs(
      FilterOptions.events(
        contract: contractHTLC,
        event: contractHTLC.event('Refunded'),
      ),
    );

    debugPrint('events: $events');

    if (events.isEmpty || events[0].address == null) {
      return '';
    }

    return events[0].address!.hex;
  }
}
