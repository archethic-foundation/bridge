/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/balance.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/swap.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeBalanceWarning extends ConsumerWidget {
  const BridgeBalanceWarning({
    required this.swapProcess,
    super.key,
  });

  final SwapProcess swapProcess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.blockchainTo == null ||
        bridge.tokenToBridge == null ||
        bridge.blockchainFrom == null ||
        bridge.tokenToBridge == null) {
      return const SizedBox.shrink();
    }

    if (swapProcess == SwapProcess.chargeable &&
        bridge.blockchainTo!.isArchethic == false) {
      return const SizedBox.shrink();
    }

    if (swapProcess == SwapProcess.signed &&
        bridge.blockchainFrom!.isArchethic == false) {
      return const SizedBox.shrink();
    }

    final archethicOracleUCO =
        ref.watch(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO);
    if (archethicOracleUCO.usd == 0) {
      return const SizedBox.shrink();
    }

    double? balanceUCO;
    double? minAmountDollars;

    bridge.blockchainTo!.isArchethic
        ? minAmountDollars = 0.16
        : minAmountDollars = 0.17;

    final session = ref.read(SessionProviders.session);
    if (session.walletTo == null && session.walletFrom == null) {
      return const SizedBox.shrink();
    }
    return FutureBuilder<double?>(
      future: ref.read(
        BalanceProviders.getBalance(
          true,
          bridge.blockchainTo!.isArchethic
              ? session.walletTo!.genesisAddress
              : session.walletFrom!.genesisAddress,
          '',
          '',
        ).future,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          balanceUCO = snapshot.data;
          final minAmountUCO = (Decimal.parse(minAmountDollars.toString()) /
                  Decimal.parse(archethicOracleUCO.usd.toString()))
              .toDouble();
          if (swapProcess == SwapProcess.chargeable && balanceUCO! == 0) {
            return _getIconInfo(context);
          }

          if (balanceUCO! > 0 && minAmountUCO > balanceUCO!) {
            return _getIconWarning(context);
          }
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _getIconWarning(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 4),
      child: Tooltip(
        message: AppLocalizations.of(context)!.warningBalanceUCOTooLow,
        child: Icon(
          Icons.warning,
          color: aedappfm.ArchethicThemeBase.systemDanger500,
          size: 15,
        ),
      ),
    );
  }

  Widget _getIconInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 4),
      child: Tooltip(
        message: AppLocalizations.of(context)!.infoBalanceUCOZero,
        child: Icon(
          Icons.warning,
          color: aedappfm.ArchethicThemeBase.systemWarning600,
          size: 15,
        ),
      ),
    );
  }
}
