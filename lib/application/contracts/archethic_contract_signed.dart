/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:aebridge/util/transaction_bridge_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';

class ArchethicContractSigned with TransactionBridgeMixin {
  ArchethicContractSigned();

  Future<Result<String, Failure>> deploySignedHTLC(
    String htlcGenesisAddress,
    String seedSC,
    String factoryAddress,
    String poolAddress,
    String userAddress,
    double amount,
    String tokenAddress,
    int chainId,
  ) async {
    return Result.guard(
      () async {
        debugPrint(
          'deploySignedHTLC: [$userAddress, $poolAddress, $tokenAddress, $amount]',
        );
        final code = await sl.get<ApiService>().callSCFunction(
              jsonRPCRequest: SCCallFunctionRequest(
                method: 'contract_fun',
                params: SCCallFunctionParams(
                  contract: factoryAddress,
                  function: 'get_signed_htlc',
                  args: [
                    userAddress,
                    poolAddress,
                    if (tokenAddress.isEmpty) 'UCO' else tokenAddress,
                    amount,
                  ],
                ),
              ),
            );

        final resultDeploy = await ArchethicContract()
            .deployHTLC(null, code.toString(), htlcGenesisAddress, seedSC);

        resultDeploy.map(
          success: (success) {},
          failure: (failure) {
            throw failure;
          },
        );
        return htlcGenesisAddress;
      },
    );
  }

  Future<Result<void, Failure>> provisionSignedHTLC(
    double amount,
    String tokenAddress,
    String poolAddress,
    String htlcGenesisAddress,
    String userAddress,
    int chainId,
  ) async {
    return Result.guard(
      () async {
        Transaction? transactionTransfer;
        debugPrint(
          'provisionSignedHTLC: [$htlcGenesisAddress, $amount, $userAddress, $chainId]',
        );
        final recipient = Recipient(
          address: poolAddress.toUpperCase(),
          action: 'request_secret_hash',
          args: [htlcGenesisAddress, amount, userAddress, chainId],
        );
        if (tokenAddress.isEmpty) {
          transactionTransfer =
              Transaction(type: 'transfer', data: Transaction.initData())
                  .addUCOTransfer(htlcGenesisAddress, toBigInt(amount))
                  .addRecipient(
                    recipient.address!,
                    action: recipient.action,
                    args: recipient.args,
                  );
        } else {
          transactionTransfer =
              Transaction(type: 'transfer', data: Transaction.initData())
                  .addTokenTransfer(
                    htlcGenesisAddress,
                    toBigInt(amount),
                    tokenAddress,
                  )
                  .addRecipient(
                    recipient.address!,
                    action: recipient.action,
                    args: recipient.args,
                  );
        }

        final currentNameAccount = await getCurrentAccount();
        debugPrint(
          'provisionSignedHTLC - currentNameAccount: $currentNameAccount',
        );
        transactionTransfer = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionTransfer],
        ))
            .first;

        await sendTransactions(
          <Transaction>[transactionTransfer],
        );

        debugPrint(
          'provisionSignedHTLC - Tx address ${transactionTransfer.address!.address!}',
        );
        return;
      },
    );
  }

  Future<Result<String, Failure>> requestSecretFromSignedHTLC(
    String currentNameAccount,
    String htlcAddress,
    String poolAddress,
  ) async {
    return Result.guard(
      () async {
        debugPrint('requestSecretFromSignedHTLC - PoolAddress: $poolAddress');
        debugPrint('requestSecretFromSignedHTLC - HTLCAddress: $htlcAddress');
        var transaction =
            Transaction(type: 'transfer', data: Transaction.initData())
                .addRecipient(
          poolAddress,
          action: 'reveal_secret',
          args: [htlcAddress],
        );

        transaction = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transaction],
        ))
            .first;

        debugPrint(
          'requestSecretFromSignedHTLC - Tx address: ${transaction.address!.address!}',
        );
        await sendTransactions(
          <Transaction>[transaction],
        );

        return transaction.address!.address!;
      },
    );
  }
}