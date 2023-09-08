/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_direction_infos.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_htlc_infos.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_status_infos.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_trf_infos.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
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
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: BridgeThemeBase.gradientSheetBackground,
          border: GradientBoxBorder(
            gradient: BridgeThemeBase.gradientSheetBorder,
          ),
          borderRadius: BorderRadius.circular(24),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/background-sheet.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
                LocalHistoryCardStatusInfos(bridge: bridge),
                LocalHistoryCardDirectionInfos(bridge: bridge),
                LocalHistoryCardTrfInfos(bridge: bridge),
                LocalHistoryCardHTLCInfos(bridge: bridge),
                LocalHistoryCardOptions(bridge: bridge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
