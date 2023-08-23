/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/blockchain_selection/bloc/provider.dart';
import 'package:aebridge/ui/views/blockchain_selection/blockchain_selection_popup.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class BridgeBlockchainToSelection extends ConsumerWidget {
  const BridgeBlockchainToSelection({
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
            AppLocalizations.of(context)!.bridge_blockchain_to_lbl,
          ),
        ),
        SizedBox(
          width: ThemeBase.sizeBoxComponentWidth / 2 - 40,
          child: Row(
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              width: 0.5,
                            ),
                            gradient: ThemeBase.gradientInputFormBackground,
                          ),
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              height: 45,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: bridge.changeDirectionInProgress == true
                                    ? const Text('')
                                    : bridge.blockchainTo == null
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .btn_selectBlockchain,
                                              style: textTheme.titleMedium,
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/bc-logos/${bridge.blockchainTo!.icon}',
                                                width: 20,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                bridge.blockchainTo!.name,
                                                style: textTheme.titleMedium,
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
                              if (bridge.blockchainFrom != null &&
                                  bridge.blockchainFrom!.env != '1-mainnet') {
                                blockchainSelectionNotifier
                                    .setTestnetIncluded(true);
                              }

                              final blockchain =
                                  await BlockchainSelectionPopup.getDialog(
                                context,
                                ref,
                                env: bridge.blockchainFrom == null
                                    ? null
                                    : bridge.blockchainFrom!.env,
                                shouldBeArchethic: bridge.blockchainFrom == null
                                    ? null
                                    : !bridge.blockchainFrom!.isArchethic,
                              );
                              if (blockchain == null) return;
                              await ref
                                  .watch(BridgeFormProvider.bridgeForm.notifier)
                                  .setBlockchainToWithConnection(blockchain);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 300))
        .scale(duration: const Duration(milliseconds: 300));
  }
}
