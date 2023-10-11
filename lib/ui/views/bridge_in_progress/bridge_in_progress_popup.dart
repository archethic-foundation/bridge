/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_circular_step_progress_indicator.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_contracts.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_current_step.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_error.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_infos.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_resume_btn.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/popup_close_button.dart';
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
        return ScaffoldMessenger(
          child: Builder(
            builder: (context) {
              return Consumer(
                builder: (context, ref, _) {
                  final bridge = ref.watch(BridgeFormProvider.newBridgeForm);
                  return Scaffold(
                    backgroundColor: Colors.transparent.withAlpha(120),
                    body: AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Stack(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                                right: 15,
                                left: 8,
                              ),
                              padding: const EdgeInsets.all(20),
                              height: 500,
                              width: BridgeThemeBase.sizeBoxComponentWidth,
                              decoration: BoxDecoration(
                                color: BridgeThemeBase.backgroundPopupColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                              child: const Column(
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
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: PopupCloseButton(
                              warningCloseWarning: bridge.isTransferInProgress,
                              warningCloseLabel:
                                  bridge.isTransferInProgress == true
                                      ? AppLocalizations.of(context)!
                                          .bridgeProcessInterruptionWarning
                                      : '',
                              warningCloseFunction:
                                  bridge.isTransferInProgress == true
                                      ? () async {
                                          final bridgeNotifier = ref.read(
                                            BridgeFormProvider
                                                .newBridgeForm.notifier,
                                          );
                                          await bridgeNotifier.setFailure(
                                            const Failure.userRejected(),
                                          );

                                          bridgeNotifier.initState();
                                        }
                                      : () async {
                                          ref
                                              .read(
                                                BridgeFormProvider
                                                    .newBridgeForm.notifier,
                                              )
                                              .initState();
                                        },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
