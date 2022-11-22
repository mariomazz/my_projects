import 'package:date_format/date_format.dart';

class DateParser {
  static String formattedLocaleDate(DateTime date) {
    return formatDate(
      date.toLocal(),
      [dd, ' ', MM, ' ', yyyy, ' - ', HH, ':', nn],
      locale: const ItalianDateLocale(),
    );
  }

  static parseAndLocaleDate() {
    
  }

  static String utcDate(DateTime date) {
    return date.toUtc().toString();
  }
}
