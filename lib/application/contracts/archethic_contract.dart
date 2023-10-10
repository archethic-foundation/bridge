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

  ({String seedHTLC, String genesisAddressHTLC}) defineHTLCAddress() {
    var seedSC = '';
    const chars = 'abcdef0123456789';
    final rng = Random.secure();
    for (var i = 0; i < 64; i++) {
      // ignore: use_string_buffers
      seedSC += chars[rng.nextInt(chars.length)];
    }
    debugPrint('HTLC - Seed SC: $seedSC');
    final genesisAddressHTLC = deriveAddress(seedSC, 0);
    return (seedHTLC: seedSC, genesisAddressHTLC: genesisAddressHTLC);
  }

  Future<Result<void, Failure>> deployHTLC(
    Recipient? recipient,
    String code,
    String htlcGenesisAddress,
    String seedSC,
  ) async {
    return Result.guard(
      () async {
        final apiService = sl.get<ApiService>();

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

        final indexMap =
            await apiService.getTransactionIndex([htlcGenesisAddress]);
        final index = indexMap[htlcGenesisAddress] ?? 0;
        final originPrivateKey = apiService.getOriginKey();

        debugPrint('deployHTLC - HTLC Genesis Address: $htlcGenesisAddress');

        final transactionSC =
            Transaction(type: 'contract', data: Transaction.initData())
                .setCode(code)
                .addOwnership(
          uint8ListToHex(
            aesEncrypt(seedSC, aesKey),
          ),
          [scAuthorizedKey],
        );

        late Transaction transactionFinal;
        if (recipient != null) {
          transactionFinal = transactionSC
              .addRecipient(
                recipient.address!,
                action: recipient.action,
                args: recipient.args,
              )
              .build(seedSC, index)
              .transaction
              .originSign(originPrivateKey);
        } else {
          transactionFinal = transactionSC
              .build(seedSC, index)
              .transaction
              .originSign(originPrivateKey);
        }

        final fees = await calculateFees(transactionFinal);
        var transactionTransfer =
            Transaction(type: 'transfer', data: Transaction.initData())
                .addUCOTransfer(
          htlcGenesisAddress,
          toBigInt(
            fees,
          ),
        );

        final currentNameAccount = await getCurrentAccount();

        transactionTransfer = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionTransfer],
        ))
            .first;

        debugPrint(
          'deployHTLC - Tx address : ${transactionTransfer.address!.address!}',
        );

        await sendTransactions(
          <Transaction>[transactionTransfer, transactionFinal],
        );
      },
    );
  }

  // TODO(reddwarf03): To be finished
  Future<Result<double, Failure>> estimateDeployHTLCFees(
    Recipient? recipient,
    String code,
  ) async {
    return Result.guard(
      () async {
        final apiService = sl.get<ApiService>();
        final falseSeedSC = generateRandomSeed();

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

        final originPrivateKey = apiService.getOriginKey();
        final transactionSC =
            Transaction(type: 'contract', data: Transaction.initData())
                .setCode(code)
                .addOwnership(
          uint8ListToHex(
            aesEncrypt(falseSeedSC, aesKey),
          ),
          [scAuthorizedKey],
        );

        late Transaction transactionFinal;
        if (recipient != null) {
          transactionFinal = transactionSC
              .addRecipient(
                recipient.address!,
                action: recipient.action,
                args: recipient.args,
              )
              .build(falseSeedSC, 0)
              .transaction
              .originSign(originPrivateKey);
        } else {
          transactionFinal = transactionSC
              .build(falseSeedSC, 0)
              .transaction
              .originSign(originPrivateKey);
        }

        final fees = await calculateFees(transactionFinal);
        return toBigInt(
          fees,
        ).toDouble();
      },
    );
  }
}
