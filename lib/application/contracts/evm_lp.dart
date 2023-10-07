/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/evm_mixin.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:flutter/material.dart';
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
  ) async {
    final amountInWei = BigInt.from(amount * 1e18);
    final transactionMintHTLC = Transaction.callContract(
      contract: deployedContract,
      function: deployedContract.function('mintHTLC'),
      parameters: [hexToBytes(hash), amountInWei],
      value: isERC20 == false
          ? EtherAmount.fromBigInt(EtherUnit.wei, amountInWei)
          : null,
    );
    return transactionMintHTLC;
  }

  Future<Result<double, Failure>> estimateDeployChargeableHTLC(
    String poolAddress,
    String hash,
    double amount,
    bool isERC20,
  ) async {
    return Result.guard(() async {
      final web3Client = Web3Client(providerEndpoint!, Client());
      final contract =
          await getDeployedContract(contractNameIPool, poolAddress);

      final transaction = await _getDeployChargeableHTLCTransaction(
        contract,
        poolAddress,
        hash,
        amount,
        isERC20,
      );

      final fees = await estimateGas(web3Client, transaction);

      return EtherAmount.fromBigInt(EtherUnit.ether, fees)
          .getValueInUnit(EtherUnit.ether);
    });
  }

  Future<Result<String, Failure>> deployChargeableHTLC(
    String poolAddress,
    String hash,
    double amount,
    bool isERC20, {
    int chainId = 1337,
  }) async {
    return Result.guard(() async {
      final evmWalletProvider = sl.get<EVMWalletProvider>();
      debugPrint('providerEndpoint: $providerEndpoint');
      final web3Client = Web3Client(providerEndpoint!, Client());
      late String htlcContractAddress;

      final contractLPERC =
          await getDeployedContract(contractNameIPool, poolAddress);

      final transaction = await _getDeployChargeableHTLCTransaction(
        contractLPERC,
        poolAddress,
        hash,
        amount,
        isERC20,
      );

      debugPrint('contractLPERC mintHTLC ok');

      await sendTransactionWithErrorManagement(
        web3Client,
        evmWalletProvider.credentials!,
        transaction,
        chainId,
      );

      debugPrint('HTLC Contract deployed');

      // Get HTLC address
      final transactionMintedSwapsHashes = await web3Client.call(
        contract: contractLPERC,
        function: contractLPERC.function('mintedSwap'),
        params: [
          hexToBytes(hash),
        ],
      );

      htlcContractAddress = transactionMintedSwapsHashes[0].hex;
      debugPrint('HTLC address: $htlcContractAddress');

      return htlcContractAddress;
    });
  }

  Future<Result<String, Failure>> deployAndProvisionSignedHTLC(
    String poolAddress,
    SecretHash secretHash,
    double amount,
    int endTime, {
    int chainId = 1337,
  }) async {
    return Result.guard(
      () async {
        final evmWalletProvider = sl.get<EVMWalletProvider>();
        debugPrint('providerEndpoint: $providerEndpoint');
        final web3Client = Web3Client(providerEndpoint!, Client());
        late String htlcContractAddress;

        final contractLP =
            await getDeployedContract(contractNameIPool, poolAddress);

        final amountInWei = BigInt.from(amount * 1e18);

        final transactionProvisionHTLC = Transaction.callContract(
          contract: contractLP,
          function: contractLP.function('provisionHTLC'),
          parameters: [
            hexToBytes(secretHash.secretHash!),
            amountInWei,
            BigInt.from(endTime),
            hexToBytes(secretHash.secretHashSignature!.r!),
            hexToBytes(secretHash.secretHashSignature!.s!),
            BigInt.from(secretHash.secretHashSignature!.v!),
          ],
        );

        debugPrint('contractLP provisionHTLC ok');

        await sendTransactionWithErrorManagement(
          web3Client,
          evmWalletProvider.credentials!,
          transactionProvisionHTLC,
          chainId,
        );

        debugPrint('HTLC Contract deployed');
        debugPrint('secretHash : ${hexToBytes(secretHash.secretHash!)}');
        // Get HTLC address
        final transactionProvisionedSwapsHashes = await web3Client.call(
          contract: contractLP,
          function: contractLP.function('provisionedSwap'),
          params: [
            hexToBytes(secretHash.secretHash!),
          ],
        );

        htlcContractAddress = transactionProvisionedSwapsHashes[0].hex;
        debugPrint('HTLC address: $htlcContractAddress');

        return htlcContractAddress;
      },
    );
  }

  Future<Result<double, Failure>> getSafetyModuleFeeRate(
    String poolAddress,
  ) async {
    return Result.guard(
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
        debugPrint('HTLC safetyModuleFeeRate: $safetyModuleFeeRate');

        return safetyModuleFeeRate.toDouble() / 100000 * 100;
      },
    );
  }

  Future<Result<String, Failure>> getSafetyModuleAddress(
    String poolAddress,
  ) async {
    return Result.guard(
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
        debugPrint('HTLC safetyModuleAddress: $safetyModuleAddress');

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
