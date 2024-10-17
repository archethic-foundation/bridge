import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_embedded.g.dart';

@Riverpod(keepAlive: true)
bool isAppEmbedded(IsAppEmbeddedRef ref) {
  return Uri.base.queryParameters.containsKey('isEmbedded');
}
