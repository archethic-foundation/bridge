/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreenWidgetDisplayed extends StateNotifier<Widget> {
  MainScreenWidgetDisplayed() : super(const BridgeSheet());

  void setWidget(Widget newWidget) {
    state = SizedBox(child: newWidget);
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
