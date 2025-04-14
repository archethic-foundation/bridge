import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'blockchain_tx_version.g.dart';

@riverpod
Future<int> blockchainTxCurrentVersion(Ref ref) async {
  const defaultVersion = 4;
  final apiService = aedappfm.sl.get<ApiService>();
  final blockchainVersion = await apiService.getBlockchainVersion();
  return int.tryParse(blockchainVersion.version.transaction) ?? defaultVersion;
}
