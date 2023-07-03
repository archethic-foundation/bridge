import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/navigation_drawer_section.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Responsive(
        mobile: const SizedBox(),
        tablet: const SizedBox(),
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: const Padding(
                padding: EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                  left: 30,
                  right: 10,
                ),
                child: NavigationDrawerSection(),
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 200))
                  .scale(duration: const Duration(milliseconds: 200)),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                  left: 10,
                  right: 10,
                ),
                child: ref
                    .watch(
                      MainScreenWidgetDiplayedProviders
                          .mainScreenWidgetDiplayedProvider,
                    )
                    .animate()
                    .fade(
                      duration: const Duration(milliseconds: 200),
                    )
                    .scale(
                      duration: const Duration(milliseconds: 200),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
