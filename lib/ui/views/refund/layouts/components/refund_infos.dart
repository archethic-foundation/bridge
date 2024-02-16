import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundInfo extends ConsumerWidget {
  const RefundInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SelectableText(
      AppLocalizations.of(context)!.refundInfo,
    );
  }
}
