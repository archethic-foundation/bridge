import 'package:aebridge/ui/views/main_screen/layouts/header.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarWelcome extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const AppBarWelcome({
    super.key,
    required this.onAEMenuTapped,
  });
  final Function() onAEMenuTapped;
  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  ConsumerState<AppBarWelcome> createState() => _AppBarWelcomeState();
}

class _AppBarWelcomeState extends ConsumerState<AppBarWelcome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.2),
            height: 1,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Header(withMenu: false),
        leadingWidth: MediaQuery.of(context).size.width,
        actions: [
          IconButton(
            icon: const Icon(aedappfm.Iconsax.element_3),
            onPressed: widget.onAEMenuTapped,
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
