import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  fontFamily: 'Sen',
  primaryColor: kPurple,
  snackBarTheme: SnackBarThemeData(backgroundColor: kPurple),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    isDense: true,
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 0.2),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF707070), width: 0.5),
      borderRadius: BorderRadius.circular(3),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF707070), width: 0.5),
      borderRadius: BorderRadius.circular(3),
    ),
    errorStyle: TextStyle(
      color: Colors.red,
      fontSize: 10,
      fontWeight: FontWeight.w700,
    ),
  ),
);
TextStyle kTextFieldContentStyle = TextStyle(
  color: Colors.black,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

Color kPurple = const Color(0xFF592A63);
