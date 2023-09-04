/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/model/bridge_wallet.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
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
            ? Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 90,
                    padding: const EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      gradient: BridgeThemeBase.gradientSheetBackground,
                      border: GradientBoxBorder(
                        gradient: BridgeThemeBase.gradientSheetBorder,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/background-sheet.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (session.walletFrom != null &&
                            session.walletFrom!.isConnected)
                          _line(
                            session.walletFrom!.nameAccountDisplayed,
                            session.walletFrom!.endpoint,
                          )
                        else
                          _line('', ''),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: BridgeThemeBase.gradient,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        if (session.walletTo != null &&
                            session.walletTo!.isConnected)
                          _line(
                            session.walletTo!.nameAccountDisplayed,
                            session.walletTo!.endpoint,
                          )
                        else
                          _line('', ''),
                      ],
                    ),
                  ),
                  const IconCloseConnection(),
                ],
              )
            : const SizedBox()
        : const SizedBox();
  }

  Widget _line(String nameAccount, String endpoint) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nameAccount,
                style: textTheme.labelMedium,
              ),
              Text(
                endpoint,
                style: textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
