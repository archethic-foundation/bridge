import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
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
              SelectableText(
                ' - ${AppLocalizations.of(context)!.htlcStatusHeader}: ',
              ),
              SelectableText(
                _htlcStatusLabel(context, snapshot.data),
                style: TextStyle(color: _htlcColor(snapshot.data)),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Color _htlcColor(int? status) {
    if (status == null) {
      return aedappfm.ArchethicThemeBase.neutral0;
    }
    switch (status) {
      case 0:
        return aedappfm.ArchethicThemeBase.systemWarning600;
      case 1:
        return aedappfm.ArchethicThemeBase.systemPositive500;
      case 2:
        return aedappfm.ArchethicThemeBase.systemPositive500;
      default:
        return aedappfm.ArchethicThemeBase.neutral0;
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
