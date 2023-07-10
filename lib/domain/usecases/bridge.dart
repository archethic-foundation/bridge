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

class BridgeseCase {
  Future<void> run(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    final secret = sha256.convert(
      Uint8List.fromList(
        List<int>.generate(
          32,
          (int i) => Random.secure().nextInt(256),
        ),
      ),
    );

    switch (bridge.tokenToBridge!.type) {
      case 'ERC20':
        final contractHTLC = await LPERCContract().deployHTLC(
          bridge.tokenToBridge!.poolAddress,
          '0x$secret',
          BigInt.from(bridge.tokenToBridgeAmount),
          chainId: bridge.blockchainFrom!.chainId,
        );
        await LPERCContract().provisionHTLC(
          contractHTLC,
          BigInt.from(bridge.tokenToBridgeAmount),
          chainId: bridge.blockchainFrom!.chainId,
        );
        break;
      case 'Native':
        await LPETHContract().deployAndProvisionHTLC(
          bridge.tokenToBridge!.poolAddress,
          '0x$secret',
          BigInt.from(bridge.tokenToBridgeAmount),
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
