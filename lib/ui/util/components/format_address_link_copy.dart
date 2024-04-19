import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

enum TypeAddress { address, transaction, chain }

class FormatAddressLinkCopy extends ConsumerWidget {
  const FormatAddressLinkCopy({
    required this.address,
    required this.chainId,
    this.reduceAddress = false,
    this.fontSize = 13,
    this.typeAddress = TypeAddress.address,
    this.header,
    super.key,
  });

  final int chainId;
  final String address;
  final bool reduceAddress;
  final double fontSize;
  final TypeAddress typeAddress;
  final String? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Tooltip(
          message: address,
          child: header != null
              ? SelectableText(
                  '$header ${reduceAddress ? aedappfm.AddressUtil.reduceAddress(address) : address}',
                  style: TextStyle(
                    fontSize: aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: fontSize,
                    ),
                  ),
                )
              : SelectableText(
                  reduceAddress
                      ? aedappfm.AddressUtil.reduceAddress(address)
                      : address,
                  style: TextStyle(
                    fontSize: aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: fontSize,
                    ),
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
                content: SelectableText(
                  AppLocalizations.of(context)!.addressCopied,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                          context,
                          Theme.of(context).textTheme.labelMedium!,
                        ),
                      ),
                ),
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                  label: AppLocalizations.of(context)!.addressCopied,
                  onPressed: () {},
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Icon(
              aedappfm.Iconsax.copy,
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
              if (typeAddress == TypeAddress.address) {
                await launchUrl(
                  Uri.parse(
                    '${blockchain!.urlExplorerAddress}$address',
                  ),
                );
              } else {
                await launchUrl(
                  Uri.parse(
                    '${blockchain!.urlExplorerChain}$address',
                  ),
                );
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Icon(
              aedappfm.Iconsax.export_3,
              size: fontSize - 1,
            ),
          ),
        ),
      ],
    );
  }
}
