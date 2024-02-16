import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';


var borderRadius = BorderRadius.circular(7);

var themeMode = ThemeMode.system;

ColorScheme scheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 18, 18, 18),
  brightness: Brightness.dark,
  primary: Colors.white,
  secondary: const Color.fromARGB(255, 49, 49, 49),
  background: const Color.fromARGB(255, 18, 18, 18),
  surfaceTint: Colors.transparent,
);


ThemeData theme = ThemeData(
  colorScheme: scheme,
  brightness: Brightness.dark,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(scheme.secondary),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      
    ),
  ),

).useSystemChineseFont(Brightness.dark);
