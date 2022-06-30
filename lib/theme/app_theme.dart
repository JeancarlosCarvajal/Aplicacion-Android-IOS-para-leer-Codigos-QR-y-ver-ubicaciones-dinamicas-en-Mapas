import 'package:flutter/material.dart';

class AppTheme {

  static const String activeLightQR= '#673AB7';
  static const Color activeLight = Color(0xFF673AB7);
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