/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/model/hive/bridge.dart';
import 'package:aebridge/model/hive/bridge_history.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBridgeDatasource {
  HiveBridgeDatasource._(this._bridgeHistoryBox);

  final LazyBox<BridgeHistory> _bridgeHistoryBox;
  static const bridgeHistoryKey = 'bridgeHistory';
  static const bridgeHistoryBoxName = 'bridgeHistory';

  static Future<HiveBridgeDatasource> getInstance() async {
    final box = await Hive.openLazyBox<BridgeHistory>(
      bridgeHistoryBoxName,
    );
    return HiveBridgeDatasource._(box);
  }

  Future<BridgeHistory?> getBridgeHistory() async =>
      _bridgeHistoryBox.get(bridgeHistoryKey);

  Future<void> addBridgeHistory({
    required BridgeHistory bridgeHistory,
  }) async {
    await _bridgeHistoryBox.put(
      bridgeHistoryKey,
      bridgeHistory,
    );
  }

  Future<void> addBridge({
    required Bridge bridge,
  }) async {
    var bridgeHistory = await getBridgeHistory();
    if (bridgeHistory != null) {
      if (bridgeHistory.bridgeList == null) {
        final bridgeList = <Bridge>[bridge];
        bridgeHistory.bridgeList!.addAll(bridgeList);
      } else {
        bridgeHistory = bridgeHistory
            .copyWith(bridgeList: [...bridgeHistory.bridgeList!, bridge]);
      }
      await _bridgeHistoryBox.put(
        bridgeHistoryKey,
        bridgeHistory,
      );
    } else {
      await _bridgeHistoryBox.put(
        bridgeHistoryKey,
        BridgeHistory(bridgeList: <Bridge>[bridge]),
      );
    }
  }

  Future<void> setBridge({
    required Bridge bridge,
  }) async {
    var bridgeHistory = await getBridgeHistory();
    if (bridgeHistory == null ||
        bridgeHistory.bridgeList == null ||
        bridgeHistory.bridgeList!.isEmpty) {
      throw Exception("Bridge can't be updated in the box");
    }
    final bridgeList = bridgeHistory.bridgeList;
    bridgeList!
      ..removeWhere((element) => element.timestampExec == bridge.timestampExec)
      ..add(bridge);
    bridgeHistory = bridgeHistory.copyWith(bridgeList: bridgeList);
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
