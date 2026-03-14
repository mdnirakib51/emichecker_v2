import 'package:intl/intl.dart';

class DateTimeFormatter{

  /// [to view only || converting from database format]
  static  DateFormat showDateOnly = DateFormat("yyyy-MM-dd");
  static  DateFormat showYearMonth = DateFormat("yyyy-MM");
  // static  DateFormat showDateOnly = DateFormat("dd-MM-yyyy");
  static  DateFormat showDateOnlyYear = DateFormat("yyyy-MM-dd");
  static  DateFormat showTimeOnly = DateFormat("hh:mm a");
  static  DateFormat showDateTime = DateFormat("dd/MM/yyyy hh:mm a");
  static  DateFormat showDateTimeWithMonth = DateFormat("dd MMM yyyy hh:mm a"); // e.g: 12 Sep 2023 12:30 PM
  static  DateFormat parsedTime = DateFormat.yMd();

  static  DateFormat dbFormatDateOnly = DateFormat("yyyy-MM-dd");
  static  DateFormat dbFormatDateTime = DateFormat("yyyy-MM-dd hh:mm");

  // New format for "7 October 2024"
  static DateFormat showDayMonthYear = DateFormat("d MMMM yyyy");
  static  DateFormat showDayMonth = DateFormat("dd MMM yyyy");

  // ISO 8601 Format (e.g., "2024-11-03T15:30:00Z")
  static DateFormat iso8601Format = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

  // Method to format ISO 8601 DateTime
  static String formatIso8601ToCustom(String iso8601Date) {
    try {
      DateTime parsedDate = DateTime.parse(iso8601Date);
      return showDateTimeWithMonth.format(parsedDate);
    } catch (e) {
      return 'Invalid date'; // Return an error message if parsing fails
    }
  }

}
