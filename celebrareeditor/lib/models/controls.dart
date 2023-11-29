import 'package:flutter/material.dart';

class EditorControls {
  EditorControls({
    required this.textColor,
    required this.textFontStyle,
    required this.textSize,
    required this.id,
    required this.textData,
    required this.textdx,
    required this.textdy,
  });
  TextStyle textFontStyle;
  int textSize;
  Color textColor;
  int id;
  String textData;
  double textdx;
  double textdy;
}
