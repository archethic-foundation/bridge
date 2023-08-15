/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/repositories/datasources/secured_datasource_mixin.dart';
import 'package:aebridge/model/hive/bridge_history.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBridgeDatasource with SecuredHiveMixin {
  HiveBridgeDatasource._(this._bridgeHistoryBox);

  final LazyBox<BridgeHistory> _bridgeHistoryBox;
  static const bridgeHistoryKey = 'bridgeHistory';
  static const bridgeHistoryBoxName = 'bridgeHistory';

  static Future<HiveBridgeDatasource> getInstance() async {
    final encryptedBox =
        await SecuredHiveMixin.openLazySecuredBox<BridgeHistory>(
      bridgeHistoryBoxName,
    );
    return HiveBridgeDatasource._(encryptedBox);
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

  Future<void> clear() async {
    await _bridgeHistoryBox.clear();
  }
}
