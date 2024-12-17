import 'dart:developer';

import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_direction_infos.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_htlc_infos.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options_delete.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options_logs.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options_refund.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_options_resume.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_status_infos.dart';
import 'package:aebridge/ui/views/local_history/components/local_history_card_trf_infos.dart';
import 'package:aebridge/ui/views/util/card_options_support.dart';
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
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    await Future.wait([
      _fetchBlockchainInfo(widget.bridge.blockchainFrom, isFrom: true),
      _fetchBlockchainInfo(widget.bridge.blockchainTo, isFrom: false),
    ]);

    _evaluateResumeConditions();
  }

  Future<void> _fetchBlockchainInfo(
    BridgeBlockchain? blockchain, {
    required bool isFrom,
  }) async {
    if (blockchain == null || blockchain.htlcAddress == null) return;

    if (blockchain.isArchethic) {
      await _fetchArchethicInfo(blockchain, isFrom);
    } else {
      await _fetchEVMInfo(blockchain, isFrom);
    }
  }

  Future<void> _fetchArchethicInfo(
      BridgeBlockchain blockchain, bool isFrom) async {
    if (blockchain.providerEndpoint.isEmpty) {
      if (mounted) setState(() => statusAE = -1);
      return;
    }

    final apiService = archethic.ApiService(blockchain.providerEndpoint);

    try {
      final info = await ArchethicContract().getInfo(
        apiService,
        blockchain.htlcAddress!,
      );
      if (mounted) setState(() => statusAE = info.statusHTLC ?? -1);
    } catch (e) {
      log('Error fetching Archethic status: $e');
    }

    if (isFrom) {
      try {
        final htlcInfo = await ArchethicContract().getHTLCInfo(
          apiService,
          blockchain.htlcAddress!,
        );
        if (mounted) setState(() => htlcLockTime = htlcInfo.endTime ?? 0);
      } catch (e) {
        log('Error fetching Archethic HTLC info: $e');
      }
    }
  }

  Future<void> _fetchEVMInfo(BridgeBlockchain blockchain, bool isFrom) async {
    final evmHTLC = EVMHTLC(blockchain.htlcAddress!);
    final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
    await evmWalletProvider.connect(blockchain);

    try {
      final _statusEVM = await evmHTLC.getStatus(
        chainId: blockchain.chainId,
      );
      if (mounted) setState(() => statusEVM = _statusEVM);
    } catch (e) {
      log('Error fetching EVM status: $e');
    }

    if (isFrom) {
      try {
        final result = await evmHTLC.getHTLCLockTime();
        result.map(
          success: (_htlcLockTime) {
            if (mounted) setState(() => htlcLockTime = _htlcLockTime);
          },
          failure: (failure) => log('Error fetching HTLC lock time: $failure'),
        );
      } catch (e) {
        log('Error fetching EVM HTLC info: $e');
      }
    }
  }

  void _evaluateResumeConditions() {
    final htlcLockTimeOver = htlcLockTime != 0 &&
        htlcLockTime != null &&
        DateTime.fromMillisecondsSinceEpoch(htlcLockTime! * 1000)
            .isBefore(DateTime.now());

    if (statusEVM == 2 || statusAE == 2) {
      setState(() => isRefunded = true);
    } else {
      if ((!htlcLockTimeOver &&
              ((statusEVM == null || statusEVM == 0 || statusEVM == -1) &&
                  (statusAE == null || statusAE == 0 || statusAE == -1))) ||
          ((statusEVM == 1 && statusAE == 0) ||
              (statusEVM == 0 && statusAE == 1))) {
        setState(() => canResume = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isAppMobileFormat = aedappfm.Responsive.isMobile(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: aedappfm.SingleCard(
        decorationColor: aedappfm.AppThemeBase.sheetBackgroundTertiary,
        decorationBorderColor: aedappfm.AppThemeBase.sheetBorderTertiary,
        globalPadding: 10,
        cardContent: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimestamp(context),
              LocalHistoryCardStatusInfos(bridge: widget.bridge),
              _line(context, isAppMobileFormat),
              LocalHistoryCardDirectionInfos(bridge: widget.bridge),
              _line(context, isAppMobileFormat),
              LocalHistoryCardTrfInfos(bridge: widget.bridge),
              _line(context, isAppMobileFormat),
              LocalHistoryCardHTLCInfos(
                bridge: widget.bridge,
                statusEVM: statusEVM,
                statusAE: statusAE,
              ),
              _line(context, isAppMobileFormat),
              _buildOptions(context, isAppMobileFormat),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimestamp(BuildContext context) {
    final isAppMobileFormat = aedappfm.Responsive.isMobile(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat.yMd(Localizations.localeOf(context).languageCode)
              .add_Hms()
              .format(DateTime.fromMillisecondsSinceEpoch(
                widget.bridge.timestampExec!,
              ).toLocal()),
          style: isAppMobileFormat
              ? Theme.of(context).textTheme.bodyMedium
              : Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                      context,
                      Theme.of(context).textTheme.bodyMedium!,
                    ),
                  ),
        ),
      ],
    );
  }

  Widget _buildOptions(BuildContext context, bool isAppMobileFormat) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: isAppMobileFormat
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LocalHistoryCardOptionsResume(
                      bridge: widget.bridge,
                      canResume: canResume,
                    ),
                    LocalHistoryCardOptionsRefund(
                      bridge: widget.bridge,
                      isRefunded: isRefunded,
                    ),
                    const CardOptionsSupport(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LocalHistoryCardOptionsLogs(
                      bridge: widget.bridge,
                    ),
                    LocalHistoryCardOptionsDelete(
                      bridge: widget.bridge,
                    ),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LocalHistoryCardOptionsResume(
                  bridge: widget.bridge,
                  canResume: canResume,
                ),
                const SizedBox(width: 10),
                LocalHistoryCardOptionsRefund(
                  bridge: widget.bridge,
                  isRefunded: isRefunded,
                ),
                const SizedBox(width: 10),
                const CardOptionsSupport(),
                const SizedBox(width: 10),
                LocalHistoryCardOptionsLogs(bridge: widget.bridge),
                const SizedBox(width: 10),
                LocalHistoryCardOptionsDelete(bridge: widget.bridge),
              ],
            ),
    );
  }

  Widget _line(BuildContext context, bool isAppMobileFormat) {
    return isAppMobileFormat
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              decoration: BoxDecoration(
                gradient: aedappfm.AppThemeBase.gradient,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
