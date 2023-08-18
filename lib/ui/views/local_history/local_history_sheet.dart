import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/model/hive/bridge.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_clear_btn.dart';
import 'package:aebridge/ui/views/util/components/blockchain_label.dart';
import 'package:aebridge/ui/views/util/generic/formatters.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:intl/intl.dart';

class LocalHistorySheet extends ConsumerWidget {
  const LocalHistorySheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridgesList = ref.watch(BridgeHistoryProviders.fetchBridgesList);

    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 5,
        right: 5,
      ),
      decoration: BoxDecoration(
        border: const GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              Color(0xFFCC00FF),
              Color(0x003C89B9),
            ],
            stops: [0, 1],
          ),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!Responsive.isDesktop(context)) const SizedBox(width: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SelectionArea(
                  child: Text(
                    AppLocalizations.of(context)!.bridgesListTitle,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 25,
                  height: 1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x003C89B9),
                        Color(0xFFCC00FF),
                      ],
                      stops: [0, 1],
                      begin: AlignmentDirectional.centerEnd,
                      end: AlignmentDirectional.centerStart,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: SizedBox(
              width: 300,
              child: LocalHistoryClearButton(),
            ),
          ),
          bridgesList.map(
            data: (data) {
              return Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: data.value.length,
                    itemBuilder: (context, index) {
                      return _buildBridgeCard(
                        context,
                        ref,
                        data.value[index],
                      );
                    },
                  ),
                ),
              );
            },
            error: (error) => const SizedBox(),
            loading: (loading) => Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: MediaQuery.of(context).size.height - 200,
              ),
              child: const LinearProgressIndicator(
                minHeight: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildBridgeCard(BuildContext context, WidgetRef ref, Bridge bridge) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: SizedBox(
      height: 100,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.background.withOpacity(1),
              Theme.of(context).colorScheme.background.withOpacity(0.3),
            ],
            stops: const [0, 1],
          ),
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.background.withOpacity(0.5),
                Theme.of(context).colorScheme.background.withOpacity(0.7),
              ],
              stops: const [0, 1],
            ),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _contentCard(context, ref, bridge),
      ),
    ),
  );
}

Widget _contentCard(BuildContext context, WidgetRef ref, Bridge bridge) {
  return InkWell(
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    onTap: () {
      return;
    },
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
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
                  Row(
                    children: [
                      BlockchainLabel(
                        chainId: bridge.blockchainChainIdFrom!,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Icon(
                          Iconsax.arrow_right,
                          size: 16,
                        ),
                      ),
                      BlockchainLabel(
                        chainId: bridge.blockchainChainIdTo!,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SelectableText(
                        '${bridge.tokenToBridgeAmount.toString().formatNumber()} ${bridge.tokenToBridge!.symbol} to ${bridge.targetAddress}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
