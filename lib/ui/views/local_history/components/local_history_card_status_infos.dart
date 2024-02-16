/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.usecase.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.usecase.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';

import 'package:aebridge/ui/views/util/failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
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
              bridge.failure is aedappfm.UserRejected == true)
            _transferInterrupted(context)
          else
            _transferError(context),
        ],
      ),
    );
  }

  Widget _transferCompleted(BuildContext context) {
    return Row(
      children: [
        SelectableText('${AppLocalizations.of(context)!.localHistoryStatus}: '),
        SelectableText(
          'Transfer completed',
          style: TextStyle(color: aedappfm.AppThemeBase.statusOK),
        ),
      ],
    );
  }

  Widget _transferInterrupted(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SelectableText(
              '${AppLocalizations.of(context)!.localHistoryStatus}: ',
            ),
            SelectableText(
              'Transfer interrupted at step ${bridge.currentStep}',
              style: TextStyle(
                color: aedappfm.AppThemeBase.statusInProgress,
              ),
            ),
            if (bridge.blockchainFrom != null &&
                bridge.blockchainFrom!.isArchethic)
              SelectableText(
                ' (${BridgeArchethicToEVMUseCase().getStepLabel(context, bridge.currentStep)})',
              )
            else
              SelectableText(
                ' (${BridgeEVMToArchethicUseCase().getStepLabel(context, bridge.currentStep)})',
              ),
          ],
        ),
        if (bridge.failure != null)
          SelectableText(
            '${AppLocalizations.of(context)!.localHistoryCause}: ${FailureMessage(
              context: context,
              failure: bridge.failure,
            ).getMessage()}',
          ),
      ],
    );
  }

  Widget _transferError(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SelectableText(
              '${AppLocalizations.of(context)!.localHistoryStatus}: ',
            ),
            SelectableText(
              'Transfer stopped at step ${bridge.currentStep}',
              style: TextStyle(color: aedappfm.AppThemeBase.statusKO),
            ),
            SelectableText(
              ' (${BridgeArchethicToEVMUseCase().getStepLabel(context, bridge.currentStep)})',
            ),
          ],
        ),
        if (bridge.failure != null)
          SelectableText(
            '${AppLocalizations.of(context)!.localHistoryCause}: ${FailureMessage(
              context: context,
              failure: bridge.failure,
            ).getMessage()}',
          ),
      ],
    );
  }
}
