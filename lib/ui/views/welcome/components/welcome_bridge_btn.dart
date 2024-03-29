/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WelcomeBridgeBtn extends ConsumerStatefulWidget {
  const WelcomeBridgeBtn({
    super.key,
  });
  @override
  WelcomeBridgeBtnState createState() => WelcomeBridgeBtnState();
}

var _over = false;

class WelcomeBridgeBtnState extends ConsumerState<WelcomeBridgeBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  _over = true;
                });
              },
              onExit: (_) {
                setState(() {
                  _over = false;
                });
              },
              child: OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(BorderSide.none),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () async {
                  final sessionNotifier =
                      ref.read(SessionProviders.session.notifier);
                  await sessionNotifier.cancelAllWalletsConnection();
                  if (!context.mounted) return;
                  context.go(
                    BridgeSheet.routerPage,
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: ShapeDecoration(
                    gradient: aedappfm.AppThemeBase.gradientBtn,
                    shape: const StadiumBorder(),
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 7,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.btn_bridge,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.labelMedium!.color,
                      fontSize: aedappfm.Responsive.fontSizeFromValue(
                        context,
                        desktopValue: 17,
                      ),
                    ),
                  ),
                ).animate(target: _over ? 0 : 1).fade(end: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
