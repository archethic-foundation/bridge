import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationIndexMainScreenProvider =
    StateProvider.autoDispose<int>((ref) => 0);
final isLoadingScreenProvider = StateProvider.autoDispose<bool>((ref) => false);
