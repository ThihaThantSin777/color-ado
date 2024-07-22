import 'package:intl/intl.dart';

extension StringExtension on String {
  String get getMonthDayYear {
    final date = DateTime.parse(this);
    final DateFormat format = DateFormat('MMMM d, yyyy');
    return format.format(date);
  }
}
