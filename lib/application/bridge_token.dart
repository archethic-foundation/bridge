/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/model/bridge_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bridge_token.g.dart';

@riverpod
BridgeTokensRepository _bridgeTokensRepository(
  _BridgeTokensRepositoryRef ref,
) =>
    BridgeTokensRepository();

@riverpod
Future<List<BridgeToken>> _getTokensList(
  _GetTokensListRef ref,
) async {
  return ref.watch(_bridgeTokensRepositoryProvider).getTokensList();
}

class BridgeTokensRepository {
  Future<List<BridgeToken>> getTokensList() async {
    final tokensList = <BridgeToken>[
      const BridgeToken(
        name: 'Universal Coin',
        symbol: 'UCO',
      ),
      const BridgeToken(
        name: 'Ether',
        symbol: 'ETH',
        tokenAddress: '0x8a3d77e9d6968b780564936d15B09805827C21fa',
      ),
      const BridgeToken(
        name: 'Wrapped Ether',
        symbol: 'WETH',
        tokenAddress: '0x8a3d77e9d6968b780564936d15B09805827C21fa',
      ),
    ];
    return tokensList;
  }
}

abstract class BridgeTokensProviders {
  static final getTokensList = _getTokensListProvider;
}
