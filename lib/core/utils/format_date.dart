import 'package:intl/intl.dart';

String formatDateByddMMYYYY(DateTime dateTime){
  return DateFormat(
    'dd MM yyyy',
  ).format(dateTime);
}