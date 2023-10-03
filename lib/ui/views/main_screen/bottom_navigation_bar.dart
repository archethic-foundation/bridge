import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationBarMainScreen extends ConsumerStatefulWidget {
  BottomNavigationBarMainScreen({
    super.key,
    required this.navDrawerIndex,
    required this.listNavigationLabelIcon,
    required this.onDestinationSelected,
  });

  int navDrawerIndex = 0;
  List<(String, IconData)> listNavigationLabelIcon;
  Function(int) onDestinationSelected;

  @override
  ConsumerState<BottomNavigationBarMainScreen> createState() =>
      _BottomNavigationBarMainScreenState();
}

class _BottomNavigationBarMainScreenState
    extends ConsumerState<BottomNavigationBarMainScreen> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: widget.listNavigationLabelIcon
          .map(
            (item) => BottomNavigationBarItem(
              label: item.$1,
              icon: Icon(item.$2),
            ),
          )
          .toList(),
      currentIndex: widget.navDrawerIndex,
      onTap: widget.onDestinationSelected,
    );
  }
}
