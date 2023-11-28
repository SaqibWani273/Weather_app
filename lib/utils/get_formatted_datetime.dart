// import 'dart:developer';

import 'package:intl/intl.dart';

String getFormattedDateTime(int timeZoneOffset, {int? hr}) {
  //optional named parameter hr will be passed when we need to get hour
  //for hourly weather
  final date = DateTime.now().add(Duration(
      seconds: timeZoneOffset - DateTime.now().timeZoneOffset.inSeconds));

  final formattedtime = DateFormat().add_jm().format(date);
  final formattedDate = DateFormat('EEEE, d MMM y').format(date);
  if (hr != null) {
    final hour = (date.hour + hr) % 24;
    final String hourString = hour > 12 ? "${hour - 12} PM" : "$hour AM";
    return hourString;
  }

  return "$formattedtime - $formattedDate";
}

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
