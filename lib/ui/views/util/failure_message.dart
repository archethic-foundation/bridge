/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class FailureMessage {
  const FailureMessage({
    required this.context,
    this.failure,
  });

  final Failure? failure;
  final BuildContext context;

  String getMessage() {
    if (failure == null) return '';

    if (failure is UserRejected) {
      return AppLocalizations.of(context)!.failureUserRejected;
    }

    if (failure is ConnectivityArchethic) {
      return AppLocalizations.of(context)!.failureConnectivityArchethic;
    }

    if (failure is ConnectivityEVM) {
      return AppLocalizations.of(context)!.failureConnectivityEVM;
    }

    if (failure is InsufficientFunds) {
      return AppLocalizations.of(context)!.failureInsufficientFunds;
    }

    if (failure is RPCErrorEVM) {
      return (failure! as RPCErrorEVM).data!['Some_Key']!.reason;
    }

    if (failure is WrongNetwork) {
      return (failure! as WrongNetwork).cause;
    }

    if (failure is OtherFailure) {
      return (failure! as OtherFailure).cause.toString();
    }

    return failure.toString();
  }
}
