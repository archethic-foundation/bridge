/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_back_btn.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_btn.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:aebridge/ui/views/util/components/icon_button_animated.dart';
import 'package:aebridge/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
            border: GradientBoxBorder(
              gradient: ThemeBase.gradient,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Container(
          width: 550,
          height: 550,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.background.withOpacity(0.9),
                Theme.of(context).colorScheme.background.withOpacity(0.2),
              ],
              stops: const [0, 1],
            ),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.background.withOpacity(0.7),
                  Theme.of(context).colorScheme.background.withOpacity(1),
                ],
                stops: const [0, 1],
              ),
            ),
            borderRadius: BorderRadius.circular(12),
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
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/bc-logos/${bridge.blockchainFrom!.icon}',
                                width: 15,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                bridge.blockchainFrom!.name,
                              ),
                            ],
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
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/bc-logos/${bridge.blockchainTo!.icon}',
                                width: 15,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                bridge.blockchainTo!.name,
                              ),
                            ],
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
                            '${bridge.tokenToBridgeAmount} ${bridge.tokenToBridge!.symbol}',
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
                            Text(
                              bridge.targetAddress,
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      const Divider(),
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
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
