/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreenWidgetDiplayed extends StateNotifier<Widget> {
  MainScreenWidgetDiplayed() : super(const BridgeSheet());

  void setWidget(Widget newWidget) {
    state = SizedBox(child: newWidget);
  }
}

final _mainScreenWidgetDiplayedProvider =
    StateNotifierProvider<MainScreenWidgetDiplayed, Widget>(
  (ref) => MainScreenWidgetDiplayed(),
);

abstract class MainScreenWidgetDiplayedProviders {
  static final mainScreenWidgetDiplayedProvider =
      _mainScreenWidgetDiplayedProvider;
}
