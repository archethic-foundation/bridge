/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:aebridge/util/transaction_bridge_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchethicContractSigned with TransactionBridgeMixin {
  ArchethicContractSigned();

  Future<Result<String, Failure>> deploySignedHTLC(
    WidgetRef ref,
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

        const slippageFees = 3.0;
        final resultDeploy = await ArchethicContract().deployHTLC(
          ref,
          null,
          code.toString(),
          htlcGenesisAddress,
          seedSC,
          slippageFees,
        );

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
    WidgetRef ref,
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
        final blockchainTxVersion = int.parse(
          (await sl.get<ApiService>().getBlockchainVersion())
              .version
              .transaction,
        );
        debugPrint(
          'provisionSignedHTLC: [$htlcGenesisAddress, $amount, $userAddress, $chainId]',
        );
        final recipient = Recipient(
          address: poolAddress.toUpperCase(),
          action: 'request_secret_hash',
          args: [htlcGenesisAddress, amount, userAddress, chainId],
        );
        if (tokenAddress.isEmpty) {
          transactionTransfer = Transaction(
            type: 'transfer',
            version: blockchainTxVersion,
            data: Transaction.initData(),
          ).addUCOTransfer(htlcGenesisAddress, toBigInt(amount)).addRecipient(
                recipient.address!,
                action: recipient.action,
                args: recipient.args,
              );
        } else {
          transactionTransfer = Transaction(
            type: 'transfer',
            version: blockchainTxVersion,
            data: Transaction.initData(),
          )
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

        final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
        await bridgeNotifier.setWaitForWalletConfirmation(true);

        await sendTransactions(
          <Transaction>[transactionTransfer],
        );

        debugPrint(
          'provisionSignedHTLC - Tx address ${transactionTransfer.address!.address!}',
        );

        await bridgeNotifier.setWaitForWalletConfirmation(false);

        return;
      },
    );
  }

  Future<Result<String, Failure>> requestSecretFromSignedHTLC(
    WidgetRef ref,
    String currentNameAccount,
    String htlcAddress,
    String poolAddress,
  ) async {
    return Result.guard(
      () async {
        debugPrint('requestSecretFromSignedHTLC - PoolAddress: $poolAddress');
        debugPrint('requestSecretFromSignedHTLC - HTLCAddress: $htlcAddress');
        final blockchainTxVersion = int.parse(
          (await sl.get<ApiService>().getBlockchainVersion())
              .version
              .transaction,
        );

        var transaction = Transaction(
          type: 'transfer',
          version: blockchainTxVersion,
          data: Transaction.initData(),
        ).addRecipient(
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

        final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
        await bridgeNotifier.setWaitForWalletConfirmation(true);

        await sendTransactions(
          <Transaction>[transaction],
        );

        await bridgeNotifier.setWaitForWalletConfirmation(false);

        return transaction.address!.address!;
      },
    );
  }
}
