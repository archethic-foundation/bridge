import 'package:aebridge/infrastructure/hive/preferences.hive.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/local_history/local_history_sheet.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:aebridge/ui/views/welcome/welcome_screen.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: BridgeSheet.routerPage,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: BridgeSheet(),
          );
        },
      ),
      GoRoute(
        path: BridgeSheet.routerPage,
        pageBuilder: (context, state) {
          final helper = QueryParameterHelper();
          BridgeFormState? bridgeFormState;
          try {
            final bridgeFormStateEncoded =
                state.uri.queryParameters['initialState'];
            if (bridgeFormStateEncoded != null) {
              final bridgeFormStateEncodedJson =
                  helper.decodeQueryParameter(bridgeFormStateEncoded);
              bridgeFormState = BridgeFormState.fromJson(
                bridgeFormStateEncodedJson,
              );
            }
          } catch (e)
          // ignore: empty_catches
          {}

          return NoTransitionPage(
            child: BridgeSheet(
              initialState: bridgeFormState,
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
          String? htlcAddress;
          try {
            final helper = QueryParameterHelper();
            final htlcAddressEncoded = state.uri.queryParameters['htlcAddress'];
            if (htlcAddressEncoded != null) {
              htlcAddress = helper.decodeQueryParameter(htlcAddressEncoded);
            }
          } catch (e)
          // ignore: empty_catches
          {}
          return NoTransitionPage(
            child: RefundSheet(
              htlcAddress: htlcAddress,
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
    redirect: (context, state) async {
      final preferences = await HivePreferencesDatasource.getInstance();
      if (preferences.isFirstConnection()) {
        await preferences.setFirstConnection(false);
        if (context.mounted) return WelcomeScreen.routerPage;
      }
      return null;
    },
    errorBuilder: (context, state) => const WelcomeScreen(),
  );
});
