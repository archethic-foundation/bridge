/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:aebridge/ui/views/util/components/blockchain_label.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BridgeInProgressCircularStepProgressIndicator extends ConsumerWidget {
  const BridgeInProgressCircularStepProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.blockchainFrom == null) {
      return const SizedBox();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (bridge.blockchainFrom != null)
          BlockchainLabel(
            chainId: bridge.blockchainFrom!.chainId,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Align(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularStepProgressIndicator(
                  totalSteps: bridge.blockchainFrom!.isArchethic ? 8 : 6,
                  currentStep: bridge.currentStep,
                  width: 35,
                  height: 35,
                  stepSize: 2,
                  roundedCap: (_, isSelected) => isSelected,
                  gradientColor: bridge.isTransferInProgress == false
                      ? bridge.failure == null
                          ? ThemeBase
                              .gradientCircularStepProgressIndicatorFinished
                          : ThemeBase.gradientCircularStepProgressIndicatorError
                      : ThemeBase.gradientCircularStepProgressIndicator,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.white.withOpacity(0.2),
                  removeRoundedCapExtraAngle: true,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (bridge.isTransferInProgress)
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: Colors.white.withOpacity(0.2),
                          strokeWidth: 1,
                        ),
                      ),
                    const Icon(
                      Iconsax.arrow_right,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (bridge.blockchainTo != null)
          BlockchainLabel(
            chainId: bridge.blockchainTo!.chainId,
          ),
      ],
    );
  }
}
