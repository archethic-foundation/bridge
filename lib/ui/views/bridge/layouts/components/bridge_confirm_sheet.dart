/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_back_btn.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_btn.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:aebridge/ui/views/util/components/blockchain_label.dart';
import 'package:aebridge/ui/views/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/util/components/icon_button_animated.dart';
import 'package:aebridge/ui/views/util/components/scrollbar.dart';
import 'package:aebridge/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:url_launcher/url_launcher.dart';

class BridgeConfirmSheet extends ConsumerWidget {
  const BridgeConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 5,
            right: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/background-mainscreen.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: 650,
          height: 500,
          decoration: BoxDecoration(
            gradient: ThemeBase.gradientSheetBackground,
            border: GradientBoxBorder(
              gradient: ThemeBase.gradientSheetBorder,
            ),
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/background-sheet.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: ArchethicScrollbar(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: SelectionArea(
                          child: Text(
                            AppLocalizations.of(context)!.bridgeConfirmTitle,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 50,
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: ThemeBase.gradient,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .bridge_blockchain_from_lbl,
                          ),
                          BlockchainLabel(
                            chainId: bridge.blockchainFrom!.chainId,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .bridge_blockchain_to_lbl,
                          ),
                          BlockchainLabel(
                            chainId: bridge.blockchainTo!.chainId,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .bridge_token_amount_lbl,
                          ),
                          Text(
                            '${bridge.tokenToBridgeAmount.toString().formatNumber()} ${bridge.tokenToBridge!.symbol}',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (bridge.targetAddress.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .bridge_target_address_lbl,
                            ),
                            FormatAddressLinkCopy(
                              address: bridge.targetAddress,
                              chainId: bridge.blockchainTo!.chainId,
                            ),
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: ThemeBase.gradient,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.bridgeConfirm_fees_lbl,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .bridgeConfirm_fees_bridge_fee_lbl,
                            ),
                          ),
                          const Text('0.1 ETH'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .bridgeConfirm_fees_receive_value_lbl,
                            ),
                          ),
                          const Text('0.9 ETH'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .bridgeConfirm_fees_help_lbl,
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
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const BridgeConfirmButton(),
                      const SizedBox(
                        height: 10,
                      ),
                      const BridgeConfirmBackButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
