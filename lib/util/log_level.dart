import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:logging/logging.dart';

void setupLogLevel() {
  aedappfm.LoggerOutput.setup(level: _requestedLogLevel);
}

Level get _requestedLogLevel => Level.LEVELS.firstWhere(
      (level) =>
          level.name.toLowerCase() ==
          Uri.base.queryParameters['logLevel']?.toLowerCase(),
      orElse: () => Level.SEVERE,
    );
