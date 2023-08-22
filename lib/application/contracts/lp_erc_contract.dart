/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/model/secret.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/webthree.dart';

class LPERCContract {
  LPERCContract(this.providerEndpoint);

  String? providerEndpoint;

  Future<Result<String, Failure>> deployChargeableHTLC(
    String poolAddress,
    String hash,
    BigInt amount, {
    int lockTime = 720,
    int chainId = 1337,
  }) async {
    return Result.guard(() async {
      final evmWalletProvider = sl.get<EVMWalletProvider>();
      debugPrint('providerEndpoint: $providerEndpoint');
      final web3Client = Web3Client(providerEndpoint!, Client());
      late String htlcContractAddress;

      final abiLPERCStringJson = jsonDecode(
        await rootBundle.loadString('truffle/build/contracts/IPool.json'),
      );

      final contractLPERC = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(abiLPERCStringJson['abi']),
          abiLPERCStringJson['contractName'] as String,
        ),
        EthereumAddress.fromHex(poolAddress),
      );

      debugPrint('contractLPERC ok');

      final transactionMintHTLC = Transaction.callContract(
        contract: contractLPERC,
        function: contractLPERC.function('mintHTLC'),
        parameters: [
          hexToBytes(hash),
          EtherAmount.fromUnitAndValue(EtherUnit.ether, amount).getInWei,
          BigInt.from(lockTime),
        ],
      );

      debugPrint('contractLPERC mintHTLC ok');

      await web3Client.sendTransaction(
        evmWalletProvider.credentials!,
        transactionMintHTLC,
        chainId: chainId,
      );

      debugPrint('HTLC Contract deployed');

      // Get HTLC Contract address
      final transactionMintedSwapsHashes = await web3Client.call(
        contract: contractLPERC,
        function: contractLPERC.function('mintedSwaps'),
        params: [
          hexToBytes(hash),
        ],
      );

      htlcContractAddress = transactionMintedSwapsHashes[0].hex;
      debugPrint('HTLC Contract address: $htlcContractAddress');

      return htlcContractAddress;
    });
  }

  Future<Result<void, Failure>> provisionChargeableHTLC(
    BigInt amount,
    String htlcContractAddress,
    String tokenAddress, {
    int chainId = 1337,
  }) async {
    return Result.guard(
      () async {
        final evmWalletProvider = sl.get<EVMWalletProvider>();
        debugPrint('providerEndpoint: $providerEndpoint');
        final web3Client = Web3Client(providerEndpoint!, Client());

        final abiDummyTokenStringJson = jsonDecode(
          await rootBundle.loadString('truffle/build/contracts/IERC20.json'),
        );

        final contractDummyToken = DeployedContract(
          ContractAbi.fromJson(
            jsonEncode(abiDummyTokenStringJson['abi']),
            abiDummyTokenStringJson['contractName'] as String,
          ),
          EthereumAddress.fromHex(tokenAddress),
        );

        final transactionTransfer = Transaction.callContract(
          contract: contractDummyToken,
          function: contractDummyToken.function('transfer'),
          parameters: [
            EthereumAddress.fromHex(htlcContractAddress),
            EtherAmount.fromUnitAndValue(EtherUnit.ether, amount).getInWei,
          ],
        );

        await web3Client.sendTransaction(
          evmWalletProvider.credentials!,
          transactionTransfer,
          chainId: chainId,
        );

        debugPrint('Token provisionned');
      },
    );
  }

  Future<Result<String, Failure>> deployAndProvisionSignedHTLC(
    String poolAddress,
    SecretHash secretHash,
    BigInt amount, {
    int lockTime = 720,
    int chainId = 1337,
  }) async {
    return Result.guard(
      () async {
        final evmWalletProvider = sl.get<EVMWalletProvider>();
        debugPrint('providerEndpoint: $providerEndpoint');
        final web3Client = Web3Client(providerEndpoint!, Client());
        late String htlcContractAddress;

        final abiLPERCStringJson = jsonDecode(
          await rootBundle.loadString('truffle/build/contracts/IPool.json'),
        );

        final contractLPERC = DeployedContract(
          ContractAbi.fromJson(
            jsonEncode(abiLPERCStringJson['abi']),
            abiLPERCStringJson['contractName'] as String,
          ),
          EthereumAddress.fromHex(poolAddress),
        );

        debugPrint('contractLPERC ok');
        debugPrint(
          'EtherAmount.fromUnitAndValue(EtherUnit.ether, amount).getInWei ${EtherAmount.fromUnitAndValue(EtherUnit.ether, amount).getInWei}',
        );
        final transactionProvisionHTLC = Transaction.callContract(
          contract: contractLPERC,
          function: contractLPERC.function('provisionHTLC'),
          parameters: [
            hexToBytes(secretHash.secretHash!),
            EtherAmount.fromUnitAndValue(EtherUnit.ether, amount).getInWei,
            BigInt.from(lockTime),
            hexToBytes(secretHash.secretHashSignature!.r!),
            hexToBytes(secretHash.secretHashSignature!.s!),
            BigInt.from(secretHash.secretHashSignature!.v!),
          ],
        );

        debugPrint('contractLPERC provisionHTLC ok');

        await web3Client.sendTransaction(
          evmWalletProvider.credentials!,
          transactionProvisionHTLC,
          chainId: chainId,
        );

        debugPrint('HTLC Contract deployed');
        debugPrint('secretHash : ${hexToBytes(secretHash.secretHash!)}');
        // Get HTLC Contract address
        final transactionProvisionedSwapsHashes = await web3Client.call(
          contract: contractLPERC,
          function: contractLPERC.function('provisionedSwaps'),
          params: [
            hexToBytes(secretHash.secretHash!),
          ],
        );

        htlcContractAddress = transactionProvisionedSwapsHashes[0].hex;
        debugPrint('HTLC Contract address: $htlcContractAddress');

        return htlcContractAddress;
      },
    );
  }

  Future<Result<String, Failure>> withdraw(
    String htlcContractAddress,
    String secret, {
    int chainId = 1337,
  }) async {
    return Result.guard(
      () async {
        final evmWalletProvider = sl.get<EVMWalletProvider>();

        final web3Client = Web3Client(providerEndpoint!, Client());

        final abiStringJson = jsonDecode(
          await rootBundle.loadString('truffle/build/contracts/IHTLC.json'),
        );

        debugPrint('withdraw - htlcContractAddress: $htlcContractAddress');
        debugPrint('withdraw - secret: $secret');

        final contractHTLCERC = DeployedContract(
          ContractAbi.fromJson(
            jsonEncode(abiStringJson['abi']),
            abiStringJson['contractName'] as String,
          ),
          EthereumAddress.fromHex(htlcContractAddress),
        );

        final transactionWithdraw = Transaction.callContract(
          contract: contractHTLCERC,
          function: contractHTLCERC.function('withdraw'),
          parameters: [
            hexToBytes(secret),
          ],
        );

        final withdrawTx = await web3Client.sendTransaction(
          evmWalletProvider.credentials!,
          transactionWithdraw,
          chainId: chainId,
        );

        debugPrint('withdrawTx: $withdrawTx');
        return withdrawTx;
      },
    );
  }

  Future<Result<String, Failure>> signedWithdraw(
    String htlcContractAddress,
    Secret secret, {
    int chainId = 1337,
  }) async {
    return Result.guard(
      () async {
        final evmWalletProvider = sl.get<EVMWalletProvider>();

        final web3Client = Web3Client(providerEndpoint!, Client());

        final abiStringJson = jsonDecode(
          await rootBundle
              .loadString('truffle/build/contracts/SignedHTLC_ERC.json'),
        );

        final contractHTLCERC = DeployedContract(
          ContractAbi.fromJson(
            jsonEncode(abiStringJson['abi']),
            abiStringJson['contractName'] as String,
          ),
          EthereumAddress.fromHex(htlcContractAddress),
        );

        final transactionWithdraw = Transaction.callContract(
          contract: contractHTLCERC,
          function: contractHTLCERC.function('signedWithdraw'),
          parameters: [
            hexToBytes(secret.secret!),
            hexToBytes(secret.secretSignature!.r!),
            hexToBytes(secret.secretSignature!.s!),
            BigInt.from(secret.secretSignature!.v!),
          ],
        );

        final withdrawTx = await web3Client.sendTransaction(
          evmWalletProvider.credentials!,
          transactionWithdraw,
          chainId: chainId,
        );

        debugPrint('signedWithdrawTx: $withdrawTx');
        return withdrawTx;
      },
    );
  }
}
