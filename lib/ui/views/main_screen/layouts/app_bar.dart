import 'package:aebridge/ui/views/main_screen/layouts/app_bar_menu_info.dart';
import 'package:aebridge/ui/views/main_screen/layouts/app_bar_menu_links.dart';
import 'package:aebridge/ui/views/main_screen/layouts/connection_to_wallet_status.dart';
import 'package:aebridge/ui/views/main_screen/layouts/header.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarMainScreen extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const AppBarMainScreen({
    super.key,
  });

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  ConsumerState<AppBarMainScreen> createState() => _AppBarMainScreenState();
}

class _AppBarMainScreenState extends ConsumerState<AppBarMainScreen> {
  final thumbIcon = WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Header(),
        leadingWidth: MediaQuery.of(context).size.width,
        actions: const [
          ConnectionToWalletStatus(),
          SizedBox(
            width: 10,
          ),
          AppBarMenuInfo(),
          AppBarMenuLinks(),
          SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
