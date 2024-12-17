import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPopup {
  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return aedappfm.PopupTemplate(
          popupTitle: AppLocalizations.of(context)!.support_title,
          popupHeight: 450,
          popupContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: aedappfm.ArchethicScrollbar(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SelectableText(
                        AppLocalizations.of(context)!.support_desc1,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: aedappfm.AppThemeBase.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SelectableText(
                        AppLocalizations.of(context)!.support_desc2,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: aedappfm.AppThemeBase.secondaryColor,
                            ),
                      ),
                      SelectableText(
                        AppLocalizations.of(context)!.support_desc3,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Row(
                        children: [
                          _socialNetwork(
                            context,
                            'Discord',
                            'https://discord.com/invite/bZv9aHN7bd?_vd=zbB48QUnBK_cjUjl%2CAPvxNcCuwi',
                            'discord.svg',
                          ),
                          _socialNetwork(
                            context,
                            'Telegram',
                            'https://t.me/ArchEthic_ENG?_vd=zbB48QUnBK_cjUjl%2CAPvxNcCuwi',
                            'telegram.svg',
                          ),
                        ],
                      ),
                      SelectableText(
                        AppLocalizations.of(context)!.support_desc4,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: aedappfm.AppThemeBase.secondaryColor,
                            ),
                      ),
                      SelectableText(
                        AppLocalizations.of(context)!.support_desc5,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SelectableText(
                        AppLocalizations.of(context)!.support_desc6,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: aedappfm.AppThemeBase.secondaryColor,
                            ),
                      ),
                      SelectableText(
                        AppLocalizations.of(context)!.support_desc7,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _socialNetwork(
    BuildContext context,
    String name,
    String url,
    String icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
      child: Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 0.5,
          ),
          gradient: aedappfm.AppThemeBase.gradientInputFormBackground,
        ),
        child: InkWell(
          onTap: () async {
            await launchUrl(Uri.parse(url));
          },
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/$icon',
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
