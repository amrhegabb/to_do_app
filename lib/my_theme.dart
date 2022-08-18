import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xff5D9CEC);

  static const Color ligthScaffoldbackground = Color(0XFFDFECDB);
  static const Color green = Color(0XFF61E757);
  static const Color red = Color(0XFFEC4B4B);
  static final LightTheme = ThemeData(
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: ligthScaffoldbackground,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIconTheme: IconThemeData(size: 36.0),
        unselectedIconTheme: IconThemeData(size: 36.0),
        showUnselectedLabels: false,
        showSelectedLabels: false),
    textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: 18,
          color: lightPrimary,
          fontWeight: FontWeight.bold,
          fontFamily: "poppins",
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontFamily: "poppins",
        )),
  );
}
