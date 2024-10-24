/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';
import 'package:aebridge/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarMenuInfo extends ConsumerStatefulWidget {
  const AppBarMenuInfo({
    super.key,
  });

  @override
  ConsumerState<AppBarMenuInfo> createState() => _AppBarMenuInfoState();
}

class _AppBarMenuInfoState extends ConsumerState<AppBarMenuInfo> {
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
    return MenuAnchor(
      style: MenuStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.only(top: 20, right: 20),
        ),
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all(
          Colors.transparent,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      alignmentOffset: const Offset(0, 2),
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.info_outlined),
        );
      },
      menuChildren: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: MenuItemButton(
            child: Container(
              width: 280,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Icon(
                    aedappfm.Iconsax.document_text,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.menu_documentation,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    aedappfm.Iconsax.export_3,
                    size: 12,
                  ),
                ],
              ),
            ),
            onPressed: () {
              launchUrl(
                Uri.parse(
                  'https://wiki.archethic.net/participate/bridge/',
                ),
              );
            },
          ),
        ),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  aedappfm.Iconsax.code_circle,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.menu_sourceCode,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  aedappfm.Iconsax.export_3,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () {
            launchUrl(
              Uri.parse(
                'https://github.com/archethic-foundation/bridge',
              ),
            );
          },
        ),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  aedappfm.Iconsax.message_question,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(AppLocalizations.of(context)!.menu_faq),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  aedappfm.Iconsax.export_3,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () {
            launchUrl(
              Uri.parse(
                'https://wiki.archethic.net/FAQ/bridge-2-ways',
              ),
            );
          },
        ),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  aedappfm.Iconsax.video_play,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(AppLocalizations.of(context)!.menu_tuto),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  aedappfm.Iconsax.export_3,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () {
            launchUrl(
              Uri.parse(
                'https://wiki.archethic.net/participate/bridge/usage/bridge-front',
              ),
            );
          },
        ),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  aedappfm.Iconsax.shield_tick,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.menu_privacy_policy,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  aedappfm.Iconsax.export_3,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () {
            launchUrl(
              Uri.parse(
                kURIPrivacyPolicy,
              ),
            );
          },
        ),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  aedappfm.Iconsax.archive_book,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.menu_terms_of_use,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  aedappfm.Iconsax.export_3,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () {
            launchUrl(
              Uri.parse(
                kURITermsOfUse,
              ),
            );
          },
        ),
        MenuItemButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  aedappfm.Iconsax.reserve,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(AppLocalizations.of(context)!.menu_report_bug),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  aedappfm.Iconsax.export_3,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () {
            launchUrl(
              Uri.parse(
                'https://github.com/archethic-foundation/bridge/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml',
              ),
            );
          },
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 12,
          ),
          child: Consumer(
            builder: (context, ref, child) {
              final asyncVersionString = ref.watch(
                aedappfm.versionStringProvider(
                  aedappfm.AppLocalizations.of(context)!,
                ),
              );
              return SelectableText(
                asyncVersionString.asData?.value ?? '',
                style: Theme.of(context).textTheme.labelSmall,
              );
            },
          ),
        ),
      ],
    );
  }
}
