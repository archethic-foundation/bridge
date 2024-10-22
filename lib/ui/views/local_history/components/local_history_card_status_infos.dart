/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/app_mobile_format.dart';
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.usecase.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.usecase.dart';
import 'package:aebridge/ui/util/failure_message.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistoryCardStatusInfos extends ConsumerWidget {
  const LocalHistoryCardStatusInfos({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bridge.failure == null && bridge.currentStep == 8)
            _transferCompleted(
              context,
              ref,
            )
          else if (bridge.failure != null &&
                  bridge.failure is aedappfm.UserRejected == true ||
              bridge.failure is aedappfm.FaucetUCUserRejected == true)
            _transferNotCompleted(
              context,
              ref,
              aedappfm.AppThemeBase.statusInProgress,
              '${AppLocalizations.of(context)!.localHistoryCardStatusInfosTrfInterrupted} ${bridge.currentStep}',
            )
          else
            _transferNotCompleted(
              context,
              ref,
              aedappfm.AppThemeBase.statusKO,
              '${AppLocalizations.of(context)!.localHistoryCardStatusInfosTrfStopped} ${bridge.currentStep}',
            ),
        ],
      ),
    );
  }

  Widget _transferCompleted(BuildContext context, WidgetRef ref) {
    final isAppMobileFormat = ref.watch(isAppMobileFormatProvider(context));
    return Row(
      children: [
        SelectableText(
          '${AppLocalizations.of(context)!.localHistoryStatus}: ',
          style: isAppMobileFormat
              ? Theme.of(context).textTheme.bodyMedium
              : Theme.of(context).textTheme.bodyMedium!.copyWith(
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
            fontSize: isAppMobileFormat
                ? Theme.of(context).textTheme.bodyMedium!.fontSize
                : Theme.of(context)
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
    WidgetRef ref,
    Color statusColor,
    String stepText,
  ) {
    final isAppMobileFormat = ref.watch(isAppMobileFormatProvider(context));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SelectableText(
              '${AppLocalizations.of(context)!.localHistoryStatus}: ',
              style: isAppMobileFormat
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                fontSize: isAppMobileFormat
                    ? Theme.of(context).textTheme.bodyMedium!.fontSize
                    : Theme.of(context)
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
                ' (${BridgeArchethicToEVMUseCase().getStepLabel(AppLocalizations.of(context)!, bridge.currentStep)})',
                style: isAppMobileFormat
                    ? Theme.of(context).textTheme.bodyMedium
                    : Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.bodyMedium!,
                          ),
                        ),
              )
            else
              SelectableText(
                ' (${BridgeEVMToArchethicUseCase().getStepLabel(AppLocalizations.of(context)!, bridge.currentStep)})',
                style: isAppMobileFormat
                    ? Theme.of(context).textTheme.bodyMedium
                    : Theme.of(context).textTheme.bodyMedium!.copyWith(
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
            style: isAppMobileFormat
                ? Theme.of(context).textTheme.bodyMedium
                : Theme.of(context).textTheme.bodyMedium!.copyWith(
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
