import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class CustomColors {
  static Color dark = HexColor('#082640');
  static Color orange = HexColor('FE7F0E');
  static Color light = Colors.white;
  static Color shadowColor1 = const Color(0xFF113B5F);
}
