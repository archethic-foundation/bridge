/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/util/components/icon_animated.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';

class LocalHistoryCardOptions extends StatelessWidget {
  const LocalHistoryCardOptions({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.zero,
            child: IconAnimated(
              icon: Iconsax.trash,
              iconSize: 16,
              color: Colors.white,
            ),
          ),
          if (bridge.failure != null && bridge.failure is UserRejected)
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: IconAnimated(
                icon: Iconsax.play_circle,
                iconSize: 16,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
