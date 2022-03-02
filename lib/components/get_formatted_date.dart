import 'package:intl/intl.dart';

String getFormattedDate(DateTime date) {
  return DateFormat.yMMMMd().format(date);
}
