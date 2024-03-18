import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 100),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  'Discover a ',
                  style: TextStyle(
                    fontSize: aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: 40,
                    ),
                    fontWeight: FontWeight.w400,
                  ),
                  textScaler: TextScaler.linear(
                    aedappfm.ScaleSize.textScaleFactor(context),
                  ),
                )
                    .animate(delay: 100.ms)
                    .fadeIn(duration: 400.ms, delay: 300.ms)
                    .move(
                      begin: const Offset(-16, 0),
                      curve: Curves.easeOutQuad,
                    ),
                aedappfm.GradientText(
                  'seamless',
                  style: TextStyle(
                    fontSize: aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: 40,
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                  gradient: aedappfm.AppThemeBase.gradientWelcomeTxt,
                )
                    .animate(delay: 200.ms)
                    .fadeIn(duration: 400.ms, delay: 200.ms)
                    .move(
                      begin: const Offset(-16, 0),
                      curve: Curves.easeOutQuad,
                    ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                aedappfm.GradientText(
                  'transfer',
                  style: TextStyle(
                    fontSize: aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: 40,
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                  gradient: aedappfm.AppThemeBase.gradientWelcomeTxt,
                )
                    .animate(delay: 300.ms)
                    .fadeIn(duration: 400.ms, delay: 300.ms)
                    .move(
                      begin: const Offset(-16, 0),
                      curve: Curves.easeOutQuad,
                    ),
                SelectableText(
                  ' of assets',
                  style: TextStyle(
                    fontSize: aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: 40,
                    ),
                    fontWeight: FontWeight.w400,
                  ),
                  textScaler: TextScaler.linear(
                    aedappfm.ScaleSize.textScaleFactor(context),
                  ),
                )
                    .animate(delay: 400.ms)
                    .fadeIn(duration: 400.ms, delay: 400.ms)
                    .move(
                      begin: const Offset(-16, 0),
                      curve: Curves.easeOutQuad,
                    ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
