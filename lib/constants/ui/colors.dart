import 'package:flutter/material.dart';

class FColors {
  static const linearGradient = LinearGradient(
    colors: [
      Color(0xFF53E88B),
      Color(0xFF15BE77),
    ],
  );

  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  static const navBg = LinearGradient(
    colors: [
      Color(0x2053E88B),
      Color(0x2015BE77),
    ],
  );

  static const shadow = Color.fromARGB(60, 0, 123, 140);
  static const lightGreen = Color(0xFF53E88B);
  static const green = Color(0xFF15BE77);
  static const stroke = Color(0xFFF4F4F4);
  static const labelColor = Color(0xFF3B3B3B);
  static const backButtonIconColor = Color(0xFFDA6317);
  static const backButtonBgColor = Color.fromARGB(210, 247, 195, 135);
  static const setLocationButtonBgColor = Color(0xFFF0F0F0);
  static const shadowColor = Color(0xFFDDDDDD);
  static const pastelOrange = Color(0x20F9A84D);
  static const metallicOrange = Color(0xFFDA6317);
  static const metallicOrangeO5 = Color(0x7FDA6317);
  static const darkTangerine = Color(0xFFFEAD1D);
  static const loading = Color.fromARGB(255, 224, 224, 224);
  static const vistaBlue = Color.fromARGB(255, 167, 220, 195);
}
