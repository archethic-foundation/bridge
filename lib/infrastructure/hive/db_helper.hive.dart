/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/infrastructure/bridge_history.hive.dto.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveTypeIds {
  static const bridge = 0;
  static const bridgeToken = 1;
  static const bridgeHistory = 2;
}

class DBHelper {
  static Future<void> setupDatabase() async {
    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      final suppDir = await getApplicationSupportDirectory();
      Hive.init(suppDir.path);
    }

    Hive.registerAdapter(BridgeHistoryHiveDTOImplAdapter());
  }
}
