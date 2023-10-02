/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/main_screen/header.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarMainScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMainScreen({
    super.key,
    required this.onAEMenuTapped,
  });

  final Function() onAEMenuTapped;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: const Header(),
      leadingWidth: 150,
      actions: [
        PopupMenuButton(
          offset: const Offset(0, 50),
          icon: const Icon(Iconsax.message_question),
          onSelected: (selectedIndex) {
            var url = '';
            if (selectedIndex == 0) {
              url = 'https://wiki.archethic.net';
            } else if (selectedIndex == 1) {
              url = 'https://github.com/archethic-foundation/bridge';
            } else if (selectedIndex == 2) {
              url = 'https://wiki.archethic.net/category/FAQ';
            } else if (selectedIndex == 3) {
              url = 'https://wiki.archethic.net/';
            }

            launchUrl(
              Uri.parse(
                url,
              ),
            );
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 0,
              child: Row(
                children: [
                  const Icon(
                    Iconsax.document_text,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(AppLocalizations.of(context)!.menu_documentation),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Iconsax.export_3,
                    size: 12,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  const Icon(
                    Iconsax.code_circle,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(AppLocalizations.of(context)!.menu_sourceCode),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Iconsax.export_3,
                    size: 12,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Row(
                children: [
                  const Icon(
                    Iconsax.message_question,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(AppLocalizations.of(context)!.menu_faq),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Iconsax.export_3,
                    size: 12,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 3,
              child: Row(
                children: [
                  const Icon(
                    Iconsax.video_play,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(AppLocalizations.of(context)!.menu_tuto),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Iconsax.export_3,
                    size: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        IconButton(
          icon: const Icon(Iconsax.element_3),
          onPressed: onAEMenuTapped,
        ),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
