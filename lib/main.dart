import 'package:flutter/material.dart'; 
import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home': ( _ ) => HomePage(),
        'mapa': ( _ ) => MapaPage(),
      },
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
            color: Colors.deepPurple,
            elevation: 0
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
          elevation: 5
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(color: Colors.deepPurple),
          unselectedIconTheme: IconThemeData(color: Colors.black54),
          selectedLabelStyle: TextStyle(color: Colors.deepPurple),
          unselectedLabelStyle:  TextStyle(color: Colors.black54),
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.black54,
        ),
      ),
    );
  }
}