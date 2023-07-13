import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/model/bridge_blockchain.dart';
import 'package:aebridge/ui/views/blockchain_selection/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class BlockchainList extends ConsumerWidget {
  const BlockchainList({
    required this.blockchainsExcluded,
    this.env,
    super.key,
  });

  final List<String> blockchainsExcluded;
  final String? env;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockchains = ref.watch(
      BridgeBlockchainsProviders.getBlockchainsList,
    );

    return SizedBox(
      child: blockchains.map(
        data: (data) {
          if (blockchainsExcluded.isNotEmpty) {
            if (env != null) {
              data.value.removeWhere(
                (element) => element.env != env,
              );
            }
            if (blockchainsExcluded.contains('Archethic') == false) {
              data.value.removeWhere(
                (element) => element.name.contains('Archethic') == false,
              );
            } else {
              data.value.removeWhere(
                (element) => element.name.contains('Archethic'),
              );
            }
          }

          final blockchainSelectionProvider = ref
              .watch(BlockchainSelectionFormProvider.blockchainSelectionForm);
          if (blockchainSelectionProvider.testnetIncluded == false) {
            data.value.removeWhere(
              (element) => element.env != '1-mainnet',
            );
          }
          return _BlockchainsList(blockchains: data.value);
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
  const _BlockchainsList({required this.blockchains});

  final List<BridgeBlockchain> blockchains;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        shrinkWrap: true,
        itemCount: blockchains.length,
        itemBuilder: (BuildContext context, int index) {
          return _SingleBlockchain(blockchain: blockchains[index])
              .animate(delay: (100 * index).ms)
              .fadeIn(duration: 500.ms, delay: 100.ms)
              .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
              .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad);
        },
      ),
    );
  }
}

class _SingleBlockchain extends StatelessWidget {
  const _SingleBlockchain({required this.blockchain});

  final BridgeBlockchain blockchain;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context, blockchain);
        },
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              'assets/images/bc-logos/${blockchain.icon}',
              height: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${blockchain.name} ',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
