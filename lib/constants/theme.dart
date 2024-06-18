
import 'package:flutter/material.dart';

class Themes{
  static const MaterialColor mainColor=Colors.deepPurple;

  static ThemeData defaultTheme=ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Themes.mainColor,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 40,
        fontFamily: 'MyFont'
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Themes.mainColor),
        foregroundColor: WidgetStateProperty.all<Color>(Themes.mainColor.shade50),
        elevation: WidgetStateProperty.all<double>(3),
      )
    ),
    useMaterial3: true
  );
}