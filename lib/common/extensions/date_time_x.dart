import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

extension DateFormatX on DateFormat {
  String jmzTime(DateTime time) {
    return DateFormat.jmz().format(time);
  }
}
