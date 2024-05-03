/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.usecase.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.usecase.dart';
import 'package:aebridge/ui/util/failure_message.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class LocalHistoryCardStatusInfos extends StatelessWidget {
  const LocalHistoryCardStatusInfos({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bridge.failure == null && bridge.currentStep == 8)
            _transferCompleted(context)
          else if (bridge.failure != null &&
                  bridge.failure is aedappfm.UserRejected == true ||
              bridge.failure is aedappfm.FaucetUCUserRejected == true)
            _transferNotCompleted(
              context,
              aedappfm.AppThemeBase.statusInProgress,
              '${AppLocalizations.of(context)!.localHistoryCardStatusInfosTrfInterrupted} ${bridge.currentStep}',
            )
          else
            _transferNotCompleted(
              context,
              aedappfm.AppThemeBase.statusKO,
              '${AppLocalizations.of(context)!.localHistoryCardStatusInfosTrfStopped} ${bridge.currentStep}',
            ),
        ],
      ),
    );
  }

  Widget _transferCompleted(BuildContext context) {
    return Row(
      children: [
        SelectableText(
          '${AppLocalizations.of(context)!.localHistoryStatus}: ',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                  context,
                  Theme.of(context).textTheme.bodyMedium!,
                ),
              ),
        ),
        SelectableText(
          AppLocalizations.of(context)!.localHistoryCardStatusInfosTrfCompleted,
          style: TextStyle(
            color: aedappfm.AppThemeBase.statusOK,
            fontSize: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(
                  fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                    context,
                    Theme.of(context).textTheme.bodyMedium!,
                  ),
                )
                .fontSize,
          ),
        ),
      ],
    );
  }

  Widget _transferNotCompleted(
    BuildContext context,
    Color statusColor,
    String stepText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SelectableText(
              '${AppLocalizations.of(context)!.localHistoryStatus}: ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                      context,
                      Theme.of(context).textTheme.bodyMedium!,
                    ),
                  ),
            ),
            SelectableText(
              stepText,
              style: TextStyle(
                color: statusColor,
                fontSize: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                      fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                        context,
                        Theme.of(context).textTheme.bodyMedium!,
                      ),
                    )
                    .fontSize,
              ),
            ),
            if (bridge.blockchainFrom != null &&
                bridge.blockchainFrom!.isArchethic)
              SelectableText(
                ' (${BridgeArchethicToEVMUseCase().getStepLabel(context, bridge.currentStep)})',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                        context,
                        Theme.of(context).textTheme.bodyMedium!,
                      ),
                    ),
              )
            else
              SelectableText(
                ' (${BridgeEVMToArchethicUseCase().getStepLabel(context, bridge.currentStep)})',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                        context,
                        Theme.of(context).textTheme.bodyMedium!,
                      ),
                    ),
              ),
          ],
        ),
        if (bridge.failure != null)
          SelectableText(
            '${AppLocalizations.of(context)!.localHistoryCause}: ${FailureMessage(
              context: context,
              failure: bridge.failure,
            ).getMessage()}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                    context,
                    Theme.of(context).textTheme.bodyMedium!,
                  ),
                ),
          ),
      ],
    );
  }
}
