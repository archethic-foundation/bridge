import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:aebridge/util/address_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

enum TypeAddress { address, transaction }

class FormatAddressLinkCopy extends ConsumerWidget {
  const FormatAddressLinkCopy({
    required this.address,
    required this.chainId,
    this.reduceAddress = false,
    this.fontSize = 13,
    this.typeAddress = TypeAddress.address,
    super.key,
  });

  final int chainId;
  final String address;
  final bool reduceAddress;
  final double fontSize;
  final TypeAddress typeAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget _address() {
      return Padding(
        padding: const EdgeInsets.only(bottom: 2.3),
        child: Text(
          reduceAddress ? AddressUtil.reduceAddress(address) : address,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: BridgeThemeBase.addressFont,
          ),
        ),
      );
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Icon(
              Iconsax.copy,
              size: fontSize - 1,
            ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () async {
            final blockchain = await ref.read(
              BridgeBlockchainsProviders.getBlockchainFromChainId(
                chainId,
              ).future,
            );
            if (typeAddress == TypeAddress.transaction) {
              await launchUrl(
                Uri.parse(
                  '${blockchain!.urlExplorerTransaction}$address',
                ),
              );
            } else {
              await launchUrl(
                Uri.parse(
                  '${blockchain!.urlExplorerAddress}$address',
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Icon(
              Iconsax.export_3,
              size: fontSize - 1,
            ),
          ),
        ),
      ],
    );
  }
}
