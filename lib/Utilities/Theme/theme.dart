import 'package:flutter/material.dart';
import 'package:taskpro/Utilities/const.dart';

ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(bodyLarge: TextStyle(color: primarycolour)));
ThemeData darkmode = ThemeData(
    brightness: Brightness.dark,
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
    scaffoldBackgroundColor: Colors.grey.shade700,
    colorScheme: ColorScheme.dark(surface: Colors.grey.shade700));
