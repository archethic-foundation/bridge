/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';

class EnvInfo extends StatelessWidget {
  const EnvInfo({
    required this.env,
    super.key,
  });

  final String env;

  @override
  Widget build(BuildContext context) {
    if (env.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: env == '1-mainnet'
            ? aedappfm.ArchethicThemeBase.raspberry500
            : env == '2-testnet'
                ? aedappfm.ArchethicThemeBase.blue600
                : aedappfm.ArchethicThemeBase.blue700,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SelectableText(
        env.split('-')[1],
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
