import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/controls.dart';

class ControlProvider extends ChangeNotifier {
  int _initialFontSize = 16;
  Color _initialFontColor = Colors.blue;
  TextStyle _initFs = TextStyle();
  FontWeight _initFw = FontWeight.w400;
  double _initTextPosX = 50;
  double _initTextPosY = 50;
  List<EditorControls> _edtcrls = [];
  int _editingText = 0;

  int get fSize => _initialFontSize;
  Color get fColor => _initialFontColor;
  TextStyle get fStyle => _initFs;
  FontWeight get fWeight => _initFw;
  double get textPosX => _initTextPosX;
  double get textPosY => _initTextPosY;
  List<EditorControls> get edtCtrls => _edtcrls;
  int get editingText => _editingText;

  set editingText(int id) {
    _editingText = id;
    notifyListeners();
  }

  void addText() {
    _edtcrls.add(
      EditorControls(
        textColor: Colors.blue,
        textFontStyle: GoogleFonts.roboto(),
        textSize: 16,
        id: _edtcrls.length + 1,
        textData: 'New Text',
        textdx: 50,
        textdy: 50,
      ),
    );
    _editingText = _edtcrls.length;
    notifyListeners();
  }

  void removeText(int id) {
    // _edtcrls.removeAt(id - 1);
    // notifyListeners();
  }

  void updateText(int id, String? text, double? dx, double? dy, Color? clr,
      TextStyle? tstyle, int? fsize) {
    if (dx != null) {
      _edtcrls[id - 1].textdx += dx;
    }
    if (dy != null) {
      _edtcrls[id - 1].textdy += dy;
    }
    if (clr != null) {
      _edtcrls[id - 1].textColor = clr;
    }
    if (text != null) {
      _edtcrls[id - 1].textData = text;
    }
    if (tstyle != null) {
      _edtcrls[id - 1].textFontStyle = tstyle;
    }
    if (fsize != null) {
      _edtcrls[id - 1].textSize = fsize;
    }

    notifyListeners();
  }

  void resetTextPos() {
    _initTextPosX = 50;
    _initTextPosY = 50;
    notifyListeners();
  }

  set textPosX(double x) {
    _initTextPosX = x;
    notifyListeners();
  }

  set textPosY(double y) {
    _initTextPosY = y;
    notifyListeners();
  }

  set fSize(int fontsize) {
    _initialFontSize = fontsize;
    notifyListeners();
  }

  set fColor(Color color) {
    _initialFontColor = color;
    notifyListeners();
  }

  set fStyle(TextStyle style) {
    _initFs = style;
    notifyListeners();
  }

  set fWeight(FontWeight fw) {
    _initFw = fw;
    notifyListeners();
  }
}
