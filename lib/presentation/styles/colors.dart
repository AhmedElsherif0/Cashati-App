import 'package:flutter/material.dart';

class AppColor {
  /// Most useful Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color americanSilver = Color(0xFFcfcfcf);
  static const Color grey = Color(0xFF9c9c9c);
  static const Color dimGray = Color(0xFF696969);
  static const Color darkGrey = Color(0xFF353535);

  /// Color Palette
  static const Color mintGreen = Color(0xFFa1f2ac);
  static const Color lightGreen = Color(0xFFaaffb5);
  static const Color primaryColor = Color(0xFF80bf88);
  static const Color murdochGreen = Color(0xFF5d8c64);
  static const Color deepMossGreen = Color(0xFF3c5a40);

  /// linear gradient colors
  static const List<Color> defaultLinearGradient = [
    AppColor.primaryColor,
    AppColor.white,
    AppColor.white,
    AppColor.primaryColor
  ];
}
