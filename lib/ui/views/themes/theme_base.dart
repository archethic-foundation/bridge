/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

import 'package:flutter/material.dart';

class ThemeBase {
  static String mainFont = 'PPTelegraf';
  static String adddressFont = 'Roboto';

  static Color primaryColor = const Color(0xFF4027A2);
  static Color secondaryColor = const Color(0xFFEED0C5);
  static Color tertiaryColor = const Color(0xFF111128);
  static Color backgroundColor = Colors.black;
  static Color maxButtonColor = const Color(0xFF00A4DB);

  static Gradient gradient = LinearGradient(
    colors: [
      const Color(0xFF111128).withOpacity(0),
      const Color(0xFF7F0AEE),
    ],
    stops: const [0, 1],
    begin: AlignmentDirectional.centerEnd,
    end: AlignmentDirectional.centerStart,
  );

  static Gradient gradientBtn = const LinearGradient(
    colors: <Color>[
      Color(0xFF111128),
      Color(0xFF7F0AEE),
    ],
    transform: GradientRotation(pi / 9),
  );
}
