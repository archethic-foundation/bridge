/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/model/hive/bridge.dart';
import 'package:aebridge/model/hive/db_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'bridge_history.freezed.dart';
part 'bridge_history.g.dart';

/// Next field available : 1

@freezed
class BridgeHistory with _$BridgeHistory {
  @HiveType(typeId: HiveTypeIds.bridgeHistory)
  const factory BridgeHistory({
    @HiveField(0) List<Bridge>? bridgeList,
  }) = _BridgeHistory;
  const BridgeHistory._();
}
