/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LogManager {
  LogManager({
    this.sendInterval = const Duration(seconds: 60),
    this.batchSize = 1,
  }) {
    if (!kDebugMode) {
      _timer = Timer.periodic(sendInterval, (Timer t) => _sendLogs());
    }
  }
  final Duration sendInterval;
  final int batchSize;
  List<Map<String, dynamic>> _logQueue = [];
  Timer? _timer;

  void log(
    String message, {
    String? name,
    StackTrace? stackTrace,
    LogLevel level = LogLevel.info,
  }) {
    if (message.isEmpty) return;
    if (kDebugMode) {
      if (name != null) {
        if (stackTrace != null) {
          developer.log(message, name: name, stackTrace: stackTrace);
        } else {
          developer.log(message, name: name);
        }
      } else {
        if (stackTrace != null) {
          developer.log(message, stackTrace: stackTrace);
        } else {
          developer.log(
            message,
          );
        }
      }
    } else {
      final logEntry = <String, dynamic>{
        'message': message,
        'level': level.toString(),
        'timestamp': DateTime.now().toIso8601String(),
        'stacktrace': stackTrace.toString(),
      };
      _logQueue.add(logEntry);
      if (_logQueue.length >= batchSize) {
        _sendLogs();
      }
    }
  }

  Future<void> _sendLogs() async {
    if (_logQueue.isEmpty) return;

    try {
      final response = await http.post(
        Uri.parse(
          'https://faas-fra1-afec6ce7.doserverless.co/api/v1/web/fn-b200dcda-cd45-406c-acb1-8a7642f462c2/default/app-log',
        ),
        body: json.encode(_logQueue),
      );

      if (response.statusCode == 200) {
        _logQueue = [];
      } else {
        developer.log(
          'Failed to send logs to server, response status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      developer.log('Error sending logs to server: $e');
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}

enum LogLevel { debug, info, warning, error }
