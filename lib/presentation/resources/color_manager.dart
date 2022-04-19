import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#181a1b");
  static Color secondary = HexColor.fromHex("#1b1e1f");
  static Color accent = HexColor.fromHex("#e8e6e3");
  static const Color error = Colors.red;
  static const Color white = Colors.white;
}

extension HexColor on Color{
  static Color fromHex(String hexColorString){
    hexColorString = hexColorString.replaceAll("#", "");

    if(hexColorString.length == 6){
      hexColorString = "FF" + hexColorString; //8 char with opacity 100%
    }

    return Color(int.parse(hexColorString, radix: 16));
  }
}