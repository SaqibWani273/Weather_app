// import 'dart:developer';

import 'package:intl/intl.dart';

String getFormattedDateTime(int timeZoneOffset) {
  //for today screen
  final date = DateTime.now().add(Duration(
      seconds: timeZoneOffset - DateTime.now().timeZoneOffset.inSeconds));
  // final date = DateTime.now().add(Duration(
  //     seconds: timeZoneOffset - DateTime.now().timeZoneOffset.inSeconds));

  final formattedtime = DateFormat().add_jm().format(date);
  final formattedDate = DateFormat('EEEE, d MMM y').format(date);

  return "$formattedtime - $formattedDate";
}

String getHour(int timeZoneOffset, int dt) {
  final utcDate = DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true);
  final date = utcDate.add(Duration(seconds: timeZoneOffset));
  final hour = (date.hour) % 24;
  final String hourString = hour > 12 ? "${hour - 12} PM" : "$hour AM";
  return hourString;
}
// DateTime getSunriseTime(int timeZoneOffset) {
  
// }
// String getFormattedHour(
//   int timeZoneOffset,
//   int hr,
// ) {
//   final date = DateTime.now().add(Duration(
//       seconds: timeZoneOffset - DateTime.now().timeZoneOffset.inSeconds));
//   // final date = DateTime.fromMillisecondsSinceEpoch(
//   //     fromMillisecondsSinceEpoch * 1000,
//   //     isUtc: true);

//   final formattedtime = DateFormat().add_jm().format(date);
//   // final formattedDate = DateFormat('EEEE, d MMM y').format(date);
//   final hour = (date.hour + hr) % 24;
//   final String hourString = hour > 12 ? "${hour - 12} PM" : "$hour AM";
//   return hourString;
// }
