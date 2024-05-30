/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/bridge_token.dart';
import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:aebridge/ui/views/util/token_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenList extends ConsumerWidget {
  const TokenList({this.direction, super.key});

  final String? direction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = ref.watch(
      BridgeTokensProviders.getTokensListPerBridge(direction!),
    );

    return SizedBox(
      child: tokens.map(
        data: (data) {
          return _TokensList(tokens: data.value);
        },
        error: (error) => const SizedBox.shrink(),
        loading: (loading) => const Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
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
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        shrinkWrap: true,
        itemCount: tokens.length,
        itemBuilder: (BuildContext context, int index) {
          return _SingleToken(token: tokens[index]);
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
            TokenIcon(
              symbol: token.symbol,
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
