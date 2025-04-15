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

class ArchethicContractChargeable with aedappfm.TransactionMixin {
  ArchethicContractChargeable();

  Future<aedappfm.Result<void, aedappfm.Failure>> deployChargeableHTLC(
    awc.ArchethicDAppClient dappClient,
    WidgetRef ref,
    AppLocalizations localizations,
    String factoryAddress,
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
    String secretHash,
    int chainId,
    String htlcEVMAddress,
    String txAddress,
    String htlcGenesisAddress,
    String seedSC,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final code = await aedappfm.sl.get<ApiService>().callSCFunction(
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
          args: [
            endTime,
            amount,
            userAddress,
            secretHash,
            txAddress,
            htlcEVMAddress,
            chainId,
          ],
        );

        const slippageFees = 1.5;
        final resultDeployHTLC = await ArchethicContract().deployHTLC(
          dappClient,
          ref,
          localizations,
          recipient,
          code.toString(),
          htlcGenesisAddress,
          seedSC,
          slippageFees,
        );
        resultDeployHTLC.map(
          success: (success) {},
          failure: (failure) {
            throw failure;
          },
        );
      },
    );
  }

  Future<aedappfm.Result<String, aedappfm.Failure>>
      revealSecretToChargeableHTLC(
    awc.ArchethicDAppClient dappClient,
    WidgetRef ref,
    AppLocalizations localizations,
    String userGenesisAddress,
    String currentNameAccount,
    String htlcAddress,
    String secret,
    double amount,
    String poolAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final apiService = aedappfm.sl.get<ApiService>();

        // ignore: unused_local_variable
        var htlcAddressBefore = htlcAddress;
        final transactionMap = await apiService.getLastTransaction(
          [htlcAddress],
        );
        if (transactionMap[htlcAddress] != null &&
            transactionMap[htlcAddress]!.address != null &&
            transactionMap[htlcAddress]!.address!.address != null) {
          htlcAddressBefore = transactionMap[htlcAddress]!.address!.address!;
        }

        if (transactionMap[htlcAddress] != null) {
          // Check HTLC AE has funds
          final htlc = transactionMap[htlcAddress];
          for (final input in htlc!.inputs) {
            final genesisAddressFrom =
                await apiService.getGenesisAddress(input.from!);
            if (genesisAddressFrom.address != null &&
                genesisAddressFrom.address == poolAddress.toUpperCase()) {
              if (fromBigInt(input.amount) != amount) {
                throw const aedappfm.Failure.insufficientFunds();
              }
            }
          }
        }
        var transaction = Transaction(
          type: 'transfer',
          // Interpreted SC // No WASM
          version: 3,
          data: Transaction.initData(),
        ).addRecipient(
          htlcAddress,
          action: 'reveal_secret',
          args: [
            secret,
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
            'en': localizations.aeSignTxDesc1,
          },
        ))
            .first;
        await bridgeNotifier.setWalletConfirmation(null);
        await sendTransactions(
          <Transaction>[transaction],
          apiService,
        );

        return transaction.address!.address!;
      },
    );
  }
}
