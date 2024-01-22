import 'package:flutter/material.dart';

ThemeData weatherAppTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.indigo,
  hintColor: Colors.amberAccent,
  scaffoldBackgroundColor: Colors.grey[900],
  textTheme: TextTheme(
    titleLarge: const TextStyle(
      color: Colors.white,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey[300],
      fontSize: 16.0,
    ),
  ),
  appBarTheme: const AppBarTheme(elevation: 0),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.indigo,
    selectedItemColor: Colors.amberAccent,
    unselectedItemColor: Colors.grey[400],
  ),
  cardTheme: CardTheme(
    color: Colors.black26,
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
);
