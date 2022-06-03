import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime{
  get dateAndTime => DateFormat('dd-MM-yyyy kk:mm').format(this);
  get time => DateFormat('kk:mm').format(this);
  get date => DateFormat('dd-MM-yyyy').format(this);
}