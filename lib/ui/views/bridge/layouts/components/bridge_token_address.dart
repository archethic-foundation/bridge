/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class BridgeTokenAddress extends ConsumerWidget {
  const BridgeTokenAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    if (bridge.blockchainTo == null ||
        bridge.tokenToBridge == null ||
        bridge.tokenToBridge!.tokenAddress == null ||
        bridge.tokenToBridge!.tokenAddress.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.bridge_token_address_lbl,
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(text: bridge.tokenToBridge!.tokenAddress),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor:
                          Theme.of(context).snackBarTheme.backgroundColor,
                      content: Text(
                        AppLocalizations.of(context)!.addressCopied,
                        style: Theme.of(context).snackBarTheme.contentTextStyle,
                      ),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: AppLocalizations.of(context)!.ok,
                        onPressed: () {},
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Iconsax.copy,
                  size: 12,
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  launchUrl(
                    Uri.parse(
                      'http://archethic.net',
                    ),
                  );
                },
                child: const Icon(
                  Iconsax.export_3,
                  size: 12,
                ),
              ),
            ],
          ),
          SelectableText(
            bridge.tokenToBridge!.tokenAddress,
            style: const TextStyle(
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}
