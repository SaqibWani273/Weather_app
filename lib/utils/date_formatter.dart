// import 'dart:developer';

import 'package:intl/intl.dart';

class DateFormatter {
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

//to get formatted hour like 12 AM, 5pm from
// milisecondssinceepoch(of utc time) and timeZoneOffset of location from utc
  String getFormattedHour(int timeZoneOffset, int dt) {
    final locationDate = getCurrentDateTimeofLocation(
        timeZoneOffsetFromUtc: timeZoneOffset, dtInMillis: dt);
    final hour = (locationDate.hour) % 24;
    final String hourString = hour > 12 ? "${hour - 12} PM" : "$hour AM";
    return hourString;
  }

  DateTime getCurrentDateTimeofLocation(
      {required int timeZoneOffsetFromUtc, required int dtInMillis}) {
    final utcDate =
        DateTime.fromMillisecondsSinceEpoch(dtInMillis * 1000, isUtc: true);
    return utcDate.add(Duration(seconds: timeZoneOffsetFromUtc));
  }

  String getFormattedDay(DateTime currentDate) {
    var day = "";
    switch (currentDate.weekday) {
      case 1:
        day += " Mon";
        break;
      case 2:
        day += " Tue";
        break;
      case 3:
        day += " Wed";
        break;
      case 4:
        day += " Thu";
        break;
      case 5:
        day += " Fri";
        break;
      case 6:
        day += " Sat";
        break;
      case 7:
        day += " Sun";
    }
    return day;
  }
}
