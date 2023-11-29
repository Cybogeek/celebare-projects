import 'package:celebrareeditor/models/controls.dart';
import 'package:celebrareeditor/provider/controlprovider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });
  final double screenHeight;
  final double screenWidth;
  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  TextEditingController fontSizeController = TextEditingController();
  String _selectedFont = "Roboto";
  Color selectedColor = Colors.blue;
  int selectedFontSize = 16;
  List<int> fontsizes() {
    List<int> fs = [];
    for (int i = 1; i <= 150; i++) {
      fs.add(i * 2);
    }
    return fs;
  }

  final List<String> _myGoogleFonts = [
    "Abril Fatface",
    "Aclonica",
    "Alegreya Sans",
    "Architects Daughter",
    "Archivo",
    "Archivo Narrow",
    "Bebas Neue",
    "Bitter",
    "Bree Serif",
    "Bungee",
    "Cabin",
    "Cairo",
    "Coda",
    "Comfortaa",
    "Comic Neue",
    "Cousine",
    "Croissant One",
    "Faster One",
    "Forum",
    "Great Vibes",
    "Heebo",
    "Inconsolata",
    "Josefin Slab",
    "Lato",
    "Libre Baskerville",
    "Lobster",
    "Lora",
    "Merriweather",
    "Montserrat",
    "Mukta",
    "Nunito",
    "Offside",
    "Open Sans",
    "Oswald",
    "Overlock",
    "Pacifico",
    "Playfair Display",
    "Poppins",
    "Raleway",
    "Roboto",
    "Roboto Mono",
    "Source Sans Pro",
    "Space Mono",
    "Spicy Rice",
    "Squada One",
    "Sue Ellen Francisco",
    "Trade Winds",
    "Ubuntu",
    "Varela",
    "Vollkorn",
    "Work Sans",
    "Zilla Slab",
  ];
  @override
  Widget build(BuildContext context) {
    double screenW = widget.screenWidth;
    int id = context.watch<ControlProvider>().editingText;
    String textBox = 'EditingBox $id';
    var tlst = context.watch<ControlProvider>().edtCtrls;
    // var textBoxDetails = id > 0 ? tlst[id] : '';
    if (id > 0) {
      EditorControls ect = tlst[id - 1];
      selectedColor = ect.textColor;
      selectedFontSize = ect.textSize;
      _selectedFont = ect.textFontStyle.fontFamily.toString();
    }
    return SingleChildScrollView(
      child: Container(
        height: widget.screenHeight,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                id > 0
                    ? Text(
                        textBox,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      )
                    : const SizedBox.shrink(),
                TextField(
                  readOnly: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.arrow_drop_down_sharp),
                    hintText: _selectedFont,
                    label: Text('FONT: $_selectedFont'),
                    border: InputBorder.none,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FontPicker(
                          onFontChanged: (font) {
                            setState(() {
                              _selectedFont = font.fontFamily;
                            });
                            context.read<ControlProvider>().fStyle =
                                font.toTextStyle();
                            context.read<ControlProvider>().updateText(id, null,
                                null, null, null, font.toTextStyle(), null);
                            debugPrint(
                              "${font.fontFamily} with font weight ${font.fontWeight} and font style ${font.fontStyle}. FontSpec: ${font.toFontSpec()}",
                            );
                          },
                          googleFonts: _myGoogleFonts,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: screenW < 500.0 ? 0 : 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NumberPicker(
                      axis: Axis.horizontal,
                      value: selectedFontSize,
                      step: 2,
                      minValue: 2,
                      maxValue: 400,
                      onChanged: (value) {
                        context.read<ControlProvider>().updateText(
                            id, null, null, null, null, null, value);
                        context.read<ControlProvider>().fSize = value;
                        setState(
                          () => selectedFontSize = value,
                        );
                      },
                    ),
                    // DropdownMenu<int>(
                    //   inputDecorationTheme:
                    //       InputDecorationTheme(border: InputBorder.none),
                    //   initialSelection: selectedFontSize,
                    //   label: const Text('SIZE'),
                    //   requestFocusOnTap: true,
                    //   menuHeight: 250,
                    //   controller: fontSizeController,
                    //   onSelected: (int? value) {
                    //     // This is called when the user selects an item.
                    //     context.read<ControlProvider>().updateText(
                    //         id, null, null, null, null, null, value);
                    //     context.read<ControlProvider>().fSize = value!;
                    //     setState(() {
                    //       selectedFontSize = value;
                    //     });
                    //   },
                    //   dropdownMenuEntries:
                    //       fontsizes().map<DropdownMenuEntry<int>>((int value) {
                    //     return DropdownMenuEntry<int>(
                    //       value: value,
                    //       label: value.toString(),
                    //     );
                    //   }).toList(),
                    // ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    customColorPicker(id);
                  },
                  icon: CircleAvatar(
                    backgroundColor: selectedColor,
                  ),
                  label: const Text(
                    'FONT COLOR',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    context.read<ControlProvider>().addText();
                  },
                  icon: const Icon(Icons.edit_document),
                  label: const Text(
                    'ADD TEXT',
                  ),
                ),
                Text(
                  '@Code by: Sukant',
                  style: context.watch<ControlProvider>().fStyle.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: context.watch<ControlProvider>().fColor,
                      ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void customColorPicker(int id) {
    ColorPicker(
      heading: const Text('Pick a COLOR'),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      color: selectedColor,
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      onColorChanged: (Color color) {
        context.read<ControlProvider>().fColor = color;
        context
            .read<ControlProvider>()
            .updateText(id, null, null, null, color, null, null);
        setState(() {
          selectedColor = color;
        });
      },
    ).showPickerDialog(
      context,
    );
  }
}
