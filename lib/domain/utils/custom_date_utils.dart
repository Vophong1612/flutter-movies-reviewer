import 'package:intl/intl.dart';

class CustomDateUtils {

  static String? formatToDDMMMYYYY(String? inputDate) {
    String? result;
    if (inputDate == null) {
      return result;
    }
    DateTime date = DateTime.parse(inputDate);
    result = DateFormat.yMMMd('en-US').format(date);
    return result;
  }

  static int getYear(String inputDate) {
    DateTime date = DateTime.parse(inputDate);
    return date.year;
  }
}