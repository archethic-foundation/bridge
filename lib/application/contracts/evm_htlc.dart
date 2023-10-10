/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/usecases/evm_mixin.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/webthree.dart';

class EVMHTLC with EVMBridgeProcessMixin {
  EVMHTLC(
    this.providerEndpoint,
    this.htlcContractAddress,
    this.chainId, {
    this.web3ClientProvided,
  }) {
    if (web3ClientProvided != null) {
      web3Client = web3ClientProvided;
    } else {
      web3Client = Web3Client(providerEndpoint!, Client());
    }
  }

  final String? providerEndpoint;
  final String htlcContractAddress;
  Web3Client? web3Client;
  Web3Client? web3ClientProvided;
  final int chainId;

  Future<Result<String, Failure>> refund() async {
    return Result.guard(
      () async {
        final evmWalletProvider = sl.get<EVMWalletProvider>();

        await refundedEvent();

        final contractHTLC =
            await getDeployedContract(contractNameIHTLC, htlcContractAddress);

        final transactionRefund = Transaction.callContract(
          contract: contractHTLC,
          function: contractHTLC.function('refund'),
          parameters: [],
        );

        final refundTx = await sendTransactionWithErrorManagement(
          web3Client!,
          evmWalletProvider.credentials!,
          transactionRefund,
          chainId,
        );
        debugPrint('refundTx: $refundTx');
        return refundTx;
      },
    );
  }

  Future<Result<({int dateLockTime, bool canRefund}), Failure>>
      getHTLCLockTimeAndRefundState() async {
    return Result.guard(
      () async {
        return (
          dateLockTime: await _getDateLockTime(),
          canRefund: await _isCanRefund(),
        );
      },
    );
  }

  Future<Result<int, Failure>> getHTLCLockTime() async {
    return Result.guard(
      () async {
        return _getDateLockTime();
      },
    );
  }

  Future<int> _getLockTime(
    DeployedContract contract,
  ) async {
    final lockTimeMap = await web3Client!.call(
      contract: contract,
      function: contract.function('lockTime'),
      params: [],
    );

    final BigInt lockTime = lockTimeMap[0];
    debugPrint('HTLC lockTime: $lockTime');
    debugPrint('Now : ${DateTime.now().millisecondsSinceEpoch ~/ 1000}');

    return lockTime.toInt();
  }

  Future<Result<double, Failure>> getAmount() async {
    return Result.guard(
      () async {
        final contractHTLC =
            await getDeployedContract(contractNameIHTLC, htlcContractAddress);

        final amountMap = await web3Client!.call(
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

  Future<int> _getDateLockTime() async {
    final contract =
        await getDeployedContract(contractNameIHTLC, htlcContractAddress);
    return _getLockTime(contract);
  }

  Future<bool> _isCanRefund() async {
    final contract =
        await getDeployedContract(contractNameIHTLC, htlcContractAddress);
    final canRefundMap = await web3Client!.call(
      contract: contract,
      function: contract.function('canRefund'),
      params: [
        BigInt.from(DateTime.now().millisecondsSinceEpoch ~/ 1000),
      ],
    );

    final bool canRefund = canRefundMap[0];
    debugPrint('HTLC canRefund: $canRefund');

    return canRefund;
  }

  Future<void> refundedEvent() async {
    final contractHTLC =
        await getDeployedContract(contractNameHTLCERC, htlcContractAddress);

    final event = contractHTLC.event('Refunded');
    web3Client!
        .events(
      FilterOptions.events(contract: contractHTLC, event: event),
    )
        .listen((event) {
      debugPrint('event: $event');
    });
  }

  Future<String> getTxRefund() async {
    final contractHTLC =
        await getDeployedContract(contractNameHTLCERC, htlcContractAddress);

    final events = await web3Client!.getLogs(
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

  Future<Result<String, Failure>> withdraw(
    String secret,
  ) async {
    return Result.guard(
      () async {
        final evmWalletProvider = sl.get<EVMWalletProvider>();

        final contractHTLC = await getDeployedContract(
          contractNameHTLCERC,
          htlcContractAddress,
        );

        final transactionWithdraw = Transaction.callContract(
          contract: contractHTLC,
          function: contractHTLC.findFunctionByNameAndNbOfParameters(
            'withdraw',
            1,
          ),
          parameters: [
            hexToBytes(secret),
          ],
        );

        final withdrawTx = await sendTransactionWithErrorManagement(
          web3Client!,
          evmWalletProvider.credentials!,
          transactionWithdraw,
          chainId,
        );
        debugPrint('withdrawTx: $withdrawTx');
        return withdrawTx;
      },
    );
  }
}
