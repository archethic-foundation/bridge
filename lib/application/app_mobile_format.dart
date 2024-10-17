import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_mobile_format.g.dart';

@Riverpod(keepAlive: true)
bool isAppMobileFormat(IsAppMobileFormatRef ref, BuildContext context) {
  return Responsive.isMobile(context);
}
