/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/util/components/icon_animated.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistoryCardOptions extends ConsumerWidget {
  const LocalHistoryCardOptions({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const IconAnimated(
            icon: Iconsax.trash,
            iconSize: 16,
            color: Colors.white,
          ),
          if (bridge.failure != null && bridge.failure is UserRejected)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () async {
                  await ref
                      .watch(BridgeFormProvider.bridgeForm.notifier)
                      .resume(bridge);
                  ref
                      .read(
                        MainScreenWidgetDisplayedProviders
                            .mainScreenWidgetDisplayedProvider.notifier,
                      )
                      .setWidget(const BridgeSheet());
                },
                child: const IconAnimated(
                  icon: Iconsax.play_circle,
                  iconSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
