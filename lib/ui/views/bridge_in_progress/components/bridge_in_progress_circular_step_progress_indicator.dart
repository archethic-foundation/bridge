/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
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
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Align(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularStepProgressIndicator(
              totalSteps: bridge.blockchainFrom!.isArchethic ? 8 : 6,
              currentStep: bridge.currentStep,
              width: 50,
              height: 50,
              roundedCap: (_, isSelected) => isSelected,
              gradientColor: bridge.isTransferInProgress == false
                  ? bridge.errorText.isEmpty
                      ? ThemeBase.gradientCircularStepProgressIndicatorFinished
                      : ThemeBase.gradientCircularStepProgressIndicatorError
                  : ThemeBase.gradientCircularStepProgressIndicator,
              selectedColor: Colors.white,
              unselectedColor: Colors.transparent,
              removeRoundedCapExtraAngle: true,
            ),
            if (bridge.isTransferInProgress)
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: Colors.white.withOpacity(0.2),
                  strokeWidth: 1,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
