import 'package:aebridge/application/bridge_token.dart';
import 'package:aebridge/model/bridge_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenList extends ConsumerWidget {
  const TokenList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = ref.watch(
      BridgeTokensProviders.getTokensList,
    );

    return SizedBox(
      child: tokens.map(
        data: (data) {
          return _TokensList(tokens: data.value);
        },
        error: (error) => const SizedBox(
          height: 200,
        ),
        loading: (loading) => const Stack(
          children: [
            SizedBox(
              height: 200,
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

class _TokensList extends StatelessWidget {
  const _TokensList({required this.tokens});

  final List<BridgeToken> tokens;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        shrinkWrap: true,
        itemCount: tokens.length,
        itemBuilder: (BuildContext context, int index) {
          return _SingleToken(token: tokens[index])
              .animate(delay: (100 * index).ms)
              .fadeIn(duration: 500.ms, delay: 100.ms)
              .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
              .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad);
        },
      ),
    );
  }
}

class _SingleToken extends StatelessWidget {
  const _SingleToken({required this.token});

  final BridgeToken token;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context, token);
        },
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: Center(
                child: Text(
                  token.symbol,
                  style: const TextStyle(
                    fontSize: 6,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      '${token.name} ',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                Text(
                  token.symbol,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
