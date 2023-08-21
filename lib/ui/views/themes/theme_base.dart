/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

import 'package:flutter/material.dart';

class ThemeBase {
  static String mainFont = 'Lato';
  static String adddressFont = 'Roboto';

  static Color primaryColor = const Color(0xFF4027A2);
  static Color secondaryColor = const Color(0xFFEED0C5);
  static Color tertiaryColor = const Color(0xFF111128);
  static Color backgroundColor = Colors.black;
  static Color maxButtonColor = const Color(0xFFEED0C5);
  static Color backgroundPopupColor = const Color(0xFF111128);

  static Gradient gradient = LinearGradient(
    colors: [
      const Color(0xFF111128).withOpacity(0),
      const Color(0xFF7F0AEE),
    ],
    stops: const [0, 1],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static Gradient gradientBtn = const LinearGradient(
    colors: <Color>[
      Color(0xFF111128),
      Color(0xFF7F0AEE),
    ],
    transform: GradientRotation(pi / 9),
  );

  static Gradient gradientMainScreen = const LinearGradient(
    colors: [
      Color(0x003C89B9),
      Color(0xFF7F0AEE),
    ],
    stops: [0, 1],
  );

  static Gradient gradientSheetBackground = LinearGradient(
    colors: [
      const Color(0xFF111128).withOpacity(0.9),
      const Color(0xFF111128).withOpacity(0.2),
    ],
    stops: const [0, 1],
  );

  static Gradient gradientSheetBorder = LinearGradient(
    colors: [
      const Color(0xFF111128).withOpacity(0.7),
      const Color(0xFF111128).withOpacity(1),
    ],
    stops: const [0, 1],
  );

  static Gradient gradientInputFormBackground = LinearGradient(
    colors: [
      const Color(0xFF111128).withOpacity(1),
      const Color(0xFF111128).withOpacity(0.3),
    ],
    stops: const [0, 1],
  );

  static Gradient gradientErrorBackground = LinearGradient(
    colors: [
      const Color(0xFF111128).withOpacity(1),
      const Color(0xFF111128).withOpacity(0.3),
    ],
    stops: const [0, 1],
  );

  static Gradient gradientCircularStepProgressIndicator = const LinearGradient(
    colors: [
      Color(0xFF4027A2),
      Color(0xFF7F0AEE),
    ],
    stops: [0, 1],
  );

  static Gradient gradientCircularStepProgressIndicatorFinished =
      const LinearGradient(
    colors: [
      Color.fromARGB(255, 39, 162, 94),
      Color.fromARGB(255, 144, 195, 138),
    ],
    stops: [0, 1],
  );

  static Gradient gradientCircularStepProgressIndicatorError =
      const LinearGradient(
    colors: [
      Color.fromARGB(255, 162, 39, 39),
      Color.fromARGB(255, 195, 138, 138),
    ],
    stops: [0, 1],
  );

  static const sizeBoxComponentWidth = 600.0;
}
