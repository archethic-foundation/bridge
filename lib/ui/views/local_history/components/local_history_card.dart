import 'package:aebridge/domain/usecases/bridge_ae_to_evm.dart';
import 'package:aebridge/domain/usecases/bridge_evm_to_ae.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:aebridge/ui/views/util/components/blockchain_label.dart';
import 'package:aebridge/ui/views/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/util/generic/formatters.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LocalHistoryCard extends StatelessWidget {
  const LocalHistoryCard({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.background.withOpacity(1),
                Theme.of(context).colorScheme.background.withOpacity(0.3),
              ],
              stops: const [0, 1],
            ),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.background.withOpacity(0.5),
                  Theme.of(context).colorScheme.background.withOpacity(0.7),
                ],
                stops: const [0, 1],
              ),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        DateFormat.yMd(
                          Localizations.localeOf(context).languageCode,
                        ).add_Hms().format(
                              DateTime.fromMillisecondsSinceEpoch(
                                bridge.timestampExec!,
                              ).toLocal(),
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Text('Status:'),
                      ),
                      if (bridge.isTransferInProgress == false)
                        bridge.errorText.isEmpty
                            ? Text(
                                'Transfer ok',
                                style: TextStyle(color: ThemeBase.statutOK),
                              )
                            : Text(
                                'Transfer ko with error ${bridge.errorText}',
                                style: TextStyle(color: ThemeBase.statutKO),
                              )
                      else if (bridge.blockchainFrom!.isArchethic)
                        Row(
                          children: [
                            Text(
                              'Transfer interrupted at step ${bridge.currentStep}',
                              style: TextStyle(
                                color: ThemeBase.statutInProgress,
                              ),
                            ),
                            Text(
                              ' (${BridgeArchethicToEVMUseCase().getStepLabel(context, bridge.currentStep)})',
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Text(
                              'Transfer interrupted at step ${bridge.currentStep}',
                              style: TextStyle(
                                color: ThemeBase.statutInProgress,
                              ),
                            ),
                            Text(
                              ' (${BridgeEVMToArchethicUseCase().getStepLabel(context, bridge.currentStep)})',
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      if (bridge.blockchainFrom != null)
                        BlockchainLabel(
                          chainId: bridge.blockchainFrom!.chainId,
                        ),
                      if (bridge.blockchainFrom != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularStepProgressIndicator(
                                totalSteps:
                                    bridge.blockchainFrom!.isArchethic ? 8 : 6,
                                currentStep: bridge.currentStep,
                                width: 35,
                                height: 35,
                                stepSize: 2,
                                roundedCap: (_, isSelected) => isSelected,
                                gradientColor: bridge.isTransferInProgress ==
                                        false
                                    ? bridge.errorText.isEmpty
                                        ? ThemeBase
                                            .gradientCircularStepProgressIndicatorFinished
                                        : ThemeBase
                                            .gradientCircularStepProgressIndicatorError
                                    : ThemeBase
                                        .gradientCircularStepProgressIndicator,
                                selectedColor: Colors.white,
                                unselectedColor: Colors.white.withOpacity(0.3),
                                removeRoundedCapExtraAngle: true,
                              ),
                              const Icon(
                                Iconsax.arrow_right,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      if (bridge.blockchainTo != null)
                        BlockchainLabel(
                          chainId: bridge.blockchainTo!.chainId,
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (bridge.tokenToBridge != null &&
                      bridge.blockchainTo != null)
                    Row(
                      children: [
                        SelectableText(
                          '${bridge.tokenToBridgeAmount.toString().formatNumber()} ${bridge.tokenToBridge!.symbol} ${AppLocalizations.of(context)!.localHistoryToLbl} ',
                        ),
                        FormatAddressLinkCopy(
                          address: bridge.targetAddress,
                          chainId: bridge.blockchainTo!.chainId,
                          expanded: false,
                        ),
                      ],
                    ),
                  if (bridge.blockchainFrom != null &&
                      bridge.blockchainFrom!.htlcAddress != null &&
                      bridge.blockchainFrom!.htlcAddress!.isNotEmpty)
                    Row(
                      children: [
                        SelectableText(
                          '${bridge.blockchainFrom!.name} ${AppLocalizations.of(context)!.localHistoryContractLbl}:',
                        ),
                        FormatAddressLinkCopy(
                          address: bridge.blockchainFrom!.htlcAddress!,
                          chainId: bridge.blockchainFrom!.chainId,
                          expanded: false,
                        ),
                      ],
                    ),
                  if (bridge.blockchainTo != null &&
                      bridge.blockchainTo!.htlcAddress != null &&
                      bridge.blockchainTo!.htlcAddress!.isNotEmpty)
                    Row(
                      children: [
                        SelectableText(
                          '${bridge.blockchainTo!.name} ${AppLocalizations.of(context)!.localHistoryContractLbl}:',
                        ),
                        FormatAddressLinkCopy(
                          address: bridge.blockchainTo!.htlcAddress!,
                          chainId: bridge.blockchainTo!.chainId,
                          expanded: false,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
