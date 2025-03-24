import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
  );

  static ThemeData get dark => ThemeData.dark().copyWith(
    primaryColor: Colors.blue,
    appBarTheme: AppBarTheme(elevation: 0),
  );
}
