import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:aebridge/util/address_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class FormatAddressLinkCopy extends ConsumerWidget {
  const FormatAddressLinkCopy({
    required this.address,
    required this.chainId,
    this.expanded = true,
    this.reduceAddress = false,
    this.fontSize = 13,
    super.key,
  });

  final int chainId;
  final String address;
  final bool expanded;
  final bool reduceAddress;
  final double fontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget _address() {
      return SelectableText(
        reduceAddress ? AddressUtil.reduceAddress(address) : address,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: BridgeThemeBase.addressFont,
        ),
      );
    }

    return Row(
      children: [
        if (expanded)
          Expanded(
            child: _address(),
          )
        else
          _address(),
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
          child: Icon(
            Iconsax.copy,
            size: fontSize - 1,
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

            await launchUrl(
              Uri.parse(
                '${blockchain!.urlExplorer}$address',
              ),
            );
          },
          child: Icon(
            Iconsax.export_3,
            size: fontSize - 1,
          ),
        ),
      ],
    );
  }
}
