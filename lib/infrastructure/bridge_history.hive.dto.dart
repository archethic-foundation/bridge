/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_history.dart';
import 'package:aebridge/infrastructure/hive/db_helper.hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'bridge_history.hive.dto.freezed.dart';
part 'bridge_history.hive.dto.g.dart';

/// Next field available : 1

@freezed
class BridgeHistoryHiveDTO with _$BridgeHistoryHiveDTO {
  @HiveType(typeId: HiveTypeIds.bridgeHistory)
  const factory BridgeHistoryHiveDTO({
    @HiveField(0) List<Map<String, dynamic>>? bridgeList,
  }) = _BridgeHistoryHiveDTO;
  const BridgeHistoryHiveDTO._();
}

extension BridgeHistoryHiveDTOConversion on BridgeHistory {
  BridgeHistoryHiveDTO get toDTO => BridgeHistoryHiveDTO(
        bridgeList: bridgeList,
      );
}

extension BridgeHistoryConversion on BridgeHistoryHiveDTO {
  BridgeHistory get toModel => BridgeHistory(
        bridgeList: bridgeList,
      );
}
