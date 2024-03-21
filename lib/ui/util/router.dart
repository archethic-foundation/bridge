import 'package:aebridge/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: WelcomeScreen.routerPage,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: WelcomeScreen(),
          );
        },
      ),
    ],
    redirect: (context, state) async {
      return WelcomeScreen.routerPage;
    },
    errorBuilder: (context, state) => const WelcomeScreen(),
  );
});
