import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class EVMHTLCStatus extends StatelessWidget {
  const EVMHTLCStatus({
    required this.providerEndpoint,
    required this.htlcAddress,
    required this.chainId,
    super.key,
  });

  final String providerEndpoint;
  final String htlcAddress;
  final int chainId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: EVMHTLC(
        providerEndpoint,
        htlcAddress,
        chainId,
      ).getStatus(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                ' - ${AppLocalizations.of(context)!.htlcStatusHeader}: ',
              ),
              Text(
                _htlcStatusLabel(context, snapshot.data),
                style: TextStyle(color: _htlcColor(snapshot.data)),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Color _htlcColor(int? status) {
    if (status == null) {
      return ArchethicThemeBase.neutral0;
    }
    switch (status) {
      case 0:
        return ArchethicThemeBase.systemWarning800;
      case 1:
        return ArchethicThemeBase.systemPositive500;
      case 2:
        return ArchethicThemeBase.systemPositive500;
      default:
        return ArchethicThemeBase.neutral0;
    }
  }

  String _htlcStatusLabel(BuildContext context, int? status) {
    if (status == null) {
      return AppLocalizations.of(context)!.htlcStatusLabelUnknown;
    }
    switch (status) {
      case 0:
        return AppLocalizations.of(context)!.htlcStatusLabelPending;
      case 1:
        return AppLocalizations.of(context)!.htlcStatusLabelWithdrawn;
      case 2:
        return AppLocalizations.of(context)!.htlcStatusLabelRefunded;
      default:
        return AppLocalizations.of(context)!.htlcStatusLabelUnknown;
    }
  }
}
