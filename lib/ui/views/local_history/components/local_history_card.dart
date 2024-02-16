/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_direction_infos.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_htlc_infos.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options_delete.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options_logs.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options_refund.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options_resume.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_status_infos.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_trf_infos.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocalHistoryCard extends StatelessWidget {
  const LocalHistoryCard({
    required this.bridge,
    super.key,
  });

  final BridgeFormState bridge;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: aedappfm.AppThemeBase.sheetBackground,
              border: Border.all(
                color: aedappfm.AppThemeBase.sheetBorder,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMd(
                            Localizations.localeOf(context).languageCode,
                          ).add_Hms().format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  bridge.timestampExec!,
                                ).toLocal(),
                              ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            LocalHistoryCardOptionsDelete(bridge: bridge),
                            LocalHistoryCardOptionsResume(bridge: bridge),
                            LocalHistoryCardOptionsRefund(bridge: bridge),
                            LocalHistoryCardOptionsLogs(bridge: bridge),
                          ],
                        ),
                      ],
                    ),
                    LocalHistoryCardStatusInfos(bridge: bridge),
                    LocalHistoryCardDirectionInfos(bridge: bridge),
                    LocalHistoryCardTrfInfos(bridge: bridge),
                    LocalHistoryCardHTLCInfos(bridge: bridge),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
