/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:aebridge/util/transaction_bridge_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';

class ArchethicContract with TransactionBridgeMixin {
  ArchethicContract();

  Future<Result<String, Failure>> deploySignedHTLC(
    String factoryAddress,
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
  ) async {
    return Result.guard(
      () async {
        final resultSigned = await getSignedHTLC(
          factoryAddress,
          poolAddress,
          userAddress,
          endTime,
          amount,
          tokenAddress,
        );

        late String code;
        resultSigned.map(
          success: (success) {
            code = success;
          },
          failure: (failure) {
            throw failure;
          },
        );

        final recipient = Recipient(
          address: poolAddress.toUpperCase(),
          action: 'request_secret_hash',
          args: [endTime, amount, userAddress],
        );

        final resultDeploy = await _deployHTLC(
          recipient,
          code,
        );
        late String htlcAddress;
        resultDeploy.map(
          success: (success) {
            htlcAddress = success;
            debugPrint('deploySignedHTLC - htlcAddress: $htlcAddress');
          },
          failure: (failure) {
            throw failure;
          },
        );
        return htlcAddress;
      },
    );
  }

  Future<Result<String, Failure>> provisionSignedHTLC(
    String htlcGenesisAddress,
    double amount,
  ) async {
    return Result.guard(
      () async {
        var transactionTransfer =
            Transaction(type: 'transfer', data: Transaction.initData())
                .addUCOTransfer(htlcGenesisAddress, toBigInt(amount));

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
        return transactionTransfer.address!.address!;
      },
    );
  }

  Future<Result<String, Failure>> deployChargeableHTLC(
    String factoryAddress,
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
    String secretHash,
  ) async {
    return Result.guard(
      () async {
        final result = await getChargeableHTLC(
          factoryAddress,
          poolAddress,
          userAddress,
          endTime,
          amount,
          tokenAddress,
          secretHash,
        );

        late String htlcAddress;
        await result.map(
          success: (code) async {
            final recipient = Recipient(
              address: poolAddress.toUpperCase(),
              action: 'request_funds',
              args: [
                endTime,
                amount,
                userAddress,
                secretHash,
              ],
            );

            final resultDeployHTLC = await _deployHTLC(
              recipient,
              code,
            );
            resultDeployHTLC.map(
              success: (success) {
                htlcAddress = success;
                debugPrint(
                  'deployChargeableHTLC - htlcAddress: $htlcAddress',
                );
              },
              failure: (failure) {
                debugPrint('deployChargeableHTLC - $failure');
                throw failure;
              },
            );
          },
          failure: (failure) {
            throw failure;
          },
        );
        return htlcAddress;
      },
    );
  }

  Future<Result<String, Failure>> _deployHTLC(
    Recipient recipient,
    String code,
  ) async {
    return Result.guard(
      () async {
        final apiService = sl.get<ApiService>();
        var seedSC = '';
        const chars = 'abcdef0123456789';
        final rng = Random.secure();
        for (var i = 0; i < 64; i++) {
          // ignore: use_string_buffers
          seedSC += chars[rng.nextInt(chars.length)];
        }

        final storageNoncePublicKey =
            await apiService.getStorageNoncePublicKey();
        final aesKey = uint8ListToHex(
          Uint8List.fromList(
            List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
          ),
        );
        final scAuthorizedKey = AuthorizedKey(
          encryptedSecretKey:
              uint8ListToHex(ecEncrypt(aesKey, storageNoncePublicKey)),
          publicKey: storageNoncePublicKey,
        );
        final htlcGenesisAddress = deriveAddress(seedSC, 0);

        // Faucet poolAddress
        var transactionTransfer =
            Transaction(type: 'transfer', data: Transaction.initData())
                .addUCOTransfer(htlcGenesisAddress, toBigInt(6));

        final currentNameAccount = await getCurrentAccount();

        transactionTransfer = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionTransfer],
        ))
            .first;

        debugPrint(
          '_deployHTLC - Tx address : ${transactionTransfer.address!.address!}',
        );
        final indexMap =
            await apiService.getTransactionIndex([htlcGenesisAddress]);
        final index = indexMap[htlcGenesisAddress] ?? 0;
        final originPrivateKey = apiService.getOriginKey();
        debugPrint('_deployHTLC - Seed SC: $seedSC');
        debugPrint('_deployHTLC - HTLC Genesis Address: $htlcGenesisAddress');

