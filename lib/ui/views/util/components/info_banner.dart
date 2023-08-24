/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class InfoBanner extends StatelessWidget {
  const InfoBanner(
    this.message, {
    this.error = false,
    this.height = 40,
    this.width = ThemeBase.sizeBoxComponentWidth,
    super.key,
  });

  final String message;
  final bool error;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) {
      return SizedBox(
        height: height,
      );
    }

    return SizedBox(
      width: width,
      height: height,
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
                        gradient: ThemeBase.gradientInfoBannerBackground,
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: 45,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            if (error)
                              Icon(
                                Iconsax.warning_2,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            if (error) const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                message,
                                style: TextStyle(
                                  color: error
                                      ? Theme.of(context).colorScheme.error
                                      : Theme.of(context).colorScheme.primary,
                                ),
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
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}
