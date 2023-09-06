/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/infrastructure/bridge_history.hive.dto.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBridgeDatasource {
  HiveBridgeDatasource._(this._bridgeHistoryBox);

  final LazyBox<BridgeHistoryHiveDTO> _bridgeHistoryBox;
  static const bridgeHistoryKey = 'bridgeHistory';
  static const bridgeHistoryBoxName = 'bridgeHistory';

  static Future<HiveBridgeDatasource> getInstance() async {
    final box = await Hive.openLazyBox<BridgeHistoryHiveDTO>(
      bridgeHistoryBoxName,
    );
    return HiveBridgeDatasource._(box);
  }

  Future<BridgeHistoryHiveDTO?> getBridgeHistory() async =>
      _bridgeHistoryBox.get(bridgeHistoryKey);

  Future<void> setBridgeHistory({
    required BridgeHistoryHiveDTO bridgeHistory,
  }) async {
    await _bridgeHistoryBox.put(
      bridgeHistoryKey,
      bridgeHistory,
    );
  }

  Future<void> clearBridgesList() async {
    var bridgeHistory = await getBridgeHistory();
    if (bridgeHistory != null) {
      bridgeHistory = bridgeHistory.copyWith(
        bridgeList: [],
      );
      await _bridgeHistoryBox.put(
        bridgeHistoryKey,
        bridgeHistory,
      );
    }
  }

  Future<void> clear() async {
    await _bridgeHistoryBox.clear();
  }
}
