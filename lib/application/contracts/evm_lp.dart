/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/models/swap.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/webthree.dart';

class EVMLP with EVMBridgeProcessMixin {
  EVMLP(this.providerEndpoint);

  String? providerEndpoint;

  Future<Transaction> _getDeployChargeableHTLCTransaction(
    DeployedContract deployedContract,
    String poolAddress,
    String hash,
    double amount,
    int decimal,
    bool isWrapped,
    String addressFrom,
  ) async {
    final scaledAmount = (Decimal.parse('$amount') *
            Decimal.fromBigInt(BigInt.from(10).pow(decimal)))
        .toBigInt();

    final transactionMintHTLC = Transaction.callContract(
      contract: deployedContract,
      function: deployedContract.function('mintHTLC'),
      parameters: [
        hexToBytes(hash),
        scaledAmount,
      ],
      from: EthereumAddress.fromHex(addressFrom),
      value: isWrapped == false
          ? EtherAmount.fromBigInt(EtherUnit.wei, scaledAmount)
          : null,
      maxGas: 1500000,
    );
    return transactionMintHTLC;
  }

  Future<
      aedappfm.Result<({String htlcContractAddress, String txAddress}),
          aedappfm.Failure>> deployChargeableHTLC(
    WidgetRef ref,
    String poolAddress,
    String hash,
    double amount,
    int decimal,
    bool isWrapped, {
    int chainId = 31337,
  }) async {
    return aedappfm.Result.guard(() async {
      final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
      final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();

      bridgeNotifier.setRequestTooLong(false);

      final web3Client = Web3Client(
        providerEndpoint!,
        Client(),
        customFilterPingInterval: const Duration(
          seconds: 5,
        ),
      );
      late String htlcContractAddress;

      final contractLP =
          await getDeployedContract(contractNameIPool, poolAddress);

      final transaction = await _getDeployChargeableHTLCTransaction(
        contractLP,
        poolAddress,
        hash,
        amount,
        decimal,
        isWrapped,
        evmWalletProvider.currentAddress!,
      );

      late String txAddress;
      try {
        final completer = Completer<void>();

        final contractPoolBase =
            await getDeployedContract(contractNamePoolBase, poolAddress);

        final eventStream = web3Client
            .events(
              FilterOptions.events(
                contract: contractPoolBase,
                event: contractPoolBase.event('ContractMinted'),
                fromBlock: const BlockNum.current(),
              ),
            )
            .asBroadcastStream();

        await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
        txAddress = await sendTransactionWithErrorManagement(
          web3Client,
          evmWalletProvider.credentials!,
          transaction,
          chainId,
          'EVMLP - deployChargeableHTLC',
        );
        await bridgeNotifier.setWalletConfirmation(null);

        Timer(const Duration(seconds: 30), () {
          bridgeNotifier.setRequestTooLong(true);
        });

        unawaited(
          eventStream
              .firstWhere((event) => event.transactionHash == txAddress)
              .then(
            (event) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    'Event Withdrawn = $event',
                    name: 'EVMLP - deployChargeableHTLC',
                  );
              if (!completer.isCompleted) {
                completer.complete();
                bridgeNotifier.setRequestTooLong(false);
              }
            },
          ),
        );

        await completer.future.timeout(const Duration(seconds: 360));
      } catch (e, stackTrace) {
        if (e is TimeoutException) {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'Timeout occurred (poolAddress: $poolAddress, chainId: $chainId, address: ${evmWalletProvider.currentAddress})',
                level: aedappfm.LogLevel.error,
                name: 'EVMLP - deployChargeableHTLC',
              );
          throw const aedappfm.Failure.timeout();
        } else {
          if (e != const aedappfm.Failure.userRejected()) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  '$e',
                  stackTrace: stackTrace,
                  level: aedappfm.LogLevel.error,
                  name: 'EVMLP - deployChargeableHTLC',
                );
          }
        }
        rethrow;
      } finally {
        await web3Client.dispose();
      }

      // Get HTLC address
      final transactionMintedSwapsHashes = await web3Client.call(
        contract: contractLP,
        function: contractLP.function('mintedSwap'),
        params: [
          hexToBytes(hash),
        ],
      );

      htlcContractAddress = transactionMintedSwapsHashes[0].hex;
      return (htlcContractAddress: htlcContractAddress, txAddress: txAddress);
    });
  }

  Future<
      aedappfm.Result<({String htlcContractAddressEVM, String txAddress}),
          aedappfm.Failure>> deployAndProvisionSignedHTLC(
    WidgetRef ref,
    String poolAddress,
    String htlcContractAddressAE,
    SecretHash secretHash,
    double amount,
    int decimal,
    int endTime, {
    int chainId = 31337,
  }) async {
    return aedappfm.Result.guard(
      () async {
        final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
        final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();

        bridgeNotifier.setRequestTooLong(false);

        final web3Client = Web3Client(
          providerEndpoint!,
          Client(),
          customFilterPingInterval: const Duration(
            seconds: 5,
          ),
        );
        late String htlcContractAddressEVM;

        final contractLP =
            await getDeployedContract(contractNameIPool, poolAddress);

        final bigIntValue = Decimal.parse(amount.toString()) *
            Decimal.fromBigInt(BigInt.from(10).pow(decimal));
        final ethAmount =
            EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue.toBigInt());

        final transactionProvisionHTLC = Transaction.callContract(
          contract: contractLP,
          function: contractLP.function('provisionHTLC'),
          parameters: [
            hexToBytes(secretHash.secretHash!),
            ethAmount.getInWei,
            BigInt.from(endTime),
            hexToBytes(htlcContractAddressAE),
            hexToBytes(secretHash.secretHashSignature!.r!),
            hexToBytes(secretHash.secretHashSignature!.s!),
            BigInt.from(secretHash.secretHashSignature!.v!),
          ],
          maxGas: 1500000,
        );

        late String txAddress;
        try {
          final completer = Completer<void>();
          final contractPoolBase =
              await getDeployedContract(contractNamePoolBase, poolAddress);

          final eventStream = web3Client
              .events(
                FilterOptions.events(
                  contract: contractPoolBase,
                  event: contractPoolBase.event('ContractProvisioned'),
                  fromBlock: const BlockNum.current(),
                ),
              )
              .asBroadcastStream();

          await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
          txAddress = await sendTransactionWithErrorManagement(
            web3Client,
            evmWalletProvider.credentials!,
            transactionProvisionHTLC,
            chainId,
            'EVMLP - deployAndProvisionSignedHTLC',
          );
          await bridgeNotifier.setWalletConfirmation(null);

          Timer(const Duration(seconds: 30), () {
            bridgeNotifier.setRequestTooLong(true);
          });

          unawaited(
            eventStream
                .firstWhere((event) => event.transactionHash == txAddress)
                .then<void>(
              (event) {
                aedappfm.sl.get<aedappfm.LogManager>().log(
                      'Event ContractProvisioned = $event',
                      name: 'EVMLP - deployAndProvisionSignedHTLC',
                    );
                if (!completer.isCompleted) {
                  completer.complete();
                  bridgeNotifier.setRequestTooLong(false);
                }
              },
            ).catchError(completer.completeError),
          );

          await completer.future.timeout(const Duration(seconds: 360));
        } catch (e, stackTrace) {
          if (e is TimeoutException) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Timeout occurred (poolAddress: $poolAddress, chainId: $chainId, htlcContractAddressAE: $htlcContractAddressAE, address: ${evmWalletProvider.currentAddress}, amount: $amount, endTime: $endTime)',
                  level: aedappfm.LogLevel.error,
                  name: 'EVMLP - deployAndProvisionSignedHTLC',
                );
            throw const aedappfm.Failure.timeout();
          } else {
            if (e != const aedappfm.Failure.userRejected()) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    '$e',
                    stackTrace: stackTrace,
                    level: aedappfm.LogLevel.error,
                    name: 'EVMLP - deployAndProvisionSignedHTLC',
                  );
            }
          }

          rethrow;
        } finally {
          await web3Client.dispose();
        }

        // Get HTLC address
        final transactionProvisionedSwapsHashes = await web3Client.call(
          contract: contractLP,
          function: contractLP.function('provisionedSwap'),
          params: [
            hexToBytes(secretHash.secretHash!),
          ],
        );

        // TODO(reddwarf03): .. check
        htlcContractAddressEVM = transactionProvisionedSwapsHashes[0].hex;
        if (htlcContractAddressEVM ==
            '0x0000000000000000000000000000000000000000') {
          throw const aedappfm.Failure.insufficientPoolFunds();
        }

        return (
          htlcContractAddressEVM: htlcContractAddressEVM,
          txAddress: txAddress
        );
      },
    );
  }

  Future<aedappfm.Result<List<Swap>, aedappfm.Failure>> getSwapsByOwner(
    String poolAddress,
    String ownerAddress,
  ) async {
    return aedappfm.Result.guard(() async {
      final swapList = <Swap>[];
      final web3Client = Web3Client(
        providerEndpoint!,
        Client(),
        customFilterPingInterval: const Duration(seconds: 5),
      );

      final contractLP =
          await getDeployedContract(contractNameIPool, poolAddress);

      final resultMap = await web3Client.call(
        contract: contractLP,
        function: contractLP.function('getSwapsByOwner'),
        params: [
          EthereumAddress.fromHex(ownerAddress),
        ],
      );

      for (final swaps in resultMap[0] as List) {
        swapList.add(
          Swap(
            htlcContractAddressEVM: (swaps[0] as EthereumAddress).hex,
            htlcContractAddressAE: bytesToHex(swaps[1] as List<int>),
            swapProcess: (swaps[2] as BigInt).toInt() == 0
                ? SwapProcess.chargeable
                : (swaps[2] as BigInt).toInt() == 1
                    ? SwapProcess.signed
                    : null,
          ),
        );
      }
      return swapList;
    });
  }
}
