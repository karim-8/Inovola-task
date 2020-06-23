import 'dart:ui';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class UtilsFunctions {
  ///Parsing Date from string to valid date & time
  String returnDate(String date) {
    String parsedDate;
    DateTime todayDate = DateTime.parse(date);
    print(todayDate);
    print(formatDate(todayDate,
        [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
    parsedDate = formatDate(todayDate,
        [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]);
    return parsedDate;
  }

  ///Custom text style
  TextStyle textStyle =
      TextStyle(fontWeight: FontWeight.w100, color: Colors.grey, fontSize: 15);

  TextStyle boldTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 17);

  TextStyle normalStyle =
      TextStyle(fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 15);
}
