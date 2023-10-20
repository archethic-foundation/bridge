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

class ArchethicContractChargeable with TransactionBridgeMixin {
  ArchethicContractChargeable();

  Future<Result<String, Failure>> deployChargeableHTLC(
    WidgetRef ref,
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
        final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
        await bridgeNotifier.setWaitForWalletConfirmation(true);

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

        await bridgeNotifier.setWaitForWalletConfirmation(false);

        final recipient = Recipient(
          address: poolAddress.toUpperCase(),
          action: 'request_funds',
          args: [endTime, amount, userAddress, secretHash],
        );

        final resultDefineHTLCAddress = ArchethicContract().defineHTLCAddress();
        final htlcGenesisAddress = resultDefineHTLCAddress.genesisAddressHTLC;
        final _seedSC = resultDefineHTLCAddress.seedHTLC;
        const slippageFees = 1.5;
        final resultDeployHTLC = await ArchethicContract().deployHTLC(
          ref,
          recipient,
          code.toString(),
          htlcGenesisAddress,
          _seedSC,
          slippageFees,
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
    WidgetRef ref,
    String userGenesisAddress,
    String currentNameAccount,
    String htlcAddress,
    String secret,
    double amount,
    String poolAddress,
  ) async {
    return Result.guard(
      () async {
        final apiService = sl.get<ApiService>();

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
                throw const Failure.insufficientFunds();
              }
            }
          }
        }

        final blockchainTxVersion = int.parse(
          (await apiService.getBlockchainVersion()).version.transaction,
        );

        var transaction = Transaction(
          type: 'transfer',
          version: blockchainTxVersion,
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
