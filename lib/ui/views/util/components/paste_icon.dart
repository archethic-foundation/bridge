/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/util/components/app_text_field.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasteIcon extends TextFieldButton {
  const PasteIcon({
    super.key,
    required this.onPaste,
    this.onDataNull,
  });

  final Function(String value) onPaste;
  final Function()? onDataNull;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFieldButton(
      icon: Iconsax.document_normal,
      onPressed: () {
        Clipboard.getData('text/plain').then((ClipboardData? data) async {
          if (data == null || data.text == null) {
            onDataNull?.call();
            return;
          }
          onPaste(data.text!);
        });
      },
    );
  }
}
