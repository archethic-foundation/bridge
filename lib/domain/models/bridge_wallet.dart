/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:archethic_wallet_client/archethic_wallet_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bridge_wallet.freezed.dart';

const kEVMWallet = 'evmWallet';
const kArchethicWallet = 'archethic';

@freezed
class BridgeWallet with _$BridgeWallet {
  const factory BridgeWallet({
    @Default('') String wallet,
    @Default('') String endpoint,
    @Default('') String nameAccount,
    @Default('') String oldNameAccount,
    @Default('') String genesisAddress,
    @Default('') String error,
    @Default('') String env,
    String? providerEndpoint,
    @Default(false) bool isConnected,
    Subscription<Account>? accountSub,
    StreamSubscription<Account>? accountStreamSub,
  }) = _BridgeWallet;

  const BridgeWallet._();

  String get nameAccountDisplayed {
    if (wallet == kEVMWallet) {
      return '${nameAccount.substring(0, 7)}...${nameAccount.substring(nameAccount.length - 4, nameAccount.length)}';
    }
    return nameAccount;
  }
}
