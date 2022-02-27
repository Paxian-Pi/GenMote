import 'package:flutter/material.dart';

const mainColor = Color(0xff48bf53);

const secondaryColor = Color(0xFFb2dfdb);
const secondaryColorLight = Color(0xFFe5ffff);
const secondaryColorDark = Color(0xFF82ada9);

class MyTheme {
  static final ThemeData mainTheme = _buildMyTheme();

  static ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: mainColor,
    );
  }
}