/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

import 'package:aebridge/application/app_embedded.dart';
import 'package:aebridge/application/app_mobile_format.dart';
import 'package:aebridge/ui/views/blockchain_selection/bloc/provider.dart';
import 'package:aebridge/ui/views/blockchain_selection/blockchain_selection_popup.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/mobile_info/layouts/mobile_info.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
    final isAppMobileFormat = ref.watch(isAppMobileFormatProvider(context));
    final isAppEmbedded = ref.watch(isAppEmbeddedProvider);

    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    final bridge = ref.watch(bridgeFormNotifierProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SelectableText(
            AppLocalizations.of(context)!.bridge_blockchain_from_lbl,
            style: isAppMobileFormat
                ? Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: aedappfm.AppThemeBase.secondaryColor,
                    )
                : null,
          ),
        ),
        SizedBox(
          width: isAppMobileFormat
              ? MediaQuery.of(context).size.width
              : min(
                  aedappfm.AppThemeBase.sizeBoxComponentWidth / 2 - 40,
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
              gradient: aedappfm.AppThemeBase.gradientInputFormBackground,
            ),
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                height: 45,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: bridge.changeDirectionInProgress == true
                      ? const SelectableText('')
                      : bridge.blockchainFrom == null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .btn_selectBlockchain,
                                      style: isAppMobileFormat
                                          ? textTheme.titleMedium!
                                          : textTheme.titleMedium!.copyWith(
                                              fontSize: aedappfm.Responsive
                                                  .fontSizeFromTextStyle(
                                                context,
                                                Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!,
                                              ),
                                            ),
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
                                    style: isAppMobileFormat
                                        ? textTheme.titleMedium!
                                        : textTheme.titleMedium!.copyWith(
                                            fontSize: aedappfm.Responsive
                                                .fontSizeFromTextStyle(
                                              context,
                                              Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!,
                                            ),
                                          ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                ),
              ),
              onTap: () async {
                if (isAppMobileFormat && isAppEmbedded == false) {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return Scaffold(
                        extendBodyBehindAppBar: true,
                        extendBody: true,
                        backgroundColor: Colors.transparent.withAlpha(120),
                        body: const Align(
                          child: MobileInfoScreen(),
                        ),
                      );
                    },
                  );
                  return;
                }

                final blockchainSelectionNotifier = ref.read(
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
                  true,
                );
                if (blockchain == null) return;

                final bridgeFormNotifier =
                    ref.read(bridgeFormNotifierProvider.notifier);
                // We want to swap values
                if (bridge.blockchainTo != null &&
                    blockchain.chainId == bridge.blockchainTo!.chainId) {
                  if (context.mounted) {
                    await bridgeFormNotifier
                        .swapDirections(AppLocalizations.of(context)!);
                  }
                  return;
                }
                if (context.mounted) {
                  await bridgeFormNotifier.setBlockchainFromWithConnection(
                    AppLocalizations.of(context)!,
                    blockchain,
                  );
                }
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
