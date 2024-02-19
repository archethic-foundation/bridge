import 'dart:async';

import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeFinalAmount extends ConsumerStatefulWidget {
  const BridgeFinalAmount({
    super.key,
    required this.address,
    required this.isUCO,
    required this.to,
  });

  final String address;
  final bool isUCO;
  final String to;

  @override
  ConsumerState<BridgeFinalAmount> createState() => _BridgeFinalAmountState();
}

class _BridgeFinalAmountState extends ConsumerState<BridgeFinalAmount>
    with aedappfm.TransactionMixin {
  double? finalAmount;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      try {
        final amount = await getAmountFromTx(
          widget.address,
          widget.isUCO,
          widget.to,
          withLastAddress: true,
        );
        if (amount > 0) {
          setState(() {
            finalAmount = amount;
          });
          unawaited(refreshCurrentAccountInfoWallet());
          timer?.cancel();
        }
        // ignore: empty_catches
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.bridgeOk == false) return const SizedBox.shrink();

    return finalAmount != null
        ? SelectableText(
            'Amount bridged: ${finalAmount!.formatNumber(precision: 8)} ${bridge.tokenToBridge!.targetTokenSymbol}',
          )
        : const Row(
            children: [
              SelectableText(
                'Amount bridged: ',
              ),
              SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ],
          );
  }
}
