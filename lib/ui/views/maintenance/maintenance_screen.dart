import 'dart:ui';

import 'package:aebridge/ui/views/maintenance/components/app_bar_maintenance.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class MaintenanceScreen extends ConsumerWidget {
  const MaintenanceScreen({
    super.key,
  });

  static const routerPage = '/maintenance';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: const AppBarMaintenance(),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: aedappfm.AppThemeBase.backgroundColor,
      body: Stack(
        children: [
          const aedappfm.AppBackground(
            withAnimation: true,
            backgroundImage: 'assets/images/background-welcome.png',
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/AELogo.svg',
                  height: 60,
                ),
                const SizedBox(
                  height: 30,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.maintenanceInfo,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: aedappfm.Responsive.fontSizeFromValue(
                          context,
                          desktopValue: 20,
                        ),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
