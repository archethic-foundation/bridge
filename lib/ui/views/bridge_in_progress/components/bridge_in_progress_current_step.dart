/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressCurrentStep extends ConsumerWidget {
  const BridgeInProgressCurrentStep({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.blockchainFrom == null) {
      return const SizedBox(
        height: 30,
      );
    }

    if (bridge.blockchainFrom != null && bridge.blockchainFrom!.isArchethic) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          BridgeArchethicToEVMUseCase()
              .getStepLabel(context, bridge.currentStep),
          style: const TextStyle(fontSize: 11),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          BridgeEVMToArchethicUseCase()
              .getStepLabel(context, bridge.currentStep),
          style: const TextStyle(fontSize: 11),
        ),
      );
    }
  }
}
