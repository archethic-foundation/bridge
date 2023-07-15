/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/util/connection_to_wallet_status.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    this.displayWalletConnectStatus = false,
    this.forceAELogo = false,
    super.key,
  });
  final bool displayWalletConnectStatus;
  final bool forceAELogo;

  @override
  Widget build(BuildContext context) {
    if (forceAELogo == false &&
        (Responsive.isMobile(context) || Responsive.isTablet(context))) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/AELogo.png',
            width: 60,
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      );
    }
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/AELogo.png',
              width: 60,
            ),
            const Text(
              'Bridge',
              style: TextStyle(
                fontFamily: 'Caveat',
                fontSize: 50,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                'Beta',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
        if (displayWalletConnectStatus)
          const Positioned(
            top: 7,
            right: 0,
            child: SizedBox(
              width: 250,
              height: 60,
              child: ConnectionToWalletStatus(),
            ),
          )
      ],
    );
  }
}
