import 'dart:ui';

import 'package:aebridge/ui/views/local_history/local_history_sheet.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:aebridge/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class TroublesPopup extends ConsumerWidget {
  const TroublesPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent.withAlpha(120),
        body: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: aedappfm.AppThemeBase.sheetBackground,
                    border: Border.all(
                      color: aedappfm.AppThemeBase.sheetBorder,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: aedappfm.ArchethicScrollbar(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SelectableText(
                          AppLocalizations.of(context)!.havingTroubleHeader,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                fontWeight: FontWeight.w500,
                                color: aedappfm.AppThemeBase.secondaryColor,
                              ),
                        ),
                        const SizedBox(height: 30),
                        Opacity(
                          opacity: AppTextStyles.kOpacityText,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _line(
                                  context,
                                  AppLocalizations.of(context)!
                                      .troubleItem1Title,
                                  AppLocalizations.of(context)!
                                      .troubleItem1Desc,
                                  'FAQ', () {
                                launchUrl(
                                  Uri.parse(
                                    'https://wiki.archethic.net/FAQ/bridge-2-ways',
                                  ),
                                );
                              }),
                              _line(
                                  context,
                                  AppLocalizations.of(context)!
                                      .troubleItem2Title,
                                  AppLocalizations.of(context)!
                                      .troubleItem2Desc,
                                  'tutorials', () {
                                launchUrl(
                                  Uri.parse(
                                    'https://wiki.archethic.net/participate/bridge/usage',
                                  ),
                                );
                              }),
                              _line(
                                  context,
                                  AppLocalizations.of(context)!
                                      .troubleItem3Title,
                                  AppLocalizations.of(context)!
                                      .troubleItem3Desc,
                                  'history', () {
                                context
                                  ..pop()
                                  ..go(LocalHistorySheet.routerPage);
                              }),
                              _line(
                                  context,
                                  AppLocalizations.of(context)!
                                      .troubleItem4Title,
                                  AppLocalizations.of(context)!
                                      .troubleItem4Desc,
                                  'assets', () async {
                                context.pop();
                                await context.push(RefundSheet.routerPage);
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _line(
    BuildContext context,
    String title,
    String desc,
    String keyword,
    VoidCallback link,
  ) {
    final textStyleDesc = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.w200);
    final textStyleTitle = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.w700);

    final beforeKeyword = desc.split(keyword)[0];
    final afterKeyword = desc.split(keyword)[1];

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2, right: 4),
            child: Icon(
              Icons.arrow_forward_ios,
              color: aedappfm.AppThemeBase.secondaryColor,
              size: 14,
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$title ',
                    style: textStyleTitle,
                    recognizer: TapGestureRecognizer()..onTap = link,
                  ),
                  TextSpan(
                    text: beforeKeyword,
                    style: textStyleDesc,
                    recognizer: TapGestureRecognizer()..onTap = link,
                  ),
                  TextSpan(
                    text: keyword,
                    style: textStyleDesc.copyWith(
                      color: aedappfm.AppThemeBase.secondaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = link,
                  ),
                  TextSpan(
                    text: afterKeyword,
                    style: textStyleDesc,
                    recognizer: TapGestureRecognizer()..onTap = link,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
