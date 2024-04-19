/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/util/failure_message.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final refund = ref.watch(RefundFormProvider.refundForm);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: 1,
        totalSteps: 1,
        isProcessInProgress: refund.refundInProgress,
        failure: refund.failure,
      ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: refund.refundInProgress,
        walletConfirmation: refund.walletConfirmation != null,
        failure: refund.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: refund.failure,
        ).getMessage(),
        inProgressTxt: AppLocalizations.of(
          context,
        )!
            .bridgeInProgressWaitConfirmWallet,
        walletConfirmationTxt:
            refund.walletConfirmation == WalletConfirmationRefund.evm
                ? AppLocalizations.of(context)!.bridgeInProgressConfirmEVMWallet
                : AppLocalizations.of(context)!.bridgeInProgressConfirmAEWallet,
        successTxt: AppLocalizations.of(context)!.refundSuccessInfo,
      ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final refund = ref.watch(RefundFormProvider.refundForm);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: refund.refundInProgress,
      warningCloseLabel: refund.refundInProgress == true
          ? AppLocalizations.of(context)!.refundProcessInterruptionWarning
          : '',
      warningCloseFunction: () {
        if (!context.mounted) return;
        Navigator.of(context).pop();
      },
      closeFunction: () {
        ref.invalidate(RefundFormProvider.refundForm);
        if (!context.mounted) return;
        Navigator.of(context).pop();
      },
    );
  }

  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    return aedappfm.InProgressPopup.getDialog(
      context,
      body,
      popupCloseButton,
    );
  }
}
