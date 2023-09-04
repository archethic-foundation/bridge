/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/resizable_box.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:aebridge/ui/views/util/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageDetail extends ConsumerWidget {
  const PageDetail({
    super.key,
    required this.firstChild,
    required this.secondChild,
    required this.bottomBar,
  });

  final Widget firstChild;
  final Widget secondChild;
  final Widget bottomBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: BridgeThemeBase.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Responsive(
          mobile: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Header(displayWalletConnectStatus: true),
              Expanded(
                child: firstChild
                    .animate()
                    .fade(duration: const Duration(milliseconds: 200))
                    .scale(duration: const Duration(milliseconds: 200)),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: secondChild
                    .animate()
                    .fade(duration: const Duration(milliseconds: 250))
                    .scale(duration: const Duration(milliseconds: 250)),
              ),
              bottomBar,
            ],
          ),
          tablet: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Header(displayWalletConnectStatus: true),
              Expanded(
                child: ResizableBox(
                  width: MediaQuery.of(context).size.width - 100,
                  childLeft: firstChild
                      .animate()
                      .fade(duration: const Duration(milliseconds: 200))
                      .scale(duration: const Duration(milliseconds: 200)),
                  childRight: secondChild
                      .animate()
                      .fade(duration: const Duration(milliseconds: 250))
                      .scale(duration: const Duration(milliseconds: 250)),
                ),
              ),
              bottomBar,
            ],
          ),
          desktop: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Header(displayWalletConnectStatus: true),
              Expanded(
                child: ResizableBox(
                  width: MediaQuery.of(context).size.width - 100,
                  childLeft: firstChild
                      .animate()
                      .fade(duration: const Duration(milliseconds: 200))
                      .scale(duration: const Duration(milliseconds: 200)),
                  childRight: secondChild
                      .animate()
                      .fade(duration: const Duration(milliseconds: 250))
                      .scale(duration: const Duration(milliseconds: 250)),
                ),
              ),
              bottomBar,
            ],
          ),
        ),
      ),
    );
  }
}
