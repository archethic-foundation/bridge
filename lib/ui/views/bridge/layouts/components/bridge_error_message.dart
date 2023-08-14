/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeErrorMessage extends ConsumerWidget {
  const BridgeErrorMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.errorText.isEmpty) {
      return const SizedBox();
    }
    return SizedBox(
      width: ThemeBase.sizeBoxComponentWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .error
                              .withOpacity(0.6),
                          width: 0.5,
                        ),
                        gradient: ThemeBase.gradientErrorBackground,
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: 45,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.warning_2,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              bridge.errorText,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
