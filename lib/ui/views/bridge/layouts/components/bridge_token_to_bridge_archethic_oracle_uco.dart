/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_to_bridge_fiat_price.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BridgeTokenToBridgeArchethicOracleUco extends ConsumerWidget {
  const BridgeTokenToBridgeArchethicOracleUco({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archethicOracleUCO =
        ref.watch(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO);
    if (archethicOracleUCO.usd == 0) {
      return const SizedBox.shrink();
    }
    final timestamp = DateFormat.yMMMEd(
      Localizations.localeOf(context).languageCode,
    ).add_Hm().format(
          DateTime.fromMillisecondsSinceEpoch(
            archethicOracleUCO.timestamp * 1000,
          ).toLocal(),
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        aedappfm.IconButtonAnimated(
          icon: const Icon(
            Icons.help,
            size: 16,
          ),
          onPressed: () {
            launchUrl(
              Uri.parse(
                'https://wiki.archethic.net/FAQ/bridge-2-ways#how-is-the-price-of-uco-estimated',
              ),
            );
          },
          color: Colors.white,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const BridgeTokenToBridgeFiatPrice(),
            SelectableText(
              '1 UCO = \$${archethicOracleUCO.usd.formatNumber(precision: 2)} ($timestamp)',
              style: TextStyle(
                fontSize: aedappfm.Responsive.fontSizeFromValue(
                  context,
                  desktopValue:
                      Theme.of(context).textTheme.labelSmall!.fontSize!,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
