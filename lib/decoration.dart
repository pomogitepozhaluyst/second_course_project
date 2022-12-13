import 'package:flutter/material.dart';

abstract class UserDecoration {
  static Color mainColor = const Color(0xFF221e2a);
  static Color secondColor = const Color(0xFF191520);

  static double textSize = 25;
  static Color textTitleColor = const Color(0xFFFaFFFC);
  static Color textSubStrColor = const Color(0xFF76758a);

  static Color iconColor = const Color(0xFF777086);
  static String textStyle = 'montserrat';

  static void returnDefaultStyle(){
    mainColor = const Color(0xFF221e2a);
    secondColor = const Color(0xFF191520);

    textSize = 25;
    textTitleColor = const Color(0xFFFaFFFC);
    textSubStrColor = const Color(0xFF76758a);

    iconColor = const Color(0xFF777086);
    textStyle = 'montserrat';
  }
}
