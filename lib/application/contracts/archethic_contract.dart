/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:aebridge/util/transaction_bridge_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';

class ArchethicContract with TransactionBridgeMixin {
  ArchethicContract();

  Future<String?> deploySignedHTLC(
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
  ) async {
    final (String code, String content) = await getSignedHTLC(
      poolAddress,
      userAddress,
      endTime,
      amount,
      tokenAddress,
    );

    return _deployHTLC(poolAddress, code, content);
  }

  Future<String> provisionSignedHTLC(
    String htlcGenesisAddress,
    double amount,
  ) async {
    var transactionTransfer =
        Transaction(type: 'transfer', data: Transaction.initData())
            .addUCOTransfer(htlcGenesisAddress, toBigInt(amount));
    try {
      final currentNameAccount = await getCurrentAccount();
      transactionTransfer = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionTransfer],
      ))
          .first;
    } catch (e) {
      debugPrint('provisionSignedHTLC signature failed');
    }

    await sendTransactions(
      <Transaction>[transactionTransfer],
    );

    debugPrint(
      'provisionSignedHTLC tx address ${transactionTransfer.address!.address!}',
    );
    return transactionTransfer.address!.address!;
  }

  Future<String?> deployChargeableHTLC(
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
    String secretHash,
  ) async {
    final (String code, String content) = await getChargeableHTLC(
      poolAddress,
      userAddress,
      endTime,
      amount,
      tokenAddress,
      secretHash,
    );

    return _deployHTLC(poolAddress, code, content);
  }

  Future<String?> _deployHTLC(
    String poolAddress,
    String code,
    String content,
  ) async {
    final apiService = sl.get<ApiService>();
    var seedSC = '';
    const chars = 'abcdef0123456789';
    final rng = Random.secure();
    for (var i = 0; i < 64; i++) {
      // ignore: use_string_buffers
      seedSC += chars[rng.nextInt(chars.length)];
    }

    final storageNoncePublicKey = await apiService.getStorageNoncePublicKey();
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
    try {
      final currentNameAccount = await getCurrentAccount();
      transactionTransfer = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transactionTransfer],
      ))
          .first;
    } catch (e) {
      debugPrint('TransactionTransfer signature failed');
    }

    debugPrint(
      'transactionTransfer address : ${transactionTransfer.address!.address!}',
    );
    final indexMap = await apiService.getTransactionIndex([htlcGenesisAddress]);
    final index = indexMap[htlcGenesisAddress] ?? 0;
    final originPrivateKey = apiService.getOriginKey();
    debugPrint('Seed SC: $seedSC');
    debugPrint('HTLC Genesis Address: $htlcGenesisAddress');
    debugPrint('Recipient: $poolAddress');
    debugPrint('Code: $code');
    debugPrint('Content: $content');
    final transactionSC =
        Transaction(type: 'contract', data: Transaction.initData())
            .setCode(code)
            .setContent(content)
            .addRecipient(poolAddress.toUpperCase())
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
  }

  Future<(String, String)> getSignedHTLC(
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
  ) async {
    final code = await _getSignedHTLCCode(
      poolAddress,
      userAddress,
      endTime,
      amount,
      tokenAddress,
    );
    final content = _getSignedHTLCContent(userAddress, endTime, amount);
    return (code, content);
  }

  Future<(String, String)> getChargeableHTLC(
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
    String secretHash,
  ) async {
    debugPrint('poolAddress: $poolAddress');
    debugPrint('userAddress: $userAddress');
    debugPrint('endTime: $endTime');
    debugPrint('amount: $amount');
    debugPrint('tokenAddress: $tokenAddress');
    debugPrint('secretHash: $secretHash');

    final code = await _getChargeableHTLCCode(
      poolAddress,
      userAddress,
      endTime,
      amount,
      tokenAddress,
      secretHash,
    );
    final content =
        _getChargeableHTLCContent(userAddress, endTime, amount, secretHash);
    return (code, content);
  }

  Future<String> _getSignedHTLCCode(
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
  ) async {
    final code = await sl.get<ApiService>().callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: poolAddress.toUpperCase(),
              function: 'get_signed_htlc',
              args: [
                endTime,
                userAddress.toUpperCase(),
                poolAddress.toUpperCase(),
                if (tokenAddress.isEmpty) 'UCO' else tokenAddress.toUpperCase(),
                amount,
              ],
            ),
          ),
        );
    return code;
  }

  Future<String> _getChargeableHTLCCode(
    String poolAddress,
    String userAddress,
    int endTime,
    double amount,
    String tokenAddress,
    String secretHash,
  ) async {
    final code = await sl.get<ApiService>().callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: poolAddress,
              function: 'get_chargeable_htlc',
              args: [
                endTime,
                userAddress.toUpperCase(),
                poolAddress.toUpperCase(),
                secretHash,
                if (tokenAddress.isEmpty) 'UCO' else tokenAddress.toUpperCase(),
                amount,
              ],
            ),
          ),
        );
    return code;
  }

  String _getSignedHTLCContent(
    String userAddress,
    int endTime,
    double amount,
  ) {
    final contentMap = {
      'action': 'request_secret_hash',
      'endTime': endTime,
      'userAddress': userAddress.toUpperCase(),
      'amount': amount,
    };
    return jsonEncode(contentMap);
  }

  String _getChargeableHTLCContent(
    String userAddress,
    int endTime,
    double amount,
    String secretHash,
  ) {
    final contentMap = {
      'action': 'request_funds',
      'endTime': endTime,
      'userAddress': userAddress.toUpperCase(),
      'secretHash': secretHash,
      'amount': amount,
    };
    return jsonEncode(contentMap);
  }

  Future<void> revealSecretToChargeableHTLC(
    String userGenesisAddress,
    String currentNameAccount,
    String htlcAddress,
    String secret,
  ) async {
    final apiService = sl.get<ApiService>();
    debugPrint('revealSecretToChargeableHTLC start');
    // ignore: unused_local_variable
    var htlcAddressBefore = htlcAddress;
    final transactionMap =
        await apiService.getLastTransaction([htlcAddress], request: 'address');
    if (transactionMap[htlcAddress] != null &&
        transactionMap[htlcAddress]!.address != null &&
        transactionMap[htlcAddress]!.address!.address != null) {
      htlcAddressBefore = transactionMap[htlcAddress]!.address!.address!;
    }

    var transaction = Transaction(type: 'data', data: Transaction.initData())
        .setContent(secret)
        .addRecipient(htlcAddress);

    try {
      transaction = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transaction],
      ))
          .first;

      debugPrint('transaction: ${transaction.address!.address!}');
      await sendTransactions(
        <Transaction>[transaction],
      );
      debugPrint('revealSecretToChargeableHTLC finished');
    } catch (e) {
      debugPrint('Signature failed');
    }
  }

  Future<String> requestSecretFromSignedHTLC(
    String currentNameAccount,
    String htlcAddress,
    String poolAddress,
  ) async {
    debugPrint('requestSecretFromSignedHTLC start');
    debugPrint('poolAddress: $poolAddress');
    debugPrint('htlcAddress: $htlcAddress');
    var transaction = Transaction(type: 'data', data: Transaction.initData())
        .setContent(
          jsonEncode(
            {'action': 'request_secret', 'htlcGenesisAddress': htlcAddress},
          ),
        )
        .addRecipient(poolAddress);

    try {
      transaction = (await signTx(
        Uri.encodeFull('archethic-wallet-$currentNameAccount'),
        '',
        [transaction],
      ))
          .first;

      debugPrint('transaction: ${transaction.address!.address!}');
      await sendTransactions(
        <Transaction>[transaction],
      );

      debugPrint('requestSecretFromSignedHTLC finished');
    } catch (e) {
      debugPrint('Signature failed');
    }
    return transaction.address!.address!;
  }
}
