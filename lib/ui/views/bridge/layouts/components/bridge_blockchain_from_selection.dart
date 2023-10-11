/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

import 'package:aebridge/ui/views/blockchain_selection/bloc/provider.dart';
import 'package:aebridge/ui/views/blockchain_selection/blockchain_selection_popup.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class BridgeBlockchainFromSelection extends ConsumerWidget {
  const BridgeBlockchainFromSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.bridge_blockchain_from_lbl,
          ),
        ),
        SizedBox(
          width: min(
            BridgeThemeBase.sizeBoxComponentWidth / 2 - 40,
            MediaQuery.of(context).size.width / 3 - 5,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
              border: Border.all(
                color: Theme.of(context).colorScheme.primaryContainer,
                width: 0.5,
              ),
              gradient: BridgeThemeBase.gradientInputFormBackground,
            ),
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                height: 45,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: bridge.changeDirectionInProgress == true
                      ? const Text('')
                      : bridge.blockchainFrom == null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .btn_selectBlockchain,
                                      style: textTheme.titleMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/bc-logos/${bridge.blockchainFrom!.icon}',
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    bridge.blockchainFrom!.name,
                                    style: textTheme.titleMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                ),
              ),
              onTap: () async {
                final blockchainSelectionNotifier = ref.watch(
                  BlockchainSelectionFormProvider
                      .blockchainSelectionForm.notifier,
                );
                if (bridge.blockchainTo != null &&
                    bridge.blockchainTo!.env != '1-mainnet') {
                  blockchainSelectionNotifier.setTestnetIncluded(true);
                }

                final blockchain = await BlockchainSelectionPopup.getDialog(
                  context,
                  ref,
                );
                if (blockchain == null) return;

                // We want to swap values
                if (bridge.blockchainTo != null &&
                    blockchain.chainId == bridge.blockchainTo!.chainId) {
                  await ref
                      .watch(BridgeFormProvider.bridgeForm.notifier)
                      .swapDirections();
                  return;
                }

                await ref
                    .watch(BridgeFormProvider.bridgeForm.notifier)
                    .setBlockchainFromWithConnection(blockchain);
              },
            ),
          ),
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}
