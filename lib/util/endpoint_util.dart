/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class EndpointUtil {
  static String getEnvironnement() {
    final endpointUrl = sl.get<ApiService>().endpoint;
    switch (endpointUrl) {
      case 'https://testnet.archethic.net':
        return 'testnet';
      case 'https://mainnet.archethic.net':
        return 'mainnet';
      default:
        return 'local';
    }
  }
}
