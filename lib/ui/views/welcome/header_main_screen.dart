/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:flutter/material.dart';

class HeaderMainScreen extends StatelessWidget {
  const HeaderMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/AELogo.png',
          width: 60,
        ),
        Text(
          'Bridge',
          style: TextStyle(
            fontSize: 45,
            color: ArchethicThemeBase.blue200,
          ),
        ),
        const SizedBox(
          width: 5,
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
