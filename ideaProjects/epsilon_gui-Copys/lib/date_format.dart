import 'package:intl/intl.dart';

String changeFormat(String dateStr) {
  DateTime dateObj = DateFormat('yyyy-MM-dd').parse(dateStr);
  String formattedDate = DateFormat('dd MMM').format(dateObj);
  return formattedDate;
}
