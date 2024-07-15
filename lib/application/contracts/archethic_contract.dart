/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:aebridge/domain/usecases/bridge_ae_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchethicContract
    with aedappfm.TransactionMixin, ArchethicBridgeProcessMixin {
  ArchethicContract();

  ({String seedHTLC, String genesisAddressHTLC}) defineHTLCAddress() {
    var seedSC = '';
    const chars = 'abcdef0123456789';
    final rng = Random.secure();
    for (var i = 0; i < 64; i++) {
      // ignore: use_string_buffers
      seedSC += chars[rng.nextInt(chars.length)];
    }
    final genesisAddressHTLC = deriveAddress(seedSC, 0);
    return (seedHTLC: seedSC, genesisAddressHTLC: genesisAddressHTLC);
  }

  Future<aedappfm.Result<void, aedappfm.Failure>> deployHTLC(
    WidgetRef ref,
    Recipient? recipient,
    String code,
    String htlcGenesisAddress,
    String seedSC,
    double slippageFees,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final apiService = aedappfm.sl.get<ApiService>();
        final blockchainTxVersion = int.parse(
          (await apiService.getBlockchainVersion()).version.transaction,
        );

        final storageNoncePublicKey =
            await apiService.getStorageNoncePublicKey();
        final aesKey = uint8ListToHex(
          Uint8List.fromList(
            List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
          ),
        );
        final scAuthorizedKey = AuthorizedKey(
          encryptedSecretKey: uint8ListToHex(
            ecEncrypt(aesKey, storageNoncePublicKey),
          ),
          publicKey: storageNoncePublicKey,
        );

        final indexMap =
            await apiService.getTransactionIndex([htlcGenesisAddress]);
        final index = indexMap[htlcGenesisAddress] ?? 0;
        final originPrivateKey = apiService.getOriginKey();
        final transactionSC = Transaction(
          type: 'contract',
          version: blockchainTxVersion,
          data: Transaction.initData(),
        ).setCode(code).addOwnership(
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

        final fees =
            await calculateFees(transactionFinal, slippage: slippageFees);
        var transactionTransfer = Transaction(
          type: 'transfer',
          version: blockchainTxVersion,
          data: Transaction.initData(),
        ).addUCOTransfer(
          htlcGenesisAddress,
          toBigInt(
            fees,
          ),
        );

        final currentNameAccount = await getCurrentAccount();

        final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);
        await bridgeNotifier
            .setWalletConfirmation(WalletConfirmation.archethic);
        transactionTransfer = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transactionTransfer],
        ))
            .first;
        await bridgeNotifier.setWalletConfirmation(null);
        await sendTransactions(
          <Transaction>[transactionTransfer, transactionFinal],
        );
      },
    );
  }

  Future<aedappfm.Result<String, aedappfm.Failure>> refund(
    WidgetRef ref,
    String currentNameAccount,
    String htlcAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final apiService = aedappfm.sl.get<ApiService>();
        final blockchainTxVersion = int.parse(
          (await apiService.getBlockchainVersion()).version.transaction,
        );

        final infoResult = await getInfo(apiService, htlcAddress);

        var transaction = Transaction(
          type: 'transfer',
          version: blockchainTxVersion,
          data: Transaction.initData(),
        ).addRecipient(
          infoResult.aePoolAddress!,
          action: 'refund',
          args: [
            htlcAddress,
          ],
        );

        final refundNotifier = ref.read(RefundFormProvider.refundForm.notifier);
        ref
            .read(RefundFormProvider.refundForm.notifier)
            .setWalletConfirmation(WalletConfirmationRefund.archethic);
        transaction = (await signTx(
          Uri.encodeFull('archethic-wallet-$currentNameAccount'),
          '',
          [transaction],
        ))
            .first;
        refundNotifier.setWalletConfirmation(null);
        await sendTransactions(
          <Transaction>[transaction],
        );

        return transaction.address!.address!;
      },
    );
  }

  Future<
      ({
        int status,
        double? amount,
        int? endTime,
        double? estimatedProtocolFees
      })> getHTLCInfo(ApiService apiService, String htlcAddress) async {
    final lastAddressResult = await apiService.getLastTransaction(
      [htlcAddress],
      request: 'address',
    );
    if (lastAddressResult[htlcAddress] == null) {
      throw const aedappfm.Failure.notHTLC();
    }

    final lastHTLCTransaction = lastAddressResult[htlcAddress];

    final infoHTLCResult =
        await getInfo(apiService, lastHTLCTransaction!.address!.address!);

    if (infoHTLCResult.statusHTLC == null) {
      throw const aedappfm.Failure.notHTLC();
    } else {
      // Pending
      if (infoHTLCResult.statusHTLC == 0) {
        const d = Decimal.parse;
        final resultGetAEHTLCData =
            await getAEHTLCData(htlcAddress, apiService);
        final calcul =
            (d('0.003') / d('0.997')).toDecimal(scaleOnInfinitePrecision: 8);
        final estimatedProtocolFees =
            (d(resultGetAEHTLCData.amount.toString()) * calcul)
                .round(scale: 8)
                .toDouble();
        return (
          status: infoHTLCResult.statusHTLC!,
          amount: resultGetAEHTLCData.amount,
          endTime: resultGetAEHTLCData.endTime,
          estimatedProtocolFees: estimatedProtocolFees
        );
      } else {
        // Withdrawn or Refunded
        if (infoHTLCResult.statusHTLC == 1 || infoHTLCResult.statusHTLC == 2) {
          return (
            status: infoHTLCResult.statusHTLC!,
            amount: null,
            endTime: null,
            estimatedProtocolFees: null,
          );
        } else {
          throw const aedappfm.Failure.notHTLC();
        }
      }
    }
  }
}
