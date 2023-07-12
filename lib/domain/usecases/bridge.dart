/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:math';

import 'package:aebridge/model/contracts/lp_erc_contract.dart';
import 'package:aebridge/model/contracts/lp_eth_contract.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webthree/crypto.dart';

class BridgeUseCase {
  Future<void> run(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    final secret = Uint8List.fromList(
      List<int>.generate(
        32,
        (int i) => Random.secure().nextInt(256),
      ),
    );
    final secretHex = '0x${bytesToHex(secret)}';
    final hash = sha256.convert(
      secret,
    );
    debugPrint('secret: $secretHex');
    debugPrint('type token: ${bridge.tokenToBridge!.type}');
    debugPrint('poolAddress: ${bridge.tokenToBridge!.poolAddress}');

    switch (bridge.tokenToBridge!.type) {
      case 'ERC20':
        final htlcContract = await LPERCContract().deployAndProvisionHTLC(
          bridge.tokenToBridge!.poolAddress,
          hash.toString(),
          BigInt.from(bridge.tokenToBridgeAmount),
          chainId: bridge.blockchainFrom!.chainId,
        );
        if (htlcContract == null) {
          return;
        }
        await LPERCContract().withdraw(
          htlcContract,
          secretHex,
          chainId: bridge.blockchainFrom!.chainId,
        );
        break;
      case 'Native':
        final htlcContract = await LPETHContract().deployAndProvisionHTLC(
          bridge.tokenToBridge!.poolAddress,
          hash.toString(),
          BigInt.from(bridge.tokenToBridgeAmount),
          chainId: bridge.blockchainFrom!.chainId,
        );
        if (htlcContract == null) {
          return;
        }
        await LPETHContract().withdraw(
          htlcContract,
          secretHex,
          chainId: bridge.blockchainFrom!.chainId,
        );

        break;
      case 'Wrapped':
        break;
      default:
        throw Exception('Unknown token type.');
    }
  }
}
