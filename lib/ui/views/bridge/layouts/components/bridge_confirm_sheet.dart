import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_back_btn.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_btn.dart';
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
            border: const GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  Color(0x003C89B9),
                  Color(0xFFCC00FF),
                ],
                stops: [0, 1],
              ),
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
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0x003C89B9),
                                Color(0xFFCC00FF),
                              ],
                              stops: [0, 1],
                              begin: AlignmentDirectional.centerEnd,
                              end: AlignmentDirectional.centerStart,
                            ),
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
                                height: 15,
                              ),
                              const SizedBox(
                                width: 5,
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
                                height: 15,
                              ),
                              const SizedBox(
                                width: 5,
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
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Fees'),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Bridge Fee'),
                          ),
                          Text('0.1 ETH'),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('You will receive'),
                          ),
                          Text('0.9 ETH'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            const Text('How does the bridge fee work?'),
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
                        height: 20,
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
