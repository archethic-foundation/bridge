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

class EVMLPERC with EVMBridgeProcessMixin {
  EVMLPERC(this.providerEndpoint);

  String? providerEndpoint;

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

        final contractDummyToken =
            await getDeployedContract(contractNameIERC20, tokenAddress);

        final transactionTransfer = Transaction.callContract(
          contract: contractDummyToken,
          function: contractDummyToken.function('transfer'),
          parameters: [
            EthereumAddress.fromHex(htlcContractAddress),
            EtherAmount.fromBigInt(EtherUnit.ether, amount).getInWei,
          ],
        );

        await sendTransactionWithErrorManagement(
          web3Client,
          evmWalletProvider.credentials!,
          transactionTransfer,
          chainId,
        );
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

        final contractHTLCERC = await getDeployedContract(
          contractNameSignedHTLCERC,
          htlcContractAddress,
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

        final withdrawTx = await sendTransactionWithErrorManagement(
          web3Client,
          evmWalletProvider.credentials!,
          transactionWithdraw,
          chainId,
        );
        debugPrint('signedWithdrawTx: $withdrawTx');
        return withdrawTx;
      },
    );
  }

  Future<Result<double, Failure>> getFee(
    String htlcContractAddress,
  ) async {
    return Result.guard(
      () async {
        final web3Client = Web3Client(providerEndpoint!, Client());

        final contractHTLC = await getDeployedContract(
          contractNameChargeableHTLCERC,
          htlcContractAddress,
        );

        final feeMap = await web3Client.call(
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
}