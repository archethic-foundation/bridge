import 'dart:convert';

import 'package:aebridge/splash.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/local_history/local_history_sheet.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:aebridge/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoutesPath {
  RoutesPath(
    this.rootNavigatorKey,
  );

  final GlobalKey<NavigatorState> rootNavigatorKey;

  GoRouter createRouter() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: true,
      extraCodec: const JsonCodec(),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(
              child: Splash(),
            );
          },
        ),
        GoRoute(
          path: BridgeSheet.routerPage,
          pageBuilder: (context, state) {
            var args = <String, dynamic>{};
            if (state.extra != null) {
              args = state.extra! as Map<String, dynamic>;
            }
            return NoTransitionPage(
              child: BridgeSheet(
                initialState: args['initialState'] == null
                    ? null
                    : args['initialState']! as BridgeFormState,
              ),
            );
          },
        ),
        GoRoute(
          path: LocalHistorySheet.routerPage,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: LocalHistorySheet(),
            );
          },
        ),
        GoRoute(
          path: RefundSheet.routerPage,
          pageBuilder: (context, state) {
            var args = <String, dynamic>{};
            if (state.extra != null) {
              args = state.extra! as Map<String, dynamic>;
            }
            return NoTransitionPage(
              child: RefundSheet(
                htlcAddress: args['htlcAddress'] == null
                    ? null
                    : args['htlcAddress']! as String,
              ),
            );
          },
        ),
        GoRoute(
          path: WelcomeScreen.routerPage,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(
              child: WelcomeScreen(),
            );
          },
        ),
      ],
      errorBuilder: (context, state) => const Splash(),
    );
  }
}
