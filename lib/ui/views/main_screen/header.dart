/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/main_screen/connection_to_wallet_status.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return const ConnectionToWalletStatus();
    }

    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        Image.asset(
          'assets/images/AELogo.png',
          width: 30,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          'Bridge',
          style: TextStyle(
            fontSize: 20,
            color: ArchethicThemeBase.blue200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(
            'Beta',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
