/// SPDX-License-Identifier: AGPL-3.0-or-later
class DateUtil {
  int roundToNearestMinute(int timestamp) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final seconds = dateTime.second;
    final milliseconds = dateTime.millisecond;

    if (seconds >= 30) {
      dateTime = dateTime.add(
        const Duration(minutes: 1),
      );
    }

    return dateTime
        .subtract(Duration(seconds: seconds, milliseconds: milliseconds))
        .millisecondsSinceEpoch;
  }
}
