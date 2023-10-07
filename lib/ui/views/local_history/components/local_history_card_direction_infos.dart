/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/blockchain_label.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LocalHistoryCardDirectionInfos extends StatelessWidget {
  const LocalHistoryCardDirectionInfos({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return _buildSmallDisplay(context, bridge);
    }
    return _buildDisplay(context, bridge);
  }
}

Widget _buildDisplay(BuildContext context, BridgeFormState bridge) {
  return Row(
    children: [
      if (bridge.blockchainFrom != null)
        BlockchainLabel(
          chainId: bridge.blockchainFrom!.chainId,
        ),
      if (bridge.blockchainFrom != null)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        ? BridgeThemeBase
                            .gradientCircularStepProgressIndicatorFinished
                        : bridge.failure is UserRejected
                            ? BridgeThemeBase
                                .gradientCircularStepProgressIndicator
                            : BridgeThemeBase
                                .gradientCircularStepProgressIndicatorError
                    : BridgeThemeBase.gradientCircularStepProgressIndicator,
                selectedColor: Colors.white,
                unselectedColor: Colors.white.withOpacity(0.3),
                removeRoundedCapExtraAngle: true,
              ),
              const Icon(
                Iconsax.arrow_right,
                size: 16,
              ),
            ],
          ),
        ),
      if (bridge.blockchainTo != null)
        BlockchainLabel(
          chainId: bridge.blockchainTo!.chainId,
        ),
    ],
  );
}

Widget _buildSmallDisplay(BuildContext context, BridgeFormState bridge) {
  return Align(
    child: Column(
      children: [
        if (bridge.blockchainFrom != null)
          BlockchainLabel(
            chainId: bridge.blockchainFrom!.chainId,
          ),
        if (bridge.blockchainFrom != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          ? BridgeThemeBase
                              .gradientCircularStepProgressIndicatorFinished
                          : bridge.failure is UserRejected
                              ? BridgeThemeBase
                                  .gradientCircularStepProgressIndicator
                              : BridgeThemeBase
                                  .gradientCircularStepProgressIndicatorError
                      : BridgeThemeBase.gradientCircularStepProgressIndicator,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.white.withOpacity(0.3),
                  removeRoundedCapExtraAngle: true,
                ),
                const Icon(
                  Iconsax.arrow_square_down,
                  size: 16,
                ),
              ],
            ),
          ),
        if (bridge.blockchainTo != null)
          BlockchainLabel(
            chainId: bridge.blockchainTo!.chainId,
          ),
      ],
    ),
  );
}
