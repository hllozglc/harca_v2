import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyColor {
  static const int _cardColor1 = 0xffE9F4D1;
  static const int _cardColor2 = 0xffF9F2D1;
  static const int _iconColor = 0xff3d405b;
  static const int _titleColor = 0xff0d1b2a;
  static const int _textColor = 0xff003049;
  static const int _navBarIconColor = 0xff3887BE;
  static const int _buttonColor = 0xff005B41;
  static const int _bgColor = 0xffF2F6F9;
  static const int _primaryColor = 0xff52D3D8;

  static const Color cardColor1 = Color(_cardColor1);
  static const Color cardColor2 = Color(_cardColor2);
  static const Color iconColor = Color(_iconColor);
  static const Color titleColor = Color(_titleColor);
  static const Color textColor = Color(_textColor);
  static const Color navBarIconColor = Color(_navBarIconColor);
  static const Color buttonColor = Color(_buttonColor);
  static const Color bgColor = Color(_bgColor);
  static const Color primaryColor = Color(_primaryColor);
}

class MyStyle {
  static double horizontalSize = 16.0;
  static TextStyle titleStyle() {
    return GoogleFonts.rubik(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: MyColor.titleColor,
    );
  }

  static TextStyle textStyle() {
    return GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: MyColor.textColor,
    );
  }
}
