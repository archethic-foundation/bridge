/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aebridge/application/app_embedded.dart';

import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:aebridge/ui/views/main_screen/layouts/app_bar.dart';
import 'package:aebridge/ui/views/main_screen/layouts/bottom_navigation_bar.dart';
import 'package:aebridge/ui/views/main_screen/layouts/browser_popup.dart';
import 'package:aebridge/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aebridge/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreenSheet extends ConsumerStatefulWidget {
  const MainScreenSheet({
    required this.currentStep,
    required this.formSheet,
    required this.confirmSheet,
    this.topWidget,
    this.bottomWidget,
    this.afterBottomWidget,
    super.key,
  });

  final aedappfm.ProcessStep currentStep;
  final Widget formSheet;
  final Widget confirmSheet;
  final Widget? topWidget;
  final Widget? bottomWidget;
  final Widget? afterBottomWidget;
  @override
  ConsumerState<MainScreenSheet> createState() => MainScreenSheetState();
}

class MainScreenSheetState extends ConsumerState<MainScreenSheet> {
  List<(String, IconData)> listNavigationLabelIcon = [];

  @override
  void initState() {
    super.initState();

    if (BrowserUtil().isEdgeBrowser() ||
        BrowserUtil().isInternetExplorerBrowser()) {
      Future.delayed(Duration.zero, () {
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const BrowserPopup();
            },
          );
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    listNavigationLabelIcon = [
      (
        AppLocalizations.of(context)!.menu_swap,
        aedappfm.Iconsax.arrange_circle_2
      ),
      (
        AppLocalizations.of(context)!.menu_liquidity,
        aedappfm.Iconsax.wallet_money
      ),
      (AppLocalizations.of(context)!.menu_earn, aedappfm.Iconsax.wallet_add),
      (
        AppLocalizations.of(context)!.menu_bridge,
        aedappfm.Iconsax.recovery_convert
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isAppMobileFormat = aedappfm.Responsive.isMobile(context);
    final isAppEmbedded = ref.watch(isAppEmbeddedProvider);

    return Title(
      title: 'aeBridge - Bridge Archethic blockchain',
      color: Colors.black,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: aedappfm.AppThemeBase.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const AppBarMainScreen(),
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            alignment:
                isAppMobileFormat ? Alignment.topCenter : Alignment.center,
            children: [
              if (isAppMobileFormat)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/background-embedded.png',
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )
              else
                const aedappfm.AppBackground(
                  backgroundImage: 'assets/images/background-welcome.png',
                ),
              aedappfm.ArchethicScrollbar(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isAppMobileFormat ? 0 : 24,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.topWidget != null)
                          SizedBox(width: 650, child: widget.topWidget),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: 650,
                              decoration: isAppMobileFormat
                                  ? null
                                  : BoxDecoration(
                                      color:
                                          aedappfm.AppThemeBase.sheetBackground,
                                      border: Border.all(
                                        color:
                                            aedappfm.AppThemeBase.sheetBorder,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  right: 30,
                                  top: 11,
                                  bottom: 5,
                                ),
                                child: Column(
                                  children: [
                                    IntrinsicHeight(
                                      child: widget.currentStep ==
                                              aedappfm.ProcessStep.form
                                          ? widget.formSheet
                                          : widget.confirmSheet,
                                    ),
                                    if (widget.bottomWidget != null)
                                      widget.bottomWidget!,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (widget.afterBottomWidget != null)
                          SizedBox(
                            width: 650,
                            child: widget.afterBottomWidget,
                          ),
                      ],
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
              ),
            ],
          ),
        ),
        bottomNavigationBar: !isAppEmbedded &&
                (aedappfm.Responsive.isMobile(context) ||
                    aedappfm.Responsive.isTablet(context))
            ? BottomNavigationBarMainScreen(
                listNavigationLabelIcon: listNavigationLabelIcon,
                navDrawerIndex: ref.watch(navigationIndexMainScreenProvider),
              )
            : null,
      ),
    );
  }
}
