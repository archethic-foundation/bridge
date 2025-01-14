/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_redundant_argument_values

import 'dart:async';

import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const blockchainTxVersion = 3;

class ArchethicContractSigned with aedappfm.TransactionMixin {
  ArchethicContractSigned();

  Future<aedappfm.Result<String, aedappfm.Failure>> deploySignedHTLC(
    awc.ArchethicDAppClient dappClient,
    WidgetRef ref,
    AppLocalizations localizations,
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
          dappClient,
          ref,
          localizations,
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
    awc.ArchethicDAppClient dappClient,
    WidgetRef ref,
    AppLocalizations localizations,
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

        final currentNameAccount = await getCurrentAccount(dappClient);
        final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);
        await bridgeNotifier
            .setWalletConfirmation(WalletConfirmation.archethic);

        transactionTransfer = (await signTx(
          dappClient,
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionTransfer],
          description: {
            'en': localizations.aeSignTxDesc2,
          },
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
    awc.ArchethicDAppClient dappClient,
    WidgetRef ref,
    AppLocalizations localizations,
    String currentNameAccount,
    String htlcAddress,
    String poolAddress,
    String htlcEVMAddress,
    String txAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
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

        final bridgeNotifier = ref.read(bridgeFormNotifierProvider.notifier);
        await bridgeNotifier
            .setWalletConfirmation(WalletConfirmation.archethic);

        transaction = (await signTx(
          dappClient,
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transaction],
          description: {
            'en': localizations.aeSignTxDesc3,
          },
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
