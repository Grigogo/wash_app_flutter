import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  // Основной цвет фона
  scaffoldBackgroundColor: const Color(0xFFEEF1F6),

  // Цвет AppBar
  appBarTheme: const AppBarTheme(
    color: Color(0xFF3DB0D4),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),

  // Цвет кнопок
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFF3DB0D4),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  // Цвет текста
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),

  // Цвет иконок
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),

  // Цвет Card
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  // Основной цвет фона
  scaffoldBackgroundColor: const Color(0xFF111419),

  // Цвет AppBar
  appBarTheme: const AppBarTheme(
    color: Color(0xFF3DB0D4),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),

  // Цвет кнопок
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFF3DB0D4),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  // Цвет текста
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),

  // Цвет иконок
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),

  // Цвет Card
  cardTheme: CardTheme(
    color: const Color(0xFF1E2229),
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
