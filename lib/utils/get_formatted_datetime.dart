// import 'dart:developer';

import 'package:intl/intl.dart';

String getFormattedDateTime(int fromMillisecondsSinceEpoch) {
  final date = DateTime.fromMillisecondsSinceEpoch(
      fromMillisecondsSinceEpoch * 1000,
      isUtc: true);

  final formattedtime = DateFormat().add_jm().format(date);
  final formattedDate = DateFormat('EEEE, d MMM y').format(date);

  return "$formattedtime - $formattedDate";
}