        final transactionSC =
            Transaction(type: 'contract', data: Transaction.initData())
                .setCode(code)
                .addRecipient(
                  recipient.address!,
                  action: recipient.action,
                  args: recipient.args,
                )
                .addOwnership(
                  uint8ListToHex(
                    aesEncrypt(seedSC, aesKey),
                  ),
                  [scAuthorizedKey],
                )
                .build(seedSC, index)
                .originSign(originPrivateKey);

        await sendTransactions(
          <Transaction>[transactionTransfer, transactionSC],
        );

        return htlcGenesisAddress;
      },
    );
  }

  Future<Result<String, Failure>> getSignedHTLC(
    String factoryAddress,
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
  ) async {
    return Result.guard(
      () async {
        late String code;

        final result = await _getSignedHTLCCode(
          factoryAddress,
          poolAddress,
          userAddress,
          endTime,
          amount,
          tokenAddress,
        );
        result.map(
          success: (success) {
            code = success;
          },
          failure: (failure) {
            throw failure;
          },
        );
        return code;
      },
    );
  }

  Future<Result<String, Failure>> getChargeableHTLC(
    String factoryAddress,
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
    String secretHash,
  ) async {
    return Result.guard(
      () async {
        debugPrint('getChargeableHTLC - FactoryAddress: $factoryAddress');
        debugPrint('getChargeableHTLC - PoolAddress: $poolAddress');
        debugPrint('getChargeableHTLC - UserAddress: $userAddress');
        debugPrint('getChargeableHTLC - EndTime: $endTime');
        debugPrint('getChargeableHTLC - Amount: $amount');
        debugPrint('getChargeableHTLC - TokenAddress: $tokenAddress');
        debugPrint('getChargeableHTLC - SecretHash: $secretHash');

        late String code;
        final result = await _getChargeableHTLCCode(
          factoryAddress,
          poolAddress,
          userAddress,
          endTime,
          amount,
          tokenAddress,
          secretHash,
        );
        result.map(
          success: (success) {
            code = success;
          },
          failure: (failure) {
            throw failure;
          },
        );

        return code;
      },
    );
  }

  Future<Result<String, Failure>> _getSignedHTLCCode(
    String factoryAddress,
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
  ) async {
    return Result.guard(
      () async {
        final code = await sl.get<ApiService>().callSCFunction(
              jsonRPCRequest: SCCallFunctionRequest(
                method: 'contract_fun',
                params: SCCallFunctionParams(
                  contract: factoryAddress.toUpperCase(),
                  function: 'get_signed_htlc',
                  args: [
                    endTime,
                    userAddress.toUpperCase(),
                    poolAddress.toUpperCase(),
                    if (tokenAddress.isEmpty)
                      'UCO'
                    else
                      tokenAddress.toUpperCase(),
                    amount,
                  ],
                ),
              ),
            );
        return code;
      },
    );
  }

  Future<Result<String, Failure>> _getChargeableHTLCCode(
    String factoryAddress,
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
    String secretHash,
  ) async {
    return Result.guard(
      () async {
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
        return code;
      },
    );
  }

  Future<Result<String, Failure>> revealSecretToChargeableHTLC(
    String userGenesisAddress,
    String currentNameAccount,
    String htlcAddress,
    String secret,
  ) async {
    return Result.guard(
      () async {
        final apiService = sl.get<ApiService>();

        // ignore: unused_local_variable
        var htlcAddressBefore = htlcAddress;
        final transactionMap = await apiService
            .getLastTransaction([htlcAddress], request: 'address');
        if (transactionMap[htlcAddress] != null &&
            transactionMap[htlcAddress]!.address != null &&
            transactionMap[htlcAddress]!.address!.address != null) {
          htlcAddressBefore = transactionMap[htlcAddress]!.address!.address!;
        }

        var transaction = Transaction(
          type: 'transfer',
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

        await sendTransactions(
          <Transaction>[transaction],
        );

        return transaction.address!.address!;
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
