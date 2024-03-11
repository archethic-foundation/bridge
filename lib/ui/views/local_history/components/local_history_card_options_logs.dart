/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_logs_popup.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalHistoryCardOptionsLogs extends ConsumerWidget {
  const LocalHistoryCardOptionsLogs({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () async {
          final formattedJson =
              const JsonEncoder.withIndent('  ').convert(bridge);
          await LocalHistoryLogsPopup.getDialog(
            context,
            ref,
            formattedJson,
          );
        },
        child: aedappfm.IconAnimated(
          icon: aedappfm.Iconsax.code,
          color: Colors.white,
          tooltip: AppLocalizations.of(context)!.local_history_option_logs,
        ),
      ),
    );
  }
}
