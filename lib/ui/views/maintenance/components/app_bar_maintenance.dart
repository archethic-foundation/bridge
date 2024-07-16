import 'package:aebridge/ui/views/main_screen/layouts/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarMaintenance extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const AppBarMaintenance({
    super.key,
  });
  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  ConsumerState<AppBarMaintenance> createState() => _AppBarMaintenanceState();
}

class _AppBarMaintenanceState extends ConsumerState<AppBarMaintenance> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Header(withMenu: false),
        leadingWidth: MediaQuery.of(context).size.width,
      ),
    );
  }
}
