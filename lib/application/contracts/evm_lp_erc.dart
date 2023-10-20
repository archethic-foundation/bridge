import 'dart:async';

import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/models/secret.dart';
import 'package:aebridge/domain/usecases/bridge_evm_process_mixin.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/webthree.dart';

class EVMLPERC with EVMBridgeProcessMixin {
  EVMLPERC(
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
    WidgetRef ref,
    double amount,
    String tokenAddress,
  ) async {
    return Result.guard(
      () async {
        final evmWalletProvider = sl.get<EVMWalletProvider>();
        debugPrint('providerEndpoint: $providerEndpoint');

        final contract =
            await getDeployedContract(contractNameIERC20, tokenAddress);

        final ethAmount = EtherAmount.fromDouble(EtherUnit.ether, amount);
        final transactionTransfer = Transaction.callContract(
          contract: contract,
          function: contract.function('transfer'),
          parameters: [
            EthereumAddress.fromHex(htlcContractAddress),
            ethAmount.getInWei,
          ],
          maxGas: 1000000,
        );

        final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);

        var timeout = false;
        late StreamSubscription<FilterEvent> subscription;
        try {
          subscription = web3Client!
              .events(
                FilterOptions.events(
                  contract: contract,
                  event: contract.event('Transfer'),
                ),
              )
              .take(1)
              .listen(
            (event) {
              debugPrint('Event Transfer = $event');
            },
          );

          await sendTransactionWithErrorManagement(
            web3Client!,
            evmWalletProvider.credentials!,
            transactionTransfer,
            chainId,
          );

          await bridgeNotifier.setWaitForWalletConfirmation(true);

          await subscription.asFuture().timeout(
            const Duration(seconds: 240),
            onTimeout: () {
              debugPrint('Event Transfer = timeout');
              return timeout = true;
            },
          );
          await subscription.cancel();
          await bridgeNotifier.setWaitForWalletConfirmation(false);
        } catch (e) {
          debugPrint('e $e');
          await subscription.cancel();
          await bridgeNotifier.setWaitForWalletConfirmation(false);
          rethrow;
        }
        if (timeout) {
          debugPrint('timeout');
          throw const Failure.timeout();
        }
      },
    );
  }

  Future<Result<String, Failure>> signedWithdraw(
    WidgetRef ref,
    Secret secret,
  ) async {
    return Result.guard(
      () async {
        final evmWalletProvider = sl.get<EVMWalletProvider>();

        final contractHTLCERC = await getDeployedContract(
          contractNameSignedHTLCERC,
          htlcContractAddress,
        );

        final transactionWithdraw = Transaction.callContract(
          contract: contractHTLCERC,
          function: contractHTLCERC.findFunctionByNameAndNbOfParameters(
            'withdraw',
            4,
          ),
          parameters: [
            hexToBytes(secret.secret!),
            hexToBytes(secret.secretSignature!.r!),
            hexToBytes(secret.secretSignature!.s!),
            BigInt.from(secret.secretSignature!.v!),
          ],
          maxGas: 1000000,
        );

        final bridgeNotifier = ref.read(BridgeFormProvider.bridgeForm.notifier);

        var withdrawTx = '';
        var timeout = false;
        late StreamSubscription<FilterEvent> subscription;
        try {
          subscription = web3Client!
              .events(
                FilterOptions.events(
                  contract: contractHTLCERC,
                  event: contractHTLCERC.event('Withdrawn'),
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

          await bridgeNotifier.setWaitForWalletConfirmation(true);

          await subscription.asFuture().timeout(
            const Duration(seconds: 240),
            onTimeout: () {
              debugPrint('Event Withdrawn = timeout');
              return timeout = true;
            },
          );
          await subscription.cancel();
          await bridgeNotifier.setWaitForWalletConfirmation(false);
        } catch (e) {
          debugPrint('e $e');
          await subscription.cancel();
          await bridgeNotifier.setWaitForWalletConfirmation(false);
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

  Future<Result<double, Failure>> getFee() async {
    return Result.guard(
      () async {
        final contractHTLC = await getDeployedContract(
          contractNameChargeableHTLCERC,
          htlcContractAddress,
        );

        final feeMap = await web3Client!.call(
          contract: contractHTLC,
          function: contractHTLC.function('fee'),
          params: [],
        );

        final BigInt fee = feeMap[0];
        debugPrint('HTLC fee: $fee');

        final etherAmount = EtherAmount.fromBigInt(EtherUnit.wei, fee);
        return etherAmount.getValueInUnit(EtherUnit.ether);
      },
    );
  }

  Future<Result<int, Failure>> getTokenNbOfDecimal(String tokenAddress) async {
    return Result.guard(
      () async {
        final contractHTLC = await getDeployedContract(
          contractNameIERC20,
          tokenAddress,
        );

        final decimalsMap = await web3Client!.call(
          contract: contractHTLC,
          function: contractHTLC.function('decimals'),
          params: [],
        );

        final int decimals = decimalsMap[0].toInt();
        debugPrint('Token decimals: $decimals');

        return decimals;
      },
    );
  }
}
