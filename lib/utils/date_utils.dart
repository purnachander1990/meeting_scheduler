import 'package:intl/intl.dart';

class DateUtils {
  static String formatDateDayMonth(DateTime date) {
    return DateFormat('MMMM d').format(date);
  }
  
  static String formatFullDate(DateTime date) {
    return DateFormat('EEEE, MMMM d').format(date);
  }
  
  static String formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }
  
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && 
           date1.month == date2.month && 
           date1.day == date2.day;
  }
  
  static bool isPastDay(DateTime date) {
    final now = DateTime.now();
    return date.isBefore(DateTime(now.year, now.month, now.day));
  }
  
  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
  
  static List<String> getTimezones() {
    return [
      '(-05:00) EST - NEW YORK TIME',
      '(-08:00) PST - LOS ANGELES TIME',
      '(+00:00) GMT - LONDON TIME',
      '(+01:00) CET - PARIS TIME',
      '(+05:30) IST - INDIA TIME',
      '(+08:00) CST - BEIJING TIME',
      '(+09:00) JST - TOKYO TIME',
      '(+10:00) AEST - SYDNEY TIME',
    ];
  }
}