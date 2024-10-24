/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_blockchain_environment.dart';
import 'package:aebridge/ui/views/blockchain_selection/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class BlockchainList extends ConsumerWidget {
  const BlockchainList({
    required this.isFrom,
    super.key,
  });

  final bool isFrom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockchains = ref.watch(
      getBlockchainsListProvider,
    );
    final blockchainSelectionProvider = ref.watch(
      BlockchainSelectionFormProvider.blockchainSelectionForm,
    );

    return SizedBox(
      child: blockchains.map(
        data: (data) {
          final filteredChains = [...data.value];
          if (blockchainSelectionProvider.testnetIncluded == false) {
            filteredChains.removeWhere(
              (element) => element.env != BridgeBlockchainEnvironment.mainnet,
            );
          }

          final otherBlockchain = isFrom
              ? ref.watch(
                  bridgeFormNotifierProvider
                      .select((bridge) => bridge.blockchainTo),
                )
              : ref.watch(
                  bridgeFormNotifierProvider
                      .select((bridge) => bridge.blockchainFrom),
                );

          if (otherBlockchain != null) {
            filteredChains.removeWhere(
              (element) =>
                  element.env == otherBlockchain.env &&
                  element.name == otherBlockchain.name,
            );
          }

          return _BlockchainsList(isFrom: isFrom, blockchains: filteredChains);
        },
        error: (error) => const SizedBox(
          height: 300,
        ),
        loading: (loading) => const Stack(
          children: [
            SizedBox(
              height: 300,
            ),
            SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlockchainsList extends StatelessWidget {
  const _BlockchainsList({required this.isFrom, required this.blockchains});

  final List<BridgeBlockchain> blockchains;
  final bool isFrom;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        shrinkWrap: true,
        itemCount: blockchains.length,
        itemBuilder: (BuildContext context, int index) {
          return _SingleBlockchain(
            isFrom: isFrom,
            blockchain: blockchains[index],
          );
        },
      ),
    );
  }
}

class _SingleBlockchain extends ConsumerWidget {
  const _SingleBlockchain({required this.isFrom, required this.blockchain});
  final bool isFrom;
  final BridgeBlockchain blockchain;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          context.pop(blockchain);
        },
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              'assets/images/bc-logos/${blockchain.icon}',
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                '${blockchain.name} ',
                style: Theme.of(context).textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
