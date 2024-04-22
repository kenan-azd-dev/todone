import 'package:intl/intl.dart';

class Utils {
  static String jmzTime(DateTime time) {
    return DateFormat.jmz().format(time);
  }

  static String dateFormat(DateTime date) {
    return DateFormat('EEE, d/M').format(date);
  }
}