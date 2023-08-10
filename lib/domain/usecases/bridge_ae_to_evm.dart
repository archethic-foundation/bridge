/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeArchethicToEVMUseCase {
  Future<void> run(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    final session = ref.read(SessionProviders.session);
    final walletFrom = session.walletFrom;
    const poolAddress =
        '0000852ddc39fa27c7972c65f2d00de1de0b5fc225722d52d0708354c3fdea7b7fec';
    var endTime =
        DateTime.now().add(const Duration(minutes: 720)).millisecondsSinceEpoch;
    endTime = DateUtil().roundToNearestMinute(endTime) ~/ 1000;

    final htlcContract = await ArchethicContract().deploySignedHTLC(
      poolAddress,
      walletFrom!.genesisAddress,
      endTime,
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridge!.tokenAddress,
    );

    debugPrint('htlc contract: $htlcContract');
    // Get Pool's secret

    switch (bridge.tokenToBridge!.type) {
      case 'ERC20':
        break;
      case 'Native':
        break;
      case 'Wrapped':
        break;
      default:
        throw Exception('Unknown token type.');
    }
  }
}
