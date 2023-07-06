/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/blockchain_selection/blockchain_selection_popup.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
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
          width: 450,
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
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withOpacity(1),
                                Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withOpacity(0.3),
                              ],
                              stops: const [0, 1],
                            ),
                          ),
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              height: 45,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: bridge.blockchainFrom == null
                                    ? Text(
                                        AppLocalizations.of(context)!
                                            .btn_selectBlockchain,
                                        style: textTheme.titleMedium,
                                      )
                                    : Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/bc-logos/${bridge.blockchainFrom!.icon}',
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            bridge.blockchainFrom!.name,
                                            style: textTheme.titleMedium,
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            onTap: () async {
                              final blockchain =
                                  await BlockchainSelectionPopup.getDialog(
                                context,
                                bridge.blockchainTo == null
                                    ? []
                                    : [bridge.blockchainTo!.name],
                              );
                              if (blockchain == null) return;
                              ref
                                  .watch(BridgeFormProvider.bridgeForm.notifier)
                                  .setBlockchainFrom(blockchain);
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
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}
