/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/icon_animated.dart';
import 'package:flutter/material.dart';

class PopupCloseButton extends StatelessWidget {
  const PopupCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: BridgeThemeBase.backgroundPopupColor,
          child: const CircleAvatar(
            foregroundColor: Colors.white,
            radius: 12,
            child: IconAnimated(
              color: Colors.white,
              icon: Icons.close,
            ),
          ),
        ),
      ),
    );
  }
}
