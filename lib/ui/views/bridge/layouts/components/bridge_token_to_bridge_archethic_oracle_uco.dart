/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/oracle/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BridgeTokenToBridgeArchethicOracleUco extends ConsumerWidget {
  const BridgeTokenToBridgeArchethicOracleUco({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archethicOracleUCO =
        ref.watch(ArchethicOracleUCOProviders.archethicOracleUCO);
    if (archethicOracleUCO.usd == 0) {
      return const SizedBox();
    }
    final timestamp = DateFormat.yMMMEd(
      Localizations.localeOf(context).languageCode,
    ).add_Hm().format(
          DateTime.fromMillisecondsSinceEpoch(
            archethicOracleUCO.timestamp * 1000,
          ).toLocal(),
        );
    return Text(
      '1 UCO = ${archethicOracleUCO.usd.toStringAsFixed(5)}\$ / ${archethicOracleUCO.eur.toStringAsFixed(5)}€ ($timestamp)',
    );
  }
}
