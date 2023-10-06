/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:aebridge/util/transaction_bridge_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';

class ArchethicContractChargeable with TransactionBridgeMixin {
  ArchethicContractChargeable();

  Future<Result<String, Failure>> deployChargeableHTLC(
    String factoryAddress,
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
    String secretHash,
    int chainId,
  ) async {
    return Result.guard(
      () async {
        final code = await sl.get<ApiService>().callSCFunction(
              jsonRPCRequest: SCCallFunctionRequest(
                method: 'contract_fun',
                params: SCCallFunctionParams(
                  contract: factoryAddress.toUpperCase(),
                  function: 'get_chargeable_htlc',
                  args: [
                    endTime,
                    userAddress.toUpperCase(),
                    poolAddress.toUpperCase(),
                    secretHash,
                    if (tokenAddress.isEmpty)
                      'UCO'
                    else
                      tokenAddress.toUpperCase(),
                    amount,
                  ],
                ),
              ),
            );

        final recipient = Recipient(
          address: poolAddress.toUpperCase(),
          action: 'request_funds',
          args: [endTime, amount, userAddress, secretHash],
        );

        final resultDefineHTLCAddress = ArchethicContract().defineHTLCAddress();
        final htlcGenesisAddress = resultDefineHTLCAddress.genesisAddressHTLC;
        final _seedSC = resultDefineHTLCAddress.seedHTLC;

        final resultDeployHTLC = await ArchethicContract().deployHTLC(
          recipient,
          code.toString(),
          htlcGenesisAddress,
          _seedSC,
        );
        resultDeployHTLC.map(
          success: (success) {},
          failure: (failure) {
            debugPrint('deployChargeableHTLC - $failure');
            throw failure;
          },
        );

        return htlcGenesisAddress;
      },
    );
  }

  Future<Result<String, Failure>> revealSecretToChargeableHTLC(
    String userGenesisAddress,
    String currentNameAccount,
    String htlcAddress,
    String secret,
  ) async {
    return Result.guard(
      () async {
        final apiService = sl.get<ApiService>();

        // ignore: unused_local_variable
        var htlcAddressBefore = htlcAddress;
        final transactionMap = await apiService
            .getLastTransaction([htlcAddress], request: 'address');
        if (transactionMap[htlcAddress] != null &&
            transactionMap[htlcAddress]!.address != null &&
            transactionMap[htlcAddress]!.address!.address != null) {
          htlcAddressBefore = transactionMap[htlcAddress]!.address!.address!;
        }

        var transaction = Transaction(
          type: 'transfer',
          data: Transaction.initData(),
        ).addRecipient(htlcAddress, action: 'reveal_secret', args: [secret]);

        transaction = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transaction],
        ))
            .first;

        debugPrint(
          'revealSecretToChargeableHTLC - Tx address: ${transaction.address!.address!}',
        );

        await sendTransactions(
          <Transaction>[transaction],
        );

        return transaction.address!.address!;
      },
    );
  }
}
