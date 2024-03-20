/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aebridge/application/preferences.dart';
import 'package:aebridge/ui/views/main_screen/layouts/privacy_popup.dart';

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
  final thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.only(top: 20, right: 20),
        ),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
          Colors.transparent,
        ),
        shape: MaterialStateProperty.all(
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
                  'https://wiki.archethic.net',
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
        // TODO(reddwarf03): Put LogManager in a notifier
        if (aedappfm.sl.isRegistered<aedappfm.LogManager>())
          MenuItemButton(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Icon(
                    aedappfm.Iconsax.menu_board,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.menu_logs_activated,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      FutureBuilder<bool>(
                        future: ref
                            .watch(
                              PreferencesProviders.preferencesRepository,
                            )
                            .isLogsActived(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              height: 20,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                  thumbIcon: thumbIcon,
                                  value: snapshot.data!,
                                  onChanged: (value) {
                                    ref
                                        .read(
                                          PreferencesProviders
                                              .preferencesRepository,
                                        )
                                        .setLogsActived(value);
                                    aedappfm.sl
                                        .get<aedappfm.LogManager>()
                                        .logsActived = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        child: const Icon(
                          Icons.help_outline_outlined,
                          size: 14,
                        ),
                        onTap: () {
                          Future.delayed(Duration.zero, () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const PrivacyPopup();
                              },
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onPressed: () {
              launchUrl(
                Uri.parse(
                  'https://www.archethic.net/privacy-policy-bridge',
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
                'https://www.archethic.net/privacy-policy-bridge',
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
