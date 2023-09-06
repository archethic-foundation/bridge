/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class Session with _$Session {
  const factory Session({
    BridgeWallet? walletFrom,
    BridgeWallet? walletTo,
  }) = _Session;
  const Session._();

  bool get allWalletsIsConnected =>
      walletFrom != null &&
      walletTo != null &&
      walletFrom!.isConnected &&
      walletTo!.isConnected;

  String get error {
    if (walletFrom != null && walletFrom!.error.isNotEmpty) {
      return walletFrom!.error;
    }
    if (walletTo != null && walletTo!.error.isNotEmpty) {
      return walletTo!.error;
    }
    return '';
  }
}
