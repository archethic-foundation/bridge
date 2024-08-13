import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';

class AppTextStyles {
  static const kOpacityText = 0.8;

  static TextStyle bodyLarge(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
            context,
            Theme.of(context).textTheme.bodyLarge!,
          ),
        );
  }

  static TextStyle bodyLargeSecondaryColor(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: aedappfm.AppThemeBase.secondaryColor,
          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
            context,
            Theme.of(context).textTheme.bodyLarge!,
          ),
        );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
            context,
            Theme.of(context).textTheme.bodyMedium!,
          ),
        );
  }

  static TextStyle bodyMediumSecondaryColor(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: aedappfm.AppThemeBase.secondaryColor,
          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
            context,
            Theme.of(context).textTheme.bodyMedium!,
          ),
        );
  }

  static TextStyle bodySmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
            context,
            Theme.of(context).textTheme.bodySmall!,
          ),
        );
  }

  static TextStyle bodySmallSecondaryColor(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          color: aedappfm.AppThemeBase.secondaryColor,
          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
            context,
            Theme.of(context).textTheme.bodySmall!,
          ),
        );
  }
}
