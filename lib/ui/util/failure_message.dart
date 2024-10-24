/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aebridge/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

enum BridgeProcess { bridge, refund }

class FailureMessage {
  const FailureMessage({
    required this.context,
    this.failure,
    this.bridgeProcess = BridgeProcess.bridge,
  });

  final aedappfm.Failure? failure;
  final BuildContext context;
  final BridgeProcess bridgeProcess;

  String getMessage() {
    if (failure == null) return '';

    if (failure is aedappfm.UserRejected) {
      return AppLocalizations.of(context)!.failureUserRejected;
    }

    if (failure is aedappfm.ChainSwitchNotSupported) {
      return AppLocalizations.of(context)!.failureChainSwitchNotSupported;
    }

    if (failure is aedappfm.ConnectivityArchethic) {
      if (kIsWeb == true) {
        if (BrowserUtil().isBraveBrowser()) {
          return AppLocalizations.of(context)!
              .failureConnectivityArchethicBrave;
        }
      }
      return AppLocalizations.of(context)!.failureConnectivityArchethic;
    }

    if (failure is aedappfm.ConnectivityEVM) {
      return AppLocalizations.of(context)!.failureConnectivityEVM;
    }

    if (failure is aedappfm.ParamEVMChain) {
      return AppLocalizations.of(context)!.failureParamEVMChain;
    }

    if (failure is aedappfm.Timeout) {
      if (bridgeProcess == BridgeProcess.bridge) {
        return AppLocalizations.of(context)!.failureTimeout;
      } else {
        return AppLocalizations.of(context)!.failureRefundTimeout;
      }
    }

    if (failure is aedappfm.InsufficientFunds) {
      return AppLocalizations.of(context)!.failureInsufficientFunds;
    }

    if (failure is aedappfm.InsufficientPoolFunds) {
      return AppLocalizations.of(context)!.failurePoolInsufficientFunds;
    }

    if (failure is aedappfm.HTLCWithoutFunds) {
      return AppLocalizations.of(context)!.failureHTLCWithoutFunds;
    }

    if (failure is aedappfm.NotHTLC) {
      return AppLocalizations.of(context)!.failureNotHTLC;
    }

    if (failure is aedappfm.RPCErrorEVM) {
      return (failure! as aedappfm.RPCErrorEVM).cause.toString();
    }

    if (failure is aedappfm.WrongNetwork) {
      return (failure! as aedappfm.WrongNetwork).cause;
    }

    if (failure is aedappfm.OtherFailure) {
      return '${(failure! as aedappfm.OtherFailure).cause}';
    }

    if (failure is aedappfm.IncompatibleBrowser) {
      return AppLocalizations.of(context)!.failureIncompatibleBrowser;
    }

    if (failure is aedappfm.FaucetUCOError) {
      return AppLocalizations.of(context)!.failureFaucetUCOError;
    }

    if (failure is aedappfm.FaucetUCUserRejected) {
      return AppLocalizations.of(context)!.failureFaucetUCOUserRejected;
    }

    return failure.toString();
  }
}
