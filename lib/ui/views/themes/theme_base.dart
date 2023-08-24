/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

import 'package:flutter/material.dart';

class ThemeBase {
  static String mainFont = 'Lato';
  static String addressFont = 'Roboto';

  static Color primaryColor = const Color(0xFF4027A2);
  static Color backgroundColor = const Color(0xFF131313);
  static Color maxButtonColor = const Color(0xFF9816C5);
  static Color backgroundPopupColor = const Color(0xFF4027A2);

  static Color statusOK = const Color.fromARGB(255, 39, 162, 94);
  static Color statusKO = const Color.fromARGB(255, 195, 138, 138);
  static Color statusInProgress = const Color(0xFFD55CFF);

  static Gradient gradient = LinearGradient(
    colors: [
      const Color(0xFFFFFFFF).withOpacity(0.2),
      const Color(0xFFFFFFFF).withOpacity(0),
    ],
    stops: const [0, 1],
  );

  static Gradient gradientBtn = const LinearGradient(
    colors: <Color>[
      Color(0xFF562FED),
      Color(0xFFD55CFF),
    ],
    transform: GradientRotation(pi / 9),
  );

  static Gradient gradientSheetBackground = LinearGradient(
    colors: [
      const Color(0xFF4027A2).withOpacity(1),
      const Color(0xFF4027A2).withOpacity(1),
    ],
    stops: const [0, 1],
    begin: Alignment.topLeft,
    end: Alignment.center,
  );

  static Gradient gradientSheetBorder = LinearGradient(
    colors: [
      const Color(0xFF131313).withOpacity(0.7),
      const Color(0xFF131313).withOpacity(1),
    ],
    stops: const [0, 1],
  );

  static Gradient gradientInputFormBackground = LinearGradient(
    colors: [
      const Color(0xFF131313).withOpacity(1),
      const Color(0xFF131313).withOpacity(0.3),
    ],
    stops: const [0, 1],
  );

  static Gradient gradientInfoBannerBackground = LinearGradient(
    colors: [
      const Color(0xFF131313).withOpacity(1),
      const Color(0xFF131313).withOpacity(0.3),
    ],
    stops: const [0, 1],
  );

  static Gradient gradientCircularStepProgressIndicator = LinearGradient(
    colors: [
      statusInProgress,
      const Color.fromARGB(255, 236, 205, 246),
    ],
    stops: const [0, 1],
  );

  static Gradient gradientCircularStepProgressIndicatorFinished =
      LinearGradient(
    colors: [
      statusOK,
      const Color.fromARGB(255, 144, 195, 138),
    ],
    stops: const [0, 1],
  );

  static Gradient gradientCircularStepProgressIndicatorError = LinearGradient(
    colors: [
      const Color.fromARGB(255, 162, 39, 39),
      statusKO,
    ],
    stops: const [0, 1],
  );

  static const sizeBoxComponentWidth = 600.0;
}
