import 'dart:async';

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

class EVMLPNative with EVMBridgeProcessMixin {
  EVMLPNative(
    this.providerEndpoint,
    this.htlcContractAddress,
    this.chainId,
  ) {
    web3Client = Web3Client(providerEndpoint, Client());
  }
  final String providerEndpoint;
  final String htlcContractAddress;
  Web3Client? web3Client;
  final int chainId;

  Future<Result<void, Failure>> provisionChargeableHTLC(
    double amount,
  ) async {
    return Result.guard(() async {
      final evmWalletProvider = sl.get<EVMWalletProvider>();
      final ethAmount = EtherAmount.fromDouble(EtherUnit.ether, amount);

      var timeout = false;
      late StreamSubscription<FilterEvent> subscription;
      try {
        final contract =
            await getDeployedContract(contractNameHTLCETH, htlcContractAddress);

        subscription = web3Client!
            .events(
              FilterOptions.events(
                contract: contract,
                event: contract.event('FundsReceived'),
              ),
            )
            .take(1)
            .listen((event) {
          debugPrint('Event FundsReceived = $event');
        });

        await sendTransactionWithErrorManagement(
          web3Client!,
          evmWalletProvider.credentials!,
          Transaction(
            to: EthereumAddress.fromHex(htlcContractAddress),
            gasPrice: EtherAmount.fromInt(EtherUnit.gwei, 10),
            maxGas: 500000,
            value: ethAmount,
          ),
          chainId,
        );

        await subscription.asFuture().timeout(
          const Duration(seconds: 20),
          onTimeout: () {
            debugPrint('Event FundsReceived = timeout');
            return timeout = true;
          },
        );
        await subscription.cancel();
      } catch (e) {
        debugPrint('e $e');
        await subscription.cancel();
        rethrow;
      }
      if (timeout) {
        debugPrint('timeout');
        throw const Failure.timeout();
      }
    });
  }

  Future<Result<String, Failure>> signedWithdraw(
    Secret secret,
  ) async {
    return Result.guard(
      () async {
        final evmWalletProvider = sl.get<EVMWalletProvider>();

        final contractHTLCETH = await getDeployedContract(
          contractNameSignedHTLCETH,
          htlcContractAddress,
        );

        final transactionWithdraw = Transaction.callContract(
          contract: contractHTLCETH,
          function: contractHTLCETH.findFunctionByNameAndNbOfParameters(
            'withdraw',
            4,
          ),
          parameters: [
            hexToBytes(secret.secret!),
            hexToBytes(secret.secretSignature!.r!),
            hexToBytes(secret.secretSignature!.s!),
            BigInt.from(secret.secretSignature!.v!),
          ],
        );

        var withdrawTx = '';
        var timeout = false;
        late StreamSubscription<FilterEvent> subscription;
        try {
          subscription = web3Client!
              .events(
                FilterOptions.events(
                  contract: contractHTLCETH,
                  event: contractHTLCETH.event('Withdrawn'),
                ),
              )
              .take(1)
              .listen((event) {
            debugPrint('Event Withdrawn = $event');
          });

          withdrawTx = await sendTransactionWithErrorManagement(
            web3Client!,
            evmWalletProvider.credentials!,
            transactionWithdraw,
            chainId,
          );

          await subscription.asFuture().timeout(
            const Duration(seconds: 20),
            onTimeout: () {
              debugPrint('Event Withdrawn = timeout');
              return timeout = true;
            },
          );
          await subscription.cancel();
        } catch (e) {
          debugPrint('e $e');
          await subscription.cancel();
          rethrow;
        }
        if (timeout) {
          debugPrint('timeout');
          throw const Failure.timeout();
        }

        debugPrint('signedWithdrawTx: $withdrawTx');
        return withdrawTx;
      },
    );
  }
}
