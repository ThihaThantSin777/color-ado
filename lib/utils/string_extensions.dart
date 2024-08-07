import 'dart:io';

import 'package:intl/intl.dart';

extension StringExtension on String {
  String get getMonthDayYear {
    final date = DateTime.parse(this);
    final DateFormat format = DateFormat('MMMM d, yyyy');
    return format.format(date);
  }

  String get getYearMonthDay {
    final date = DateTime.parse(this);
    final DateFormat format = DateFormat('yyyy-MM-dd');
    return format.format(date);
  }

  DateTime get parseDateTimeFromString => DateTime.parse(this);

  String addS(int count) => (count <= 0) ? this : '${this}s';

  bool get isNetworkImage {
    return Uri.parse(this).isAbsolute;
  }

  bool get isFileImage {
    return File(this).existsSync();
  }
}
