/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.usecase.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.usecase.dart';
import 'package:aebridge/ui/util/failure_message.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_final_amount.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_in_progress_contracts.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    return [
      aedappfm.InProgressCircularStepProgressIndicator(
        currentStep: bridge.currentStep,
        totalSteps: 8,
        isProcessInProgress: bridge.isTransferInProgress,
        failure: bridge.failure,
      ),
      if (bridge.blockchainFrom != null && bridge.blockchainFrom!.isArchethic)
        aedappfm.InProgressCurrentStep(
          steplabel: BridgeArchethicToEVMUseCase().getAEStepLabel(
            context,
            bridge.currentStep,
          ),
        )
      else
        aedappfm.InProgressCurrentStep(
          steplabel: BridgeEVMToArchethicUseCase().getEVMStepLabel(
            context,
            bridge.currentStep,
          ),
        ),
      aedappfm.InProgressInfosBanner(
        isProcessInProgress: bridge.isTransferInProgress,
        walletConfirmation: bridge.walletConfirmation != null,
        failure: bridge.failure,
        failureMessage: FailureMessage(
          context: context,
          failure: bridge.failure,
        ).getMessage(),
        inProgressTxt: AppLocalizations.of(
          context,
        )!
            .bridgeInProgressWaitConfirmWallet,
        walletConfirmationTxt: bridge.walletConfirmation ==
                WalletConfirmation.archethic
            ? AppLocalizations.of(context)!.bridgeInProgressConfirmAEWallet
            : AppLocalizations.of(context)!.bridgeInProgressConfirmEVMWallet,
        successTxt: AppLocalizations.of(context)!.bridgeSuccessInfo,
      ),
      const BridgeInProgressContracts(),
      if (bridge.htlcAEAddress != null &&
          bridge.bridgeOk &&
          bridge.blockchainFrom != null)
        BridgeFinalAmount(
          directionAEToEVM: bridge.blockchainFrom!.isArchethic,
          address: bridge.blockchainFrom!.isArchethic
              ? bridge.htlcEVMAddress!
              : bridge.htlcAEAddress!,
          isUCO: bridge.tokenToBridge!.targetTokenSymbol.toUpperCase() == 'UCO',
          to: bridge.targetAddress,
          chainId: bridge.blockchainFrom!.isArchethic
              ? bridge.blockchainTo!.chainId
              : null,
          providerEndpoint: bridge.blockchainFrom!.isArchethic
              ? bridge.blockchainTo!.providerEndpoint
              : null,
        ),
      const Spacer(),
      aedappfm.InProgressResumeBtn(
        currentStep: bridge.currentStep,
        isProcessInProgress: bridge.isTransferInProgress,
        onPressed: () async {
          ref
              .read(
                BridgeFormProvider.bridgeForm.notifier,
              )
              .setResumeProcess(true);

          if (!context.mounted) return;
          await ref
              .read(
                BridgeFormProvider.bridgeForm.notifier,
              )
              .bridge(context, ref);
        },
        failure: bridge.failure,
      ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: bridge.isTransferInProgress,
      warningCloseLabel: bridge.isTransferInProgress == true
          ? AppLocalizations.of(context)!.bridgeProcessInterruptionWarning
          : '',
      warningCloseFunction: () async {
        final bridgeNotifier = ref.read(
          BridgeFormProvider.bridgeForm.notifier,
        );
        if (bridge.failure == null && bridge.isTransferInProgress) {
          await bridgeNotifier.setFailure(
            const aedappfm.Failure.userRejected(),
          );
        }

        bridgeNotifier.initState();
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
