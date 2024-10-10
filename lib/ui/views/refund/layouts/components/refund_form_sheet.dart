import 'package:aebridge/ui/views/refund/layouts/components/refund_blockchain_selection.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_btn.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_can_refund_info.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_connect_wallet_btn.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_infos.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_infos_wallet.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_message.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_textfield_contract_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundFormSheet extends ConsumerWidget {
  const RefundFormSheet({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RefundInfo(),
        SizedBox(
          height: 10,
        ),
        RefundBlockchainSelection(),
        SizedBox(
          height: 10,
        ),
        RefundContractAddress(),
        RefundInfosWallet(),
        RefundCanRefundInfo(),
        SizedBox(
          height: 20,
        ),
        Spacer(),
        RefundMessage(),
        SizedBox(
          height: 20,
        ),
        //RefundTransaction(),
        RefundConnectWalletButton(),
        RefundButton(),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
