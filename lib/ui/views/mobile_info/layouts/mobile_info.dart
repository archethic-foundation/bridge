import 'package:aebridge/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MobileInfoScreen extends ConsumerWidget {
  const MobileInfoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyleDesc = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.w300);
    return aedappfm.BlockInfo(
      width: MediaQuery.of(context).size.width - 30,
      height: MediaQuery.of(context).size.height - 30,
      info: ColoredBox(
        color: Colors.transparent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'aeBridge',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: aedappfm.AppThemeBase.secondaryColor,
                        ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.mobileInfoTitle,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Opacity(
                    opacity: AppTextStyles.kOpacityText,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.mobileInfoTxt1,
                          style: textStyleDesc,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            AppLocalizations.of(context)!.mobileInfoTxt2,
                            style: textStyleDesc,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            AppLocalizations.of(context)!.mobileInfoTxt3,
                            style: textStyleDesc,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.mobileInfoTxt4,
                          style: textStyleDesc,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.mobileInfoTxt5,
                          style: textStyleDesc,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              aedappfm.AppButton(
                backgroundGradient: LinearGradient(
                  colors: [
                    aedappfm.ArchethicThemeBase.blue400,
                    aedappfm.ArchethicThemeBase.blue600,
                  ],
                ),
                labelBtn: AppLocalizations.of(context)!.btn_close,
                onPressed: () async {
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
