/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/model/bridge_wallet.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:aebridge/ui/views/util/components/icon_close_connection.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';

class ConnectionToWalletStatus extends ConsumerStatefulWidget {
  const ConnectionToWalletStatus({
    super.key,
  });

  @override
  ConsumerState<ConnectionToWalletStatus> createState() =>
      _ConnectionToWalletStatusState();
}

class _ConnectionToWalletStatusState
    extends ConsumerState<ConnectionToWalletStatus> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    final session = ref.watch(SessionProviders.session);
    BridgeWallet? walletArchethic;
    if (session.walletFrom != null &&
        session.walletFrom!.wallet == 'archethic') {
      walletArchethic = session.walletFrom;
    } else {
      if (session.walletTo != null && session.walletTo!.wallet == 'archethic') {
        walletArchethic = session.walletTo;
      }
    }

    if (walletArchethic != null &&
        walletArchethic.oldNameAccount.isNotEmpty &&
        walletArchethic.oldNameAccount != walletArchethic.nameAccount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
            content: Text(
              AppLocalizations.of(context)!.changeCurrentAccountWarning,
              style: Theme.of(context).snackBarTheme.contentTextStyle,
            ),
            duration: const Duration(seconds: 3),
          ),
        );

        ref.read(SessionProviders.session.notifier).setOldNameAccount();
      });
    }

    return (session.walletFrom != null && session.walletFrom!.isConnected) ||
            (session.walletTo != null && session.walletTo!.isConnected)
        ? Responsive.isDesktop(context)
            ? Container(
                height: 90,
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.background.withOpacity(1),
                      Theme.of(context).colorScheme.background.withOpacity(0.3),
                    ],
                    stops: const [0, 1],
                  ),
                  border: GradientBoxBorder(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.5),
                        Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.7),
                      ],
                      stops: const [0, 1],
                    ),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (session.walletFrom != null &&
                        session.walletFrom!.isConnected)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  session.walletFrom!.nameAccountDisplayed,
                                  style: textTheme.labelMedium,
                                ),
                                Text(
                                  session.walletFrom!.endpoint,
                                  style: textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                          IconCloseConnection(wallet: session.walletFrom!),
                        ],
                      ),
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      decoration: BoxDecoration(gradient: ThemeBase.gradient),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    if (session.walletTo != null &&
                        session.walletTo!.isConnected)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  session.walletTo!.nameAccountDisplayed,
                                  style: textTheme.labelMedium,
                                ),
                                Text(
                                  session.walletTo!.endpoint,
                                  style: textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                          IconCloseConnection(wallet: session.walletTo!),
                        ],
                      ),
                  ],
                ),
              )
            : const SizedBox()
        : const SizedBox();
  }
}
