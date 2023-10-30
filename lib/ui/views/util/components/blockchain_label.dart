/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class BlockchainLabel extends ConsumerWidget {
  const BlockchainLabel({
    required this.chainId,
    super.key,
  });

  final int chainId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(BridgeBlockchainsProviders.getBlockchainFromChainId(chainId))
        .when(
      data: (data) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/bc-logos/${data!.icon}',
              width: 15,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              data.name,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return const SizedBox.shrink();
      },
      loading: () {
        return const SizedBox.shrink();
      },
    );
  }
}
