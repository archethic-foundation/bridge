import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/fiat_value.dart';
import 'package:aebridge/ui/views/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/util/components/icon_button_animated.dart';
import 'package:aebridge/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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
            Text(
              AppLocalizations.of(context)!.bridgeConfirm_fees_lbl,
            ),
            IconButtonAnimated(
              icon: const Icon(
                Icons.help,
              ),
              onPressed: () {
                launchUrl(
                  Uri.parse(
                    'https://wiki.archethic.net/FAQ/',
                  ),
                );
              },
              color: Colors.white,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Container(
                width: 50,
                height: 1,
                decoration: BoxDecoration(
                  gradient: BridgeThemeBase.gradient,
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
            Text(
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
                  return Text(
                    '${bridge.tokenToBridgeReceived.formatNumber()} ${bridge.tokenToBridge!.targetTokenSymbol} ${snapshot.data}',
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
                  Text(
                    AppLocalizations.of(context)!
                        .bridgeConfirmEVMSafetyModuleLbl,
                  ),
                  Text(
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
                  return Text(
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
                  Text(
                    AppLocalizations.of(context)!
                        .bridgeConfirmArchethicProtocolLbl,
                  ),
                  if (bridge.blockchainFrom!.isArchethic)
                    Text(
                      '${bridge.archethicProtocolFeesRate}${AppLocalizations.of(context)!.bridgeConfirmFeesAEProtocolSigned}',
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  else
                    Text(
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
                  return Text(
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
                gradient: BridgeThemeBase.gradient,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
