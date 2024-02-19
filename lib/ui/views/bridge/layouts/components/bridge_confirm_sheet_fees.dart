import 'package:aebridge/ui/util/components/fiat_value.dart';
import 'package:aebridge/ui/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeConfirmSheetFees extends ConsumerWidget {
  const BridgeConfirmSheetFees({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SelectableText(
              AppLocalizations.of(context)!.bridgeConfirm_fees_lbl,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Container(
                width: 50,
                height: 1,
                decoration: BoxDecoration(
                  gradient: aedappfm.AppThemeBase.gradient,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 3,
        ),
        _safetyModuleInfos(context, ref),
        const SizedBox(
          height: 10,
        ),
        _archethicProtocolInfos(context, ref),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              AppLocalizations.of(context)!
                  .bridgeConfirm_fees_receive_value_lbl,
            ),
            FutureBuilder<String>(
              future: FiatValue().display(
                ref,
                bridge.tokenToBridge!.targetTokenSymbol,
                bridge.tokenToBridgeReceived,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SelectableText(
                    '${bridge.tokenToBridgeReceived.formatNumber(precision: 8)} ${bridge.tokenToBridge!.targetTokenSymbol} ${snapshot.data}',
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _safetyModuleInfos(
    BuildContext context,
    WidgetRef ref,
  ) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.blockchainFrom!.isArchethic == true) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!
                        .bridgeConfirmEVMSafetyModuleLbl,
                  ),
                  SelectableText(
                    '${bridge.safetyModuleFeesRate}${AppLocalizations.of(context)!.bridgeConfirmFeesSafetyModuleChargeable}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            FutureBuilder<String>(
              future: FiatValue().display(
                ref,
                bridge.safetyModuleSymbol,
                bridge.safetyModuleFees,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SelectableText(
                    '-${bridge.safetyModuleFees.formatNumber()} ${bridge.safetyModuleSymbol} ${snapshot.data}',
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        FormatAddressLinkCopy(
          address: bridge.safetyModuleFeesAddress,
          chainId: bridge.blockchainFrom!.chainId,
          reduceAddress: true,
          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize!,
        ),
      ],
    );
  }

  Widget _archethicProtocolInfos(
    BuildContext context,
    WidgetRef ref,
  ) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!
                        .bridgeConfirmArchethicProtocolLbl,
                  ),
                  if (bridge.blockchainFrom!.isArchethic)
                    SelectableText(
                      '${bridge.archethicProtocolFeesRate}${AppLocalizations.of(context)!.bridgeConfirmFeesAEProtocolSigned}',
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  else
                    SelectableText(
                      '${bridge.archethicProtocolFeesRate}${AppLocalizations.of(context)!.bridgeConfirmFeesAEProtocolChargeable}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            FutureBuilder<String>(
              future: FiatValue().display(
                ref,
                bridge.archethicProtocolSymbol,
                bridge.archethicProtocolFees,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SelectableText(
                    '-${bridge.archethicProtocolFees.formatNumber()} ${bridge.archethicProtocolSymbol} ${snapshot.data}',
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        FormatAddressLinkCopy(
          address: bridge.archethicProtocolFeesAddress,
          chainId: bridge.blockchainFrom!.chainId,
          reduceAddress: true,
          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize!,
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 1,
            child: Container(
              decoration: BoxDecoration(
                gradient: aedappfm.AppThemeBase.gradient,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
