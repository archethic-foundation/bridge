/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_circular_step_progress_indicator.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_contracts.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_current_step.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_error.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_infos.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_resume_btn.dart';
import 'package:aebridge/ui/views/util/components/popup_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressPopup {
  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return PopupTemplate(
          popupTitle: '',
          popupHeight: 500,
          popupContent: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BridgeInProgressInfos(),
              BridgeInProgressCircularStepProgressIndicator(),
              BridgeInProgressCurrentStep(),
              BridgeInProgressError(),
              BridgeInProgressContracts(),
              Spacer(),
              BridgeInProgressResumeBtn(),
            ],
          ),
          warningCloseButton: true,
          warningCloseLabel:
              AppLocalizations.of(context)!.bridgeProcessInterruptionWarning,
          warningCloseFunction: () async {
            await ref
                .read(BridgeFormProvider.bridgeForm.notifier)
                .setFailure(const Failure.userRejected());
          },
        );
      },
    );
  }
}
