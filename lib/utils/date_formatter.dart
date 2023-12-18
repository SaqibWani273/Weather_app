// import 'dart:developer';

import 'package:intl/intl.dart';

class DateFormatter {
  late String _dateTime;
  late int _timeZoneOffset;
  set setFormattedDateTime(int timeZoneOffset) {
    //for today screen
    final date = DateTime.now().add(Duration(
        seconds: timeZoneOffset - DateTime.now().timeZoneOffset.inSeconds));

    final formattedtime = DateFormat().add_jm().format(date);
    final formattedDate = DateFormat('EEEE, d MMM y').format(date);
    _timeZoneOffset = timeZoneOffset;
    _dateTime = "$formattedtime - $formattedDate";
  }

  String get formattedDateTime => _dateTime;
  set setTimeZoneOffset(int timeZoneOffset) {
    _timeZoneOffset = timeZoneOffset;
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
      {int? timeZoneOffsetFromUtc, required int dtInMillis}) {
    final utcDate =
        DateTime.fromMillisecondsSinceEpoch(dtInMillis * 1000, isUtc: true);
    return utcDate
        .add(Duration(seconds: timeZoneOffsetFromUtc ?? _timeZoneOffset));
  }

  String getFormattedDay(DateTime currentDate) {
    var day = "";
    // currentDate.day.toString();
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

//needed for detailed weather for a particvular hour
  String dayAndMonth(String dtTxt) {
    // dtTxt= "2022-12-08 08:00:00"
    final temp =
        dtTxt.split(' ')[0].split('-').reversed.toList(); //[08,12,2022]
    final day = temp[0];
    switch (temp[1]) {
      case '01':
        return "$day Jan";

      case '02':
        return "$day Feb";

      case '03':
        return "$day Mar";

      case '04':
        return "$day Apr";

      case '05':
        return "$day May";

      case '06':
        return "$day Jun";

      case '07':
        return "$day Jul";

      case '08':
        return "$day Aug";

      case '09':
        return "$day Sep";

      case '10':
        return "$day Oct";

      case '11':
        return "$day Nov";

      case '12':
        return "$day Dec";

      default:
        return "$day Jan";
    }
  }
}
