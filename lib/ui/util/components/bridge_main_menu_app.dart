/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class BridgeMainMenuApp extends StatelessWidget {
  const BridgeMainMenuApp({
    super.key,
    this.withFaucet = true,
  });

  final bool withFaucet;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      right: 20,
      child: Column(
        children: [
          _buildSubMenu(
            AppLocalizations.of(context)!.archethicDashboardMenuDEXItem,
            AppLocalizations.of(context)!.archethicDashboardMenuDEXDesc,
            'https://swap.testnet.archethic.net',
          ).animate(delay: 300.ms).fadeIn(duration: 400.ms, delay: 200.ms).move(
                begin: const Offset(-16, 0),
                curve: Curves.easeOutQuad,
              ),
          _buildSubMenu(
            AppLocalizations.of(context)!.archethicDashboardMenuWalletOnWayItem,
            AppLocalizations.of(context)!.archethicDashboardMenuWalletOnWayDesc,
            'https://www.archethic.net/wallet',
          ).animate(delay: 400.ms).fadeIn(duration: 400.ms, delay: 200.ms).move(
                begin: const Offset(-16, 0),
                curve: Curves.easeOutQuad,
              ),
        ],
      ),
    );
  }

  Widget _buildSubMenu(
    String label,
    String description,
    String url, {
    double topPadding = 20,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: InkWell(
        onTap: () {
          launchUrl(
            Uri.parse(url),
          );
        },
        child: SizedBox(
          width: 250,
          height: 100,
          child: aedappfm.SingleCard(
            globalPadding: 0,
            cardContent: Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SelectableText(
                    label,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      description,
                      textAlign: TextAlign.end,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}