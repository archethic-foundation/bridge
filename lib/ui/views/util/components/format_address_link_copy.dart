import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class FormatAddressLinkCopy extends ConsumerWidget {
  const FormatAddressLinkCopy({
    required this.address,
    required this.chainId,
    super.key,
  });

  final int chainId;
  final String address;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: SelectableText(
            address,
            style: TextStyle(
              fontSize: 13,
              fontFamily: ThemeBase.addressFont,
            ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            Clipboard.setData(
              ClipboardData(text: address),
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
          onTap: () async {
            final blockchain = await ref.watch(
              BridgeBlockchainsProviders.getBlockchainFromChainId(
                chainId,
              ).future,
            );

            launchUrl(
              Uri.parse(
                '${blockchain!.urlExplorer}$address',
              ),
            );
          },
          child: const Icon(
            Iconsax.export_3,
            size: 12,
          ),
        ),
      ],
    );
  }
}
