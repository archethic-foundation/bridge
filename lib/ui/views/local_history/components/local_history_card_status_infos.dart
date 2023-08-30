/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/usecases/bridge_ae_to_evm.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:aebridge/ui/views/util/failure_message.dart';
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
          if (bridge.failure == null)
            _transferCompleted(context)
          else if (bridge.failure != null &&
              bridge.failure is UserRejected == true)
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
        Text('${AppLocalizations.of(context)!.localHistoryStatus}: '),
        Text(
          'Transfer completed',
          style: TextStyle(color: ThemeBase.statusOK),
        ),
      ],
    );
  }

  Widget _transferInterrupted(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('${AppLocalizations.of(context)!.localHistoryStatus}: '),
            Text(
              'Transfer interrupted at step ${bridge.currentStep}',
              style: TextStyle(
                color: ThemeBase.statusInProgress,
              ),
            ),
            if (bridge.blockchainFrom != null &&
                bridge.blockchainFrom!.isArchethic)
              Text(
                ' (${BridgeArchethicToEVMUseCase().getStepLabel(context, bridge.currentStep)})',
              )
            else
              Text(
                ' (${BridgeEVMToArchethicUseCase().getStepLabel(context, bridge.currentStep)})',
              ),
          ],
        ),
        Text(
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
        Row(
          children: [
            Text('${AppLocalizations.of(context)!.localHistoryStatus}: '),
            Text(
              'Transfer stopped at step ${bridge.currentStep}',
              style: TextStyle(
                color: ThemeBase.statusInProgress,
              ),
            ),
            Text(
              ' (${BridgeArchethicToEVMUseCase().getStepLabel(context, bridge.currentStep)})',
            ),
          ],
        ),
        Text(
          '${AppLocalizations.of(context)!.localHistoryCause}: ${FailureMessage(
            context: context,
            failure: bridge.failure,
          ).getMessage()}',
        ),
      ],
    );
  }
}
