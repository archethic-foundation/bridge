/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

    if (session.walletFrom == null ||
        session.walletFrom!.isConnected == false) {
      return const SizedBox.shrink();
    }

    if (session.walletTo == null || session.walletTo!.isConnected == false) {
      return const SizedBox.shrink();
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Iconsax.user,
            size: 18,
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tooltip(
                message: session.walletFrom!.genesisAddress,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  session.walletFrom!.nameAccountDisplayed,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(
                  Iconsax.arrow_down,
                  size: 10,
                ),
              ),
              Tooltip(
                message: session.walletTo!.genesisAddress,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  session.walletTo!.nameAccountDisplayed,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 4,
          ),
        ],
      ),
    );
  }
}

class MenuConnectionToWalletStatus extends ConsumerWidget {
  const MenuConnectionToWalletStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(SessionProviders.session);
    final sessionNotifier = ref.watch(SessionProviders.session.notifier);

    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Center(
                child: Text(
                  session.walletFrom!.endpoint,
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  session.walletFrom!.nameAccount,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Center(
                child: Text(
                  session.walletTo!.endpoint,
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  session.walletTo!.nameAccount,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  Iconsax.logout,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(AppLocalizations.of(context)!.logout),
              ],
            ),
          ),
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return ScaffoldMessenger(
                  child: Builder(
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: BridgeThemeBase.backgroundPopupColor,
                        contentPadding: const EdgeInsets.only(
                          top: 10,
                        ),
                        content: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .confirmationPopupTitle,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .connectionWalletDisconnectWarning,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppButton(
                                      labelBtn:
                                          AppLocalizations.of(context)!.no,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    AppButton(
                                      labelBtn:
                                          AppLocalizations.of(context)!.yes,
                                      onPressed: () async {
                                        await sessionNotifier
                                            .cancelAllWalletsConnection();

                                        if (!context.mounted) return;
                                        context.go('/welcome');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
