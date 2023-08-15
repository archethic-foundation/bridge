/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/model/hive/bridge_token.dart';
import 'package:aebridge/model/hive/db_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'bridge.freezed.dart';
part 'bridge.g.dart';

/// Next field available : 6

@freezed
class Bridge with _$Bridge {
  @HiveType(typeId: HiveTypeIds.bridge)
  const factory Bridge({
    @HiveField(0) int? blockchainChainIdFrom,
    @HiveField(1) int? blockchainChainIdTo,
    @HiveField(2) BridgeToken? tokenToBridge,
    @HiveField(3) double? tokenToBridgeAmount,
    @HiveField(4) String? targetAddress,
    @HiveField(5) int? timestampExec,
  }) = _Bridge;
  const Bridge._();
}
