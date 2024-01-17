import 'package:flutter/material.dart';

class MyTheme {
  static const Color scaffoldBackgroundColor = Color(0xFFD9D9D9);
  static const Color primaryColor = Color(0xFF757575);
  static const Color blackColor = Color(0xFF111111);
  static const Color whiteColor = Color(0xFFEFEFEF);
  static const Color greyColor = Color(0xFFb7b7b7);
  static const Color lightGreyColor = Color(0xFFe9e9e9);

  static const Color orange = Color(0xFFF2994A);
  static const Color red = Color(0xfffeb5757);
  static const Color yellow = Color(0xFFF2C94C);
  static const Color darkGreen = Color(0xFF219653);
  static const Color darkBlue = Color(0xFF2F80ED);
  static const Color lightGreen = Color(0xFF6FCF97);
  static const Color purple = Color(0xFF9B51E0);
  static const Color blue = Color(0xFF56CCF2);
  static const Color grey = Color(0xFFBDBDBD);

  static ThemeData get myTheme => ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      colorScheme: const ColorScheme.light(primary: primaryColor));
}
