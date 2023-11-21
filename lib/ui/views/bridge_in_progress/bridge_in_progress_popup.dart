/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_circular_step_progress_indicator.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_contracts.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_current_step.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_infos_banner.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_infos_header.dart';
import 'package:aebridge/ui/views/bridge_in_progress/components/bridge_in_progress_resume_btn.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/popup_close_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
                  final bridge = ref.watch(BridgeFormProvider.bridgeForm);
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
                              height: 400,
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
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 300,
                                    ),
                                    child: Card(
                                      color: Colors.transparent,
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                      ),
                                      child: WaveWidget(
                                        config: CustomConfig(
                                          gradients: [
                                            [
                                              ArchethicThemeBase.blue800
                                                  .withOpacity(0.1),
                                              ArchethicThemeBase.purple800
                                                  .withOpacity(0.1),
                                            ],
                                            [
                                              ArchethicThemeBase.blue500
                                                  .withOpacity(0.1),
                                              ArchethicThemeBase.purple500
                                                  .withOpacity(0.1),
                                            ],
                                            [
                                              ArchethicThemeBase.blue300
                                                  .withOpacity(0.1),
                                              ArchethicThemeBase.purple300
                                                  .withOpacity(0.1),
                                            ],
                                            [
                                              ArchethicThemeBase.blue200
                                                  .withOpacity(0.1),
                                              ArchethicThemeBase.purple200
                                                  .withOpacity(0.1),
                                            ]
                                          ],
                                          durations: [
                                            35000,
                                            19440,
                                            10800,
                                            6000
                                          ],
                                          heightPercentages: [
                                            0.20,
                                            0.23,
                                            0.25,
                                            0.30,
                                          ],
                                          gradientBegin: Alignment.bottomLeft,
                                          gradientEnd: Alignment.topRight,
                                        ),
                                        size: Size.infinite,
                                        waveAmplitude: 0,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        BridgeInProgressInfosHeader(),
                                        BridgeInProgressCircularStepProgressIndicator(),
                                        BridgeInProgressCurrentStep(),
                                        BridgeInProgressInfosBanner(),
                                        BridgeInProgressContracts(),
                                        Spacer(),
                                        BridgeInProgressResumeBtn(),
                                      ],
                                    ),
                                  ),
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
                                                .bridgeForm.notifier,
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
                                                    .bridgeForm.notifier,
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
