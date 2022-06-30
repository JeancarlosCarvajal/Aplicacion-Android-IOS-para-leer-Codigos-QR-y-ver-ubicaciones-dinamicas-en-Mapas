import 'package:flutter/material.dart';

class AppTheme {


  static const Color activeLight = Colors.deepPurple;
  static const Color unactiveLight = Colors.black54;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: activeLight,
    appBarTheme: const AppBarTheme(
        color: activeLight,
        elevation: 0
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: activeLight,
      elevation: 5
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: activeLight),
      unselectedIconTheme: IconThemeData(color: unactiveLight),
      selectedLabelStyle: TextStyle(color: activeLight),
      unselectedLabelStyle:  TextStyle(color: unactiveLight),
      selectedItemColor: activeLight,
      unselectedItemColor: unactiveLight,
    ),
  );


}