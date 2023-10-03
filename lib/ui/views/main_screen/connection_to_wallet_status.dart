/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      return const SizedBox();
    }

    if (session.walletTo == null || session.walletTo!.isConnected == false) {
      return const SizedBox();
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: FilledButton.tonal(
        onPressed: () {},
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
            Flexible(
              child: Text(
                overflow: TextOverflow.ellipsis,
                session.walletFrom!.nameAccountDisplayed,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Iconsax.arrow_right_1,
              size: 10,
            ),
            const SizedBox(
              width: 4,
            ),
            Flexible(
              child: Text(
                overflow: TextOverflow.ellipsis,
                session.walletTo!.nameAccountDisplayed,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
