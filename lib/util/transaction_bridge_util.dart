import 'dart:async';
import 'dart:developer';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart';

mixin TransactionBridgeMixin {
  Future<double> calculateFees(Transaction transaction) async {
    const slippage = 1.01;
    final transactionFee =
        await sl.get<ApiService>().getTransactionFee(transaction);
    final fees = fromBigInt(transactionFee.fee) * slippage;
    log(
      'Transaction ${transaction.address} : $fees UCO',
    );
    return fees;
  }

  ArchethicTransactionSender getArchethicTransactionSender() {
    return ArchethicTransactionSender(
      apiService: sl.get<ApiService>(),
      phoenixHttpEndpoint: '${sl.get<ApiService>().endpoint}/socket/websocket',
      websocketEndpoint:
          '${sl.get<ApiService>().endpoint.replaceAll('https:', 'wss:').replaceAll('http:', 'wss:')}/socket/websocket',
    );
  }

  Future<void> sendTransactions(
    List<Transaction> transactions,
  ) async {
    var errorDetail = '';
    for (final transaction in transactions) {
      if (errorDetail.isNotEmpty) {
        break;
      }
      var next = false;
      String websocketEndpoint;
      switch (sl.get<ApiService>().endpoint) {
        case 'https://mainnet.archethic.net':
        case 'https://testnet.archethic.net':
          websocketEndpoint =
              "${sl.get<ApiService>().endpoint.replaceAll('https:', 'wss:').replaceAll('http:', 'wss:')}/socket/websocket";
          break;
        default:
          websocketEndpoint =
              "${sl.get<ApiService>().endpoint.replaceAll('https:', 'wss:').replaceAll('http:', 'ws:')}/socket/websocket";
          break;
      }

      final transactionRepository = ArchethicTransactionSender(
        apiService: sl.get<ApiService>(),
        phoenixHttpEndpoint:
            '${sl.get<ApiService>().endpoint}/socket/websocket',
        websocketEndpoint: websocketEndpoint,
      );
      log('Send ${transaction.address!.address}');

      await transactionRepository.send(
        transaction: transaction,
        onConfirmation: (confirmation) async {
          if (confirmation.isEnoughConfirmed) {
            log('nbConfirmations: ${confirmation.nbConfirmations}, transactionAddress: ${confirmation.transactionAddress}, maxConfirmations: ${confirmation.maxConfirmations}');
            transactionRepository.close();
            next = true;
          }
        },
        onError: (error) async {
          transactionRepository.close();
          error.maybeMap(
            connectivity: (_) {
              errorDetail = 'No connection';
            },
            consensusNotReached: (_) {
              errorDetail = 'Consensus not reached';
            },
            timeout: (_) {
              errorDetail = 'Timeout';
            },
            invalidConfirmation: (_) {
              errorDetail = 'Invalid Confirmation';
            },
            insufficientFunds: (_) {
              errorDetail = 'Insufficient funds';
            },
            other: (error) {
              errorDetail = error.message;
            },
            orElse: () {
              errorDetail = 'An error is occured';
            },
          );
        },
      );

      while (next == false && errorDetail.isEmpty) {
        await Future.delayed(const Duration(seconds: 1));
        log('wait...');
      }
    }

    if (errorDetail.isNotEmpty) {
      throw Exception(errorDetail);
    }
  }

  Future<List<Transaction>> signTx(
    String serviceName,
    String pathSuffix,
    List<Transaction> transactions,
  ) async {
    final newTransactions = <Transaction>[];

    final payload = {
      'serviceName': serviceName,
      'pathSuffix': pathSuffix,
      'transactions': List<dynamic>.from(
        transactions.map((Transaction x) => x.toJson()),
      ),
    };
    log(
      payload.toString(),
    );

    final result =
        await sl.get<ArchethicDAppClient>().signTransactions(payload);
    result.when(
      failure: (failure) {
        log(
          'Signature failed',
          error: failure,
        );
        throw failure;
      },
      success: (result) {
        for (var i = 0; i < transactions.length; i++) {
          newTransactions.add(
            transactions[i]
                .setAddress(Address(address: result.signedTxs[i].address))
                .setPreviousSignatureAndPreviousPublicKey(
                  result.signedTxs[i].previousSignature,
                  result.signedTxs[i].previousPublicKey,
                )
                .setOriginSignature(result.signedTxs[i].originSignature),
          );
        }
      },
    );
    return newTransactions;
  }
}
