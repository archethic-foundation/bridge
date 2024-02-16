/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:math';

import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
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
    bool isERC20,
    String addressFrom,
  ) async {
    final ethAmount = EtherAmount.fromDouble(EtherUnit.ether, amount);
    final transactionMintHTLC = Transaction.callContract(
      contract: deployedContract,
      function: deployedContract.function('mintHTLC'),
      parameters: [
        hexToBytes(hash),
        ethAmount.getInWei,
      ],
      from: EthereumAddress.fromHex(addressFrom),
      value: isERC20 == false ? ethAmount : null,
    );
    return transactionMintHTLC;
  }

  Future<aedappfm.Result<double, aedappfm.Failure>>
      estimateDeployChargeableHTLC(
    String poolAddress,
    String hash,
    double amount,
    bool isERC20,
    String addressFrom,
  ) async {
    return aedappfm.Result.guard(() async {
      final web3Client = Web3Client(providerEndpoint!, Client());
      final contract =
          await getDeployedContract(contractNameIPool, poolAddress);

      final transaction = await _getDeployChargeableHTLCTransaction(
        contract,
        poolAddress,
        hash,
        amount,
        isERC20,
        addressFrom,
      );

      final fees = await estimateGas(web3Client, transaction);

      return EtherAmount.fromBigInt(EtherUnit.ether, fees)
          .getValueInUnit(EtherUnit.ether);
    });
  }

  Future<
      aedappfm.Result<({String htlcContractAddress, String txAddress}),
          aedappfm.Failure>> deployChargeableHTLC(
    WidgetRef ref,
    String poolAddress,
    String hash,
    double amount,
    bool isERC20, {
    int chainId = 31337,
  }) async {
    return aedappfm.Result.guard(() async {
      final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
      final web3Client = Web3Client(providerEndpoint!, Client());
      late String htlcContractAddress;

      final contractLP =
          await getDeployedContract(contractNameIPool, poolAddress);

      final transaction = await _getDeployChargeableHTLCTransaction(
        contractLP,
        poolAddress,
        hash,
        amount,
        isERC20,
        evmWalletProvider.currentAddress!,
      );

      late String txAddress;
      var timeout = false;
      late StreamSubscription<FilterEvent> subscription;
      try {
        final contractPoolBase =
            await getDeployedContract(contractNamePoolBase, poolAddress);
        subscription = web3Client
            .events(
              FilterOptions.events(
                contract: contractPoolBase,
                event: contractPoolBase.event('ContractMinted'),
              ),
            )
            .take(1)
            .listen(
          (event) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  'Event ContractMinted = $event',
                  level: aedappfm.LogLevel.debug,
                  name: 'EVMLP - deployChargeableHTLC',
                );
          },
        );
        final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
        await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
        txAddress = await sendTransactionWithErrorManagement(
          web3Client,
          evmWalletProvider.credentials!,
          transaction,
          chainId,
        );
        await bridgeNotifier.setWalletConfirmation(null);

        await subscription.asFuture().timeout(
          const Duration(seconds: 240),
          onTimeout: () {
            return timeout = true;
          },
        );
        await subscription.cancel();
      } catch (e, stackTrace) {
        if (e != const aedappfm.Failure.userRejected()) {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                '$e',
                stackTrace: stackTrace,
                level: aedappfm.LogLevel.error,
                name: 'EVMLP - deployChargeableHTLC',
              );
        }

        await subscription.cancel();
        rethrow;
      }
      if (timeout) {
        throw const aedappfm.Failure.timeout();
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
      aedappfm.Result<({String htlcContractAddress, String txAddress}),
          aedappfm.Failure>> deployAndProvisionSignedHTLC(
    WidgetRef ref,
    String poolAddress,
    SecretHash secretHash,
    double amount,
    int endTime, {
    int chainId = 31337,
  }) async {
    return aedappfm.Result.guard(
      () async {
        final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
        final web3Client = Web3Client(providerEndpoint!, Client());
        late String htlcContractAddress;

        final contractLP =
            await getDeployedContract(contractNameIPool, poolAddress);

        final bigIntValue = Decimal.parse((amount * pow(10, 18)).toString());
        final ethAmount =
            EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue.toBigInt());
        final transactionProvisionHTLC = Transaction.callContract(
          contract: contractLP,
          function: contractLP.function('provisionHTLC'),
          parameters: [
            hexToBytes(secretHash.secretHash!),
            ethAmount.getInWei,
            BigInt.from(endTime),
            hexToBytes(secretHash.secretHashSignature!.r!),
            hexToBytes(secretHash.secretHashSignature!.s!),
            BigInt.from(secretHash.secretHashSignature!.v!),
          ],
          maxGas: 1500000,
        );

        late String txAddress;
        var timeout = false;
        late StreamSubscription<FilterEvent> subscription;
        try {
          final contractPoolBase =
              await getDeployedContract(contractNamePoolBase, poolAddress);
          subscription = web3Client
              .events(
                FilterOptions.events(
                  contract: contractPoolBase,
                  event: contractPoolBase.event('ContractProvisioned'),
                ),
              )
              .take(1)
              .listen(
            (event) {
              aedappfm.sl.get<aedappfm.LogManager>().log(
                    'Event ContractProvisioned = $event',
                    level: aedappfm.LogLevel.debug,
                    name: 'EVMLP - deployAndProvisionSignedHTLC',
                  );
            },
          );
          final bridgeNotifier =
              ref.read(BridgeFormProvider.bridgeForm.notifier);
          await bridgeNotifier.setWalletConfirmation(WalletConfirmation.evm);
          txAddress = await sendTransactionWithErrorManagement(
            web3Client,
            evmWalletProvider.credentials!,
            transactionProvisionHTLC,
            chainId,
          );
          await bridgeNotifier.setWalletConfirmation(null);

          await subscription.asFuture().timeout(
            const Duration(seconds: 240),
            onTimeout: () {
              return timeout = true;
            },
          );
          await subscription.cancel();
        } catch (e, stackTrace) {
          if (e != const aedappfm.Failure.userRejected()) {
            aedappfm.sl.get<aedappfm.LogManager>().log(
                  '$e',
                  stackTrace: stackTrace,
                  level: aedappfm.LogLevel.error,
                  name: 'EVMLP - deployAndProvisionSignedHTLC',
                );
          }

          await subscription.cancel();
          rethrow;
        }
        if (timeout) {
          throw const aedappfm.Failure.timeout();
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
        htlcContractAddress = transactionProvisionedSwapsHashes[0].hex;
        if (htlcContractAddress ==
            '0x0000000000000000000000000000000000000000') {
          throw const aedappfm.Failure.insufficientPoolFunds();
        }

        return (htlcContractAddress: htlcContractAddress, txAddress: txAddress);
      },
    );
  }

  Future<aedappfm.Result<double, aedappfm.Failure>> getSafetyModuleFeeRate(
    String poolAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final web3Client = Web3Client(providerEndpoint!, Client());

        final contractLP =
            await getDeployedContract(contractNameIPool, poolAddress);

        final safetyModuleFeeRateMap = await web3Client.call(
          contract: contractLP,
          function: contractLP.function('safetyModuleFeeRate'),
          params: [],
        );

        final BigInt safetyModuleFeeRate = safetyModuleFeeRateMap[0];
        return safetyModuleFeeRate.toDouble() / 100000 * 100;
      },
    );
  }

  Future<aedappfm.Result<String, aedappfm.Failure>> getSafetyModuleAddress(
    String poolAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final web3Client = Web3Client(providerEndpoint!, Client());

        final contractLP =
            await getDeployedContract(contractNameIPool, poolAddress);

        final safetyModuleAddressMap = await web3Client.call(
          contract: contractLP,
          function: contractLP.function('safetyModuleAddress'),
          params: [],
        );

        final EthereumAddress safetyModuleAddress = safetyModuleAddressMap[0];
        return safetyModuleAddress.hexEip55;
      },
    );
  }

  Future<({double rate, String address})> calculateSafetyModuleFees(
    String poolAddress,
  ) async {
    var rate = 0.0;
    var address = '';

    final resultSafetyModuleFeeRate = await getSafetyModuleFeeRate(poolAddress);
    await resultSafetyModuleFeeRate.map(
      success: (safetyModuleFeeRate) async {
        rate = safetyModuleFeeRate;
      },
      failure: (failure) {},
    );
    final resultSafetyModuleFeeAddress =
        await getSafetyModuleAddress(poolAddress);
    await resultSafetyModuleFeeAddress.map(
      success: (safetyModuleFeeAddress) async {
        address = safetyModuleFeeAddress;
      },
      failure: (failure) {},
    );
    return (rate: rate, address: address);
  }
}
