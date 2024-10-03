/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.usecase.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.usecase.dart';
import 'package:aebridge/ui/util/components/blockchain_label.dart';
import 'package:aebridge/ui/util/failure_message.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_chainid_updated.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_final_amount.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_in_progress_contracts.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_in_progress_user_explorer.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_interrup_info.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressPopup {
  static List<Widget> body(
    BuildContext context,
    WidgetRef ref,
  ) {
    final bridge = ref.watch(bridgeFormNotifierProvider);
    final dappClient = aedappfm.sl.get<awc.ArchethicDAppClient>();
    return [
      const BridgeChainIdUpdated(),
      if (bridge.isTransferInProgress)
        Text(
          AppLocalizations.of(context)!.bridgeInProgressPopupHeader,
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (bridge.blockchainFrom != null)
            BlockchainLabel(
              chainId: bridge.blockchainFrom!.chainId,
            ),
          if (bridge.blockchainFrom != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: aedappfm.InProgressCircularStepProgressIndicator(
                totalSteps: 8,
                currentStep: bridge.currentStep,
                isProcessInProgress: bridge.isTransferInProgress,
                failure: bridge.failure,
                icon: aedappfm.Iconsax.arrow_right,
              ),
            ),
          if (bridge.blockchainTo != null)
            BlockchainLabel(
              chainId: bridge.blockchainTo!.chainId,
            ),
        ],
      ),
      if (bridge.blockchainFrom != null && bridge.blockchainFrom!.isArchethic)
        aedappfm.InProgressCurrentStep(
          steplabel: BridgeArchethicToEVMUseCase(dappClient: dappClient)
              .getAEStepLabel(
            AppLocalizations.of(context)!,
            bridge.currentStep,
          ),
        )
      else
        aedappfm.InProgressCurrentStep(
          steplabel: BridgeEVMToArchethicUseCase().getEVMStepLabel(
            AppLocalizations.of(context)!,
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
        inProgressTxt: bridge.requestTooLong
            ? AppLocalizations.of(
                context,
              )!
                .requestTooLong
            : AppLocalizations.of(
                context,
              )!
                .bridgeInProgressWaitConfirmWallet,
        walletConfirmationTxt: bridge.walletConfirmation ==
                WalletConfirmation.archethic
            ? AppLocalizations.of(context)!.bridgeInProgressConfirmAEWallet
            : AppLocalizations.of(context)!.bridgeInProgressConfirmEVMWallet,
        successTxt: AppLocalizations.of(context)!.bridgeSuccessInfo,
      ),
      const BridgeInProgressUserExplorer(),
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
          decimal: bridge.tokenBridgedDecimals,
          to: bridge.targetAddress,
          chainId: bridge.blockchainFrom!.isArchethic
              ? bridge.blockchainTo!.chainId
              : null,
        ),
      const BridgeInterrupInfo(),
      const Spacer(),
      aedappfm.InProgressResumeBtn(
        currentStep: bridge.currentStep,
        isProcessInProgress: bridge.isTransferInProgress,
        onPressed: () async {
          ref
              .read(
                bridgeFormNotifierProvider.notifier,
              )
              .setResumeProcess(true);

          if (!context.mounted) return;
          await ref
              .read(
                bridgeFormNotifierProvider.notifier,
              )
              .bridge(AppLocalizations.of(context)!, ref);
        },
        failure: bridge.failure,
      ),
    ];
  }

  static aedappfm.PopupCloseButton popupCloseButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    final bridge = ref.watch(bridgeFormNotifierProvider);
    return aedappfm.PopupCloseButton(
      warningCloseWarning: bridge.isTransferInProgress,
      warningCloseLabel: bridge.isTransferInProgress == true
          ? AppLocalizations.of(context)!.bridgeProcessInterruptionWarning
          : '',
      warningCloseFunction: () async {
        final bridgeNotifier = ref.read(
          bridgeFormNotifierProvider.notifier,
        );
        if (bridge.failure == null && bridge.isTransferInProgress) {
          await bridgeNotifier.setFailure(
            const aedappfm.Failure.userRejected(),
          );
        }
        ref.invalidate(
          bridgeFormNotifierProvider,
        );
        if (!context.mounted) return;
        Navigator.of(context).pop();
      },
      closeFunction: () {
        ref.invalidate(
          bridgeFormNotifierProvider,
        );
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
      height: 450,
    );
  }
}
