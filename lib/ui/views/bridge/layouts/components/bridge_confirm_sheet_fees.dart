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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.bridgeConfirmEVMSafetyModuleLbl,
                ),
                Text(
                  '${bridge.safetyModuleFeesRate}% of the initial amount',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
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
                    '-${bridge.safetyModuleFees.toStringAsFixed(2).formatNumber()} ${bridge.safetyModuleSymbol} ${snapshot.data}',
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        FormatAddressLinkCopy(
          address: bridge.safetyModuleFeesAddress,
          chainId: bridge.blockchainFrom!.chainId,
          expanded: false,
          reduceAddress: true,
          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize!,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .bridgeConfirmArchethicProtocolLbl,
                ),
                Text(
                  '${bridge.archethicProtocolFeesRate}% of the remaining amount after the Safety module fee',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
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
                    '-${bridge.archethicProtocolFees.toStringAsFixed(2).formatNumber()} ${bridge.archethicProtocolSymbol} ${snapshot.data}',
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        FormatAddressLinkCopy(
          address: bridge.archethicProtocolFeesAddress,
          chainId: bridge.blockchainFrom!.chainId,
          expanded: false,
          reduceAddress: true,
          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize!,
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
                    '${bridge.tokenToBridgeReceived} ${bridge.tokenToBridge!.targetTokenSymbol} ${snapshot.data}',
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ],
    );
  }
}