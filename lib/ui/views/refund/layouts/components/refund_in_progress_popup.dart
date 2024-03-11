/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/util/components/in_progress_banner.dart';
import 'package:aebridge/ui/util/failure_message.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_circular_step_progress_indicator.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundInProgressPopup {
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
                  final refund = ref.watch(RefundFormProvider.refundForm);
                  return Scaffold(
                    backgroundColor: Colors.transparent.withAlpha(120),
                    body: AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Stack(
                        children: <Widget>[
                          aedappfm.ArchethicScrollbar(
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                                right: 15,
                                left: 8,
                              ),
                              padding: const EdgeInsets.all(20),
                              height: 300,
                              width:
                                  aedappfm.AppThemeBase.sizeBoxComponentWidth,
                              decoration: BoxDecoration(
                                color:
                                    aedappfm.AppThemeBase.backgroundPopupColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const RefundCircularStepProgressIndicator(),
                                  InProgressBanner(
                                    stepLabel: refund.refundInProgress
                                        ? AppLocalizations.of(context)!
                                            .refundProcessInProgress
                                        : '',
                                    infoMessage: refund.walletConfirmation !=
                                            null
                                        ? AppLocalizations.of(context)!
                                            .refundInProgressConfirmEVMWallet
                                        : refund.refundOk == true
                                            ? AppLocalizations.of(context)!
                                                .refundSuccessInfo
                                            : '',
                                    errorMessage: refund.failure != null
                                        ? FailureMessage(
                                            context: context,
                                            failure: refund.failure,
                                          ).getMessage()
                                        : '',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: aedappfm.PopupCloseButton(
                              warningCloseWarning: refund.refundInProgress,
                              warningCloseLabel: refund.refundInProgress == true
                                  ? AppLocalizations.of(context)!
                                      .refundProcessInterruptionWarning
                                  : '',
                              warningCloseFunction: () {
                                ref.read(RefundFormProvider.refundForm.notifier)
                                  ..setRefundTxAddress(null)
                                  ..setRefundInProgress(false)
                                  ..setFailure(null)
                                  ..setRefundOk(false)
                                  ..setWalletConfirmation(null);

                                if (refund.refundInProgress == false) {
                                  ref.read(
                                    RefundFormProvider.refundForm.notifier,
                                  )
                                    ..setContractAddress('')
                                    ..setAmount(0);
                                }
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
