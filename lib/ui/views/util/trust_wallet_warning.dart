import 'package:aebridge/application/app_embedded.dart';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrustWalletWarning extends ConsumerWidget {
  const TrustWalletWarning({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAppEmbedded = ref.watch(isAppEmbeddedProvider);
    if (isAppEmbedded == false) {
      return const SizedBox.shrink();
    }

    final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();

    if (evmWalletProvider.walletConnector == null ||
        (evmWalletProvider.walletConnector!.id != null &&
            evmWalletProvider.walletConnector!.id != 'com.trustwallet.app')) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Wrap(
        children: [
          aedappfm.BlockInfo(
            width: aedappfm.AppThemeBase.sizeBoxComponentWidth,
            height: 58,
            info: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  AppLocalizations.of(context)!.trustWalletWarning,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: aedappfm.ArchethicThemeBase.systemWarning500,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
