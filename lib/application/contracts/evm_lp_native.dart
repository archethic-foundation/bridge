/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/usecases/evm_mixin.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:http/http.dart';
import 'package:webthree/webthree.dart';

class EVMLPNative with EVMBridgeProcessMixin {
  EVMLPNative(this.providerEndpoint);

  String? providerEndpoint;

  Future<Result<void, Failure>> provisionChargeableHTLC(
    BigInt amount,
    String htlcContractAddress, {
    int chainId = 1337,
  }) async {
    return Result.guard(() async {
      final evmWalletProvider = sl.get<EVMWalletProvider>();
      final web3Client = Web3Client(providerEndpoint!, Client());

      await sendTransactionWithErrorManagement(
        web3Client,
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
}
