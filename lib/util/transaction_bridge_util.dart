import 'dart:async';
import 'dart:developer' as dev;
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/util/custom_logs.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/foundation.dart';

mixin TransactionBridgeMixin {
  Future<double> calculateFees(
    Transaction transaction, {
    double slippage = 1.01,
  }) async {
    final transactionFee =
        await sl.get<ApiService>().getTransactionFee(transaction);
    final fees = fromBigInt(transactionFee.fee) * slippage;
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
      await transactionRepository.send(
        transaction: transaction,
        onConfirmation: (confirmation) async {
          if (confirmation.isEnoughConfirmed) {
            sl.get<LogManager>().log(
                  'nbConfirmations: ${confirmation.nbConfirmations}, transactionAddress: ${confirmation.transactionAddress}, maxConfirmations: ${confirmation.maxConfirmations}',
                  level: LogLevel.debug,
                );
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
        if (kDebugMode) dev.log('wait...');
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

    final result =
        await sl.get<awc.ArchethicDAppClient>().signTransactions(payload);
    result.when(
      failure: (failure) {
        if (failure.code == 4001) {
          throw const Failure.userRejected();
        }
        throw Failure.other(
          cause: failure.message,
          stack: failure.stack.toString(),
        );
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

  Future<bool> waitForManualTxConfirmation(
    String txChainAddress,
    int targetIndex, {
    int nbTrials = 60,
  }) async {
    final apiService = sl.get<ApiService>();

    for (var i = 0; i < nbTrials; i++) {
      final txIndexMap = await apiService.getTransactionIndex([txChainAddress]);
      if (txIndexMap[txChainAddress] != null &&
          txIndexMap[txChainAddress] == targetIndex) {
        return true;
      }

      await Future.delayed(const Duration(seconds: 1));
    }

    return false;
  }

  Future<String> getCurrentAccount() async {
    var accountName = '';

    // TODO(a): remove the try catch, not mandatory but I added it to have the connection issue front exception for the user
    try {
      final result =
          await sl.get<awc.ArchethicDAppClient>().getCurrentAccount();
      result.when(
        failure: (failure) {
          throw Exception('An error occurs');
        },
        success: (result) {
          accountName = result.shortName;
        },
      );
    } catch (e, stackTrace) {
      sl.get<LogManager>().log(
            '$e',
            stackTrace: stackTrace,
            level: LogLevel.error,
          );
    }

    return accountName;
  }
}
