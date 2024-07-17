/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_direction_infos.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_htlc_infos.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options_delete.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options_logs.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options_refund.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options_resume.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_status_infos.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_trf_infos.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class LocalHistoryCard extends ConsumerStatefulWidget {
  const LocalHistoryCard({
    required this.bridge,
    super.key,
  });

  final BridgeFormState bridge;

  @override
  ConsumerState<LocalHistoryCard> createState() => LocalHistoryCardState();
}

class LocalHistoryCardState extends ConsumerState<LocalHistoryCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int? htlcLockTime;
  int? statusEVM;
  int? statusAE;
  bool isRefunded = false;
  bool canResume = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (widget.bridge.blockchainFrom != null &&
          widget.bridge.blockchainFrom!.htlcAddress != null) {
        if (widget.bridge.blockchainFrom!.isArchethic) {
          if (widget.bridge.blockchainFrom!.providerEndpoint.isEmpty) {
            if (mounted) {
              setState(() {
                statusAE = -1;
              });
            }
          } else {
            final apiService = archethic.ApiService(
              widget.bridge.blockchainFrom!.providerEndpoint,
            );

            try {
              final info = await ArchethicContract().getInfo(
                apiService,
                widget.bridge.blockchainFrom!.htlcAddress!,
              );
              if (mounted) {
                setState(() {
                  statusAE = info.statusHTLC;
                });
              }
              // ignore: empty_catches
            } catch (e) {}

            try {
              final htlcInfo = await ArchethicContract().getHTLCInfo(
                apiService,
                widget.bridge.blockchainFrom!.htlcAddress!,
              );
              if (mounted) {
                setState(() {
                  htlcLockTime = htlcInfo.endTime ?? 0;
                });
              }
              // ignore: empty_catches
            } catch (e) {}
          }
        } else {
          final evmHTLC = EVMHTLC(
            widget.bridge.blockchainFrom!.providerEndpoint,
            widget.bridge.blockchainFrom!.htlcAddress!,
            widget.bridge.blockchainFrom!.chainId,
          );

          final _statusEVM = await evmHTLC.getStatus();
          if (mounted) {
            setState(() {
              statusEVM = _statusEVM;
            });
          }

          final resultGetHTLCLockTime = await evmHTLC.getHTLCLockTime();
          resultGetHTLCLockTime.map(
            success: (_htlcLockTime) {
              if (mounted) {
                setState(() {
                  htlcLockTime = _htlcLockTime;
                });
              }
            },
            failure: (failure) {},
          );
        }
      }
      if (widget.bridge.blockchainTo != null &&
          widget.bridge.blockchainTo!.htlcAddress != null) {
        if (widget.bridge.blockchainTo!.isArchethic) {
          if (widget.bridge.blockchainTo!.providerEndpoint.isEmpty) {
            if (mounted) {
              setState(() {
                statusAE = -1;
              });
            }
          } else {
            final apiService = archethic.ApiService(
              widget.bridge.blockchainTo!.providerEndpoint,
            );
            try {
              final info = await ArchethicContract().getInfo(
                apiService,
                widget.bridge.blockchainTo!.htlcAddress!,
              );
              if (mounted) {
                setState(() {
                  statusAE = info.statusHTLC;
                });
              }
              // ignore: empty_catches
            } catch (e) {}
          }
        } else {
          final evmHTLC = EVMHTLC(
            widget.bridge.blockchainTo!.providerEndpoint,
            widget.bridge.blockchainTo!.htlcAddress!,
            widget.bridge.blockchainTo!.chainId,
          );

          final _statusEVM = await evmHTLC.getStatus();
          if (mounted) {
            setState(() {
              statusEVM = _statusEVM;
            });
          }
        }
      }

      if (statusEVM != null && statusEVM == 2 ||
          statusAE != null && statusAE == 2) {
        setState(() {
          isRefunded = true;
        });
      }

      // Archethic -> EVM
      if (widget.bridge.blockchainFrom != null &&
          widget.bridge.blockchainFrom!.isArchethic &&
          isRefunded == false &&
          (!(statusEVM != null &&
              statusEVM == 1 &&
              statusAE != null &&
              statusAE == 1))) {
        setState(() {
          canResume = true;
        });
      }
      // EVM -> Archethic
      final htlcLockTimeOver = htlcLockTime == null ||
          (htlcLockTime != null &&
              DateTime.fromMillisecondsSinceEpoch(
                htlcLockTime! * 1000,
              ).isAfter(DateTime.now()));
      if (widget.bridge.blockchainFrom != null &&
          widget.bridge.blockchainFrom!.isArchethic == false &&
          isRefunded == false &&
          htlcLockTimeOver &&
          (!(statusEVM != null &&
              statusEVM == 1 &&
              statusAE != null &&
              statusAE == 1))) {
        setState(() {
          canResume = true;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: aedappfm.SingleCard(
        cardContent: Align(
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
                            widget.bridge.timestampExec!,
                          ).toLocal(),
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.bodyMedium!,
                          ),
                        ),
                  ),
                  Row(
                    children: [
                      LocalHistoryCardOptionsDelete(bridge: widget.bridge),
                      LocalHistoryCardOptionsResume(
                        bridge: widget.bridge,
                        canResume: canResume,
                      ),
                      LocalHistoryCardOptionsRefund(
                        bridge: widget.bridge,
                        isRefunded: isRefunded,
                      ),
                      LocalHistoryCardOptionsLogs(bridge: widget.bridge),
                    ],
                  ),
                ],
              ),
              LocalHistoryCardStatusInfos(bridge: widget.bridge),
              LocalHistoryCardDirectionInfos(bridge: widget.bridge),
              LocalHistoryCardTrfInfos(bridge: widget.bridge),
              LocalHistoryCardHTLCInfos(
                bridge: widget.bridge,
                statusEVM: statusEVM,
                statusAE: statusAE,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
