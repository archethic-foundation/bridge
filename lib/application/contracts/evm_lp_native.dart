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
    BigInt amount,
  ) async {
    return Result.guard(() async {
      final evmWalletProvider = sl.get<EVMWalletProvider>();

      await sendTransactionWithErrorManagement(
        web3Client!,
        evmWalletProvider.credentials!,
        Transaction(
          to: EthereumAddress.fromHex(htlcContractAddress),
          gasPrice: EtherAmount.fromInt(EtherUnit.gwei, 10),
          maxGas: 500000,
          value: EtherAmount.fromBigInt(EtherUnit.ether, amount),
        ),
        chainId,
      );
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
          function: contractHTLCETH.function('signedWithdraw'),
          parameters: [
            hexToBytes(secret.secret!),
            hexToBytes(secret.secretSignature!.r!),
            hexToBytes(secret.secretSignature!.s!),
            BigInt.from(secret.secretSignature!.v!),
          ],
        );

        final withdrawTx = await sendTransactionWithErrorManagement(
          web3Client!,
          evmWalletProvider.credentials!,
          transactionWithdraw,
          chainId,
        );
        debugPrint('signedWithdrawTx: $withdrawTx');
        return withdrawTx;
      },
    );
  }
}
