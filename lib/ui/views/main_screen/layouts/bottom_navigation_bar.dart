import 'dart:ui';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/local_history/local_history_sheet.dart';
import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarMainScreen extends ConsumerStatefulWidget {
  const BottomNavigationBarMainScreen({
    super.key,
    required this.navDrawerIndex,
    required this.listNavigationLabelIcon,
  });

  final int navDrawerIndex;
  final List<(String, IconData)> listNavigationLabelIcon;

  @override
  ConsumerState<BottomNavigationBarMainScreen> createState() =>
      _BottomNavigationBarMainScreenState();
}

class _BottomNavigationBarMainScreenState
    extends ConsumerState<BottomNavigationBarMainScreen> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: widget.listNavigationLabelIcon
              .map(
                (item) => BottomNavigationBarItem(
                  label: item.$1,
                  icon: Icon(item.$2),
                ),
              )
              .toList(),
          currentIndex: widget.navDrawerIndex,
          onTap: (int selectedIndex) {
            setState(() {
              ref
                  .read(
                    navigationIndexMainScreenProvider.notifier,
                  )
                  .state = selectedIndex;
            });
            switch (selectedIndex) {
              case 0:
                context.go(BridgeSheet.routerPage);
                break;
              case 1:
                context.go(LocalHistorySheet.routerPage);
                break;
              case 2:
                context.go(RefundSheet.routerPage);
                break;
              default:
                break;
            }
          },
        ),
      ),
    );
  }
}
