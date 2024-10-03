import 'package:aebridge/domain/repositories/features_flags.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_evm_sheet.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/local_history/local_history_sheet.dart';
import 'package:aebridge/ui/views/maintenance/maintenance_screen.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
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
        routes: [
          GoRoute(
            path: BridgeEVMSheet.routerPage,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: BridgeEVMSheet(),
              );
            },
          ),
        ],
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
          int? chainId;
          try {
            final helper = QueryParameterHelper();
            final htlcAddressEncoded = state.uri.queryParameters['htlcAddress'];
            if (htlcAddressEncoded != null) {
              htlcAddress = helper.decodeQueryParameter(htlcAddressEncoded);
            }
            final chainIdEncoded = state.uri.queryParameters['chainId'];
            if (chainIdEncoded != null) {
              chainId = helper.decodeQueryParameter(chainIdEncoded);
            }
          } catch (e)
          // ignore: empty_catches
          {}
          return NoTransitionPage(
            child: RefundSheet(
              htlcAddress: htlcAddress,
              chainId: chainId,
            ),
          );
        },
      ),
      GoRoute(
        path: MaintenanceScreen.routerPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(
            child: MaintenanceScreen(),
          );
        },
      ),
    ],
    redirect: (context, state) async {
      if (FeatureFlags.inMaintenance) {
        if (context.mounted) return MaintenanceScreen.routerPage;
      }

      return null;
    },
    errorBuilder: (context, state) => const BridgeSheet(),
  );
});
