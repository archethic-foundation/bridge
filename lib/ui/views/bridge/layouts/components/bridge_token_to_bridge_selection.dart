/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/token_selection/token_selection_popup.dart';
import 'package:aebridge/ui/views/util/token_icon.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeTokenToBridgeSelection extends ConsumerWidget {
  const BridgeTokenToBridgeSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAppMobileFormat = aedappfm.Responsive.isMobile(context);

    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    final bridge = ref.watch(bridgeFormNotifierProvider);
    final session = ref.watch(sessionNotifierProvider);

    if (bridge.blockchainFrom == null ||
        bridge.blockchainTo == null ||
        session.allWalletsIsConnected == false) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: SelectableText(
              AppLocalizations.of(context)!.bridge_token_selection_lbl,
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
                              gradient: aedappfm
                                  .AppThemeBase.gradientInputFormBackground,
                            ),
                            child: InkWell(
                              child: SizedBox(
                                height: 45,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: bridge.tokenToBridge == null
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .btn_selectToken,
                                            style: isAppMobileFormat
                                                ? textTheme.titleMedium!
                                                : textTheme.titleMedium!
                                                    .copyWith(
                                                    fontSize: aedappfm
                                                            .Responsive
                                                        .fontSizeFromTextStyle(
                                                      context,
                                                      Theme.of(context)
                                                          .textTheme
                                                          .titleMedium!,
                                                    ),
                                                  ),
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            TokenIcon(
                                              symbol:
                                                  bridge.tokenToBridge!.symbol,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          '${bridge.tokenToBridge!.name} ',
                                                          style:
                                                              isAppMobileFormat
                                                                  ? Theme.of(
                                                                      context,
                                                                    )
                                                                      .textTheme
                                                                      .labelSmall!
                                                                  : Theme.of(
                                                                      context,
                                                                    )
                                                                      .textTheme
                                                                      .labelSmall!
                                                                      .copyWith(
                                                                        fontSize:
                                                                            aedappfm.Responsive.fontSizeFromTextStyle(
                                                                          context,
                                                                          Theme
                                                                              .of(
                                                                            context,
                                                                          ).textTheme.labelSmall!,
                                                                        ),
                                                                      ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Flexible(
                                                    child: SelectableText(
                                                      bridge.tokenToBridge!
                                                          .symbol,
                                                      style: isAppMobileFormat
                                                          ? Theme.of(context)
                                                              .textTheme
                                                              .labelSmall!
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .copyWith(
                                                                fontSize: aedappfm
                                                                        .Responsive
                                                                    .fontSizeFromTextStyle(
                                                                  context,
                                                                  Theme.of(
                                                                    context,
                                                                  )
                                                                      .textTheme
                                                                      .labelSmall!,
                                                                ),
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              onTap: () async {
                                final bridge =
                                    ref.read(bridgeFormNotifierProvider);
                                final direction =
                                    '${bridge.blockchainFrom!.chainId}->${bridge.blockchainTo!.chainId}';

                                final token =
                                    await TokenSelectionPopup.getDialog(
                                  context,
                                  ref,
                                  direction,
                                );
                                if (token == null) return;
                                await ref
                                    .read(
                                      bridgeFormNotifierProvider.notifier,
                                    )
                                    .setTokenToBridge(token);
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
      ),
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}
