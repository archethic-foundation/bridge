import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NavigationIndex { bridge, localHistory, refund }

final navigationIndexMainScreenProvider =
    StateProvider.autoDispose<NavigationIndex>((ref) => NavigationIndex.bridge);
