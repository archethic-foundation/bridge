/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/model/hive/db_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'bridge_token.freezed.dart';
part 'bridge_token.g.dart';

/// Next field available : 8

@freezed
class BridgeToken with _$BridgeToken {
  @HiveType(typeId: HiveTypeIds.bridgeToken)
  const factory BridgeToken({
    @HiveField(0) String? name,
    @HiveField(1) String? tokenAddress,
    @HiveField(2) String? symbol,
    @HiveField(3) String? targetTokenName,
    @HiveField(4) String? targetTokenSymbol,
    @HiveField(5) String? poolAddressFrom,
    @HiveField(6) String? poolAddressTo,
    @HiveField(7) String? type,
  }) = _BridgeToken;
  const BridgeToken._();
}
