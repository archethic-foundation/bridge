/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/refund/bloc/provider.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RefundCircularStepProgressIndicator extends ConsumerWidget {
  const RefundCircularStepProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refund = ref.watch(RefundFormProvider.refundForm);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Align(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularStepProgressIndicator(
              totalSteps: 1,
              currentStep: 1,
              width: 35,
              height: 35,
              stepSize: 2,
              roundedCap: (_, isSelected) => isSelected,
              gradientColor: refund.refundInProgress == false
                  ? refund.failure == null
                      ? aedappfm.AppThemeBase
                          .gradientCircularStepProgressIndicatorFinished
                      : aedappfm.AppThemeBase
                          .gradientCircularStepProgressIndicatorError
                  : aedappfm.AppThemeBase.gradientCircularStepProgressIndicator,
              selectedColor: Colors.white,
              unselectedColor: Colors.white.withOpacity(0.2),
              removeRoundedCapExtraAngle: true,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                if (refund.refundInProgress)
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white.withOpacity(0.2),
                      strokeWidth: 1,
                    ),
                  ),
                const Icon(
                  aedappfm.Iconsax.timer,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
