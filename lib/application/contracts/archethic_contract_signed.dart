/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchethicContractSigned with aedappfm.TransactionMixin {
  ArchethicContractSigned();

  Future<aedappfm.Result<String, aedappfm.Failure>> deploySignedHTLC(
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
    return aedappfm.Result.guard(
      () async {
        final code = await aedappfm.sl.get<ApiService>().callSCFunction(
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

  Future<aedappfm.Result<void, aedappfm.Failure>> provisionSignedHTLC(
    WidgetRef ref,
    double amount,
    String tokenAddress,
    String poolAddress,
    String htlcGenesisAddress,
    String userAddress,
    String evmUserAddress,
    int chainId,
  ) async {
    return aedappfm.Result.guard(
      () async {
        Transaction? transactionTransfer;
        final blockchainTxVersion = int.parse(
          (await aedappfm.sl.get<ApiService>().getBlockchainVersion())
              .version
              .transaction,
        );
        final recipient = Recipient(
          address: poolAddress.toUpperCase(),
          action: 'request_secret_hash',
          args: [
            htlcGenesisAddress,
            amount,
            userAddress,
            chainId,
            evmUserAddress,
          ],
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
        final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
        await bridgeNotifier
            .setWalletConfirmation(WalletConfirmation.archethic);

        transactionTransfer = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionTransfer],
        ))
            .first;
        await bridgeNotifier.setWalletConfirmation(null);

        final apiService = aedappfm.sl.get<ApiService>();
        await sendTransactions(
          <Transaction>[transactionTransfer],
          apiService,
        );
        return;
      },
    );
  }

  Future<aedappfm.Result<String, aedappfm.Failure>> requestSecretFromSignedHTLC(
    WidgetRef ref,
    String currentNameAccount,
    String htlcAddress,
    String poolAddress,
    String htlcEVMAddress,
    String txAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final blockchainTxVersion = int.parse(
          (await aedappfm.sl.get<ApiService>().getBlockchainVersion())
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
          args: [
            htlcAddress,
            txAddress,
            htlcEVMAddress,
          ],
        );

        final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
        await bridgeNotifier
            .setWalletConfirmation(WalletConfirmation.archethic);

        transaction = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transaction],
        ))
            .first;
        await bridgeNotifier.setWalletConfirmation(null);

        final apiService = aedappfm.sl.get<ApiService>();
        await sendTransactions(
          <Transaction>[transaction],
          apiService,
        );

        return transaction.address!.address!;
      },
    );
  }
}
