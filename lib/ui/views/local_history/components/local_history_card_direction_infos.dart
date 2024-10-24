/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aebridge/ui/util/components/blockchain_label.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LocalHistoryCardDirectionInfos extends ConsumerWidget {
  const LocalHistoryCardDirectionInfos({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAppMobileFormat = aedappfm.Responsive.isMobile(context);

    if (isAppMobileFormat) {
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
                totalSteps: 8,
                currentStep: bridge.currentStep,
                width: 35,
                height: 35,
                stepSize: 2,
                roundedCap: (_, isSelected) => isSelected,
                gradientColor: bridge.isTransferInProgress == false
                    ? bridge.failure == null
                        ? aedappfm.AppThemeBase
                            .gradientCircularStepProgressIndicatorFinished
                        : bridge.failure is aedappfm.UserRejected
                            ? aedappfm.AppThemeBase
                                .gradientCircularStepProgressIndicator
                            : aedappfm.AppThemeBase
                                .gradientCircularStepProgressIndicatorError
                    : aedappfm
                        .AppThemeBase.gradientCircularStepProgressIndicator,
                selectedColor: Colors.white,
                unselectedColor: Colors.white.withOpacity(0.3),
                removeRoundedCapExtraAngle: true,
              ),
              const Icon(
                aedappfm.Iconsax.arrow_right,
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
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Align(
      child: Column(
        children: [
          if (bridge.blockchainFrom != null)
            BlockchainLabel(
              chainId: bridge.blockchainFrom!.chainId,
            ),
          if (bridge.blockchainFrom != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularStepProgressIndicator(
                    totalSteps: 8,
                    currentStep: bridge.currentStep,
                    width: 35,
                    height: 35,
                    stepSize: 2,
                    roundedCap: (_, isSelected) => isSelected,
                    gradientColor: bridge.isTransferInProgress == false
                        ? bridge.failure == null
                            ? aedappfm.AppThemeBase
                                .gradientCircularStepProgressIndicatorFinished
                            : bridge.failure is aedappfm.UserRejected
                                ? aedappfm.AppThemeBase
                                    .gradientCircularStepProgressIndicator
                                : aedappfm.AppThemeBase
                                    .gradientCircularStepProgressIndicatorError
                        : aedappfm
                            .AppThemeBase.gradientCircularStepProgressIndicator,
                    selectedColor: Colors.white,
                    unselectedColor: Colors.white.withOpacity(0.3),
                    removeRoundedCapExtraAngle: true,
                  ),
                  const Icon(
                    aedappfm.Iconsax.arrow_square_down,
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
    ),
  );
}
