/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_history.dart';

abstract class BridgeHistoryRepository {
  Future<BridgeHistory?> fetchBridgeHistory();

  Future<List<Map<String, dynamic>>> fetchBridgesList({bool asc = true});

  Future<void> clearBridgesList();

  Future<void> addBridge({
    required Map<String, dynamic> bridge,
  });

  Future<void> setBridge({
    required Map<String, dynamic> bridge,
  });
}
