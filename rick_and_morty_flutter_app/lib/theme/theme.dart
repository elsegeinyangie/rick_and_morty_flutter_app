import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade200,    //background of page
    primary: Colors.grey.shade300,    //background of widget
    secondary: Colors.grey.shade900,  //main text
  ),
);
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,    //background of page
    primary: Colors.grey.shade800,    //background of widget
    secondary: Colors.grey.shade200   //main text
  ),
);


