/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

import 'package:flutter/material.dart';

class ThemeBase {
  static String mainFont = 'Lato';
  static String adddressFont = 'Roboto';

  static Color primaryColor = const Color(0xFF4027A2);
  static Color backgroundColor = const Color(0xFF131313);
  static Color maxButtonColor = const Color(0xFF9816C5);
  static Color backgroundPopupColor = const Color(0xFF4027A2);

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

  static Gradient gradientErrorBackground = LinearGradient(
    colors: [
      const Color(0xFF131313).withOpacity(1),
      const Color(0xFF131313).withOpacity(0.3),
    ],
    stops: const [0, 1],
  );

  static Gradient gradientCircularStepProgressIndicator = const LinearGradient(
    colors: [
      Color(0xFFD55CFF),
      Color.fromARGB(255, 236, 205, 246),
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
