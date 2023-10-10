/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/local_history/local_history_sheet.dart';
import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreenWidgetDisplayed extends StateNotifier<Widget> {
  MainScreenWidgetDisplayed() : super(const BridgeSheet());

  // ignore: use_setters_to_change_properties
  void setWidget(Widget newWidget, WidgetRef ref) {
    state = newWidget;

    if (newWidget is BridgeSheet) {
      ref.read(navigationIndexMainScreenProvider.notifier).state = 0;
    } else if (newWidget is LocalHistorySheet) {
      ref.read(navigationIndexMainScreenProvider.notifier).state = 1;
    } else if (newWidget is RefundSheet) {
      ref.read(navigationIndexMainScreenProvider.notifier).state = 2;
    }
  }
}

final _mainScreenWidgetDisplayedProvider =
    StateNotifierProvider<MainScreenWidgetDisplayed, Widget>(
  (ref) => MainScreenWidgetDisplayed(),
);

abstract class MainScreenWidgetDisplayedProviders {
  static final mainScreenWidgetDisplayedProvider =
      _mainScreenWidgetDisplayedProvider;
}
