import 'package:celebrareeditor/models/controls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/controlprovider.dart';

class EditorCanvas extends StatelessWidget {
  const EditorCanvas({
    super.key,
    required this.screenHeight,
  });
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: screenHeight,
        child: Column(
          children: [
            TextEditor(height: screenHeight),
          ],
        ),
      ),
    );
  }
}

class TextEditor extends StatefulWidget {
  const TextEditor({
    super.key,
    required this.height,
  });
  final double height;
  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  //final TextEditingController _textController = TextEditingController();
  //final TextEditingController _textController1 = TextEditingController();
  @override
  void dispose() {
    // _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<EditorControls> edtc = context.watch<ControlProvider>().edtCtrls;
    return SizedBox(
      height: widget.height,
      child: Stack(children: _buildDynamicChildren(edtc)),
    );
  }

  List<Widget> _buildDynamicChildren(List<EditorControls> edtc) {
    List<Widget> children = [];
    for (int i = 0; i < edtc.length; i++) {
      children.add(TextBoxCustom(
        editCtrl: edtc[i],
      ));
    }
    return children;
  }
}

class TextDisplayBox extends StatelessWidget {
  const TextDisplayBox({
    super.key,
    required TextEditingController textController,
    required this.fstyle,
    required this.fsize,
    required this.fcolor,
  }) : _textController = textController;

  final TextEditingController _textController;
  final TextStyle fstyle;
  final int fsize;
  final Color fcolor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 0,
        color: Colors.transparent, //Theme.of(context) .colorScheme.background,
        //Colors.blue.withOpacity(0.5),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _textController.text,
            style: fstyle.copyWith(
              fontSize: fsize.toDouble(),
              color: fcolor,
            ),
          ),
        ),
      ),
    );
  }
}

class TextBoxCustom extends StatefulWidget {
  const TextBoxCustom({super.key, required this.editCtrl});
  final EditorControls editCtrl;
  @override
  State<TextBoxCustom> createState() => _TextBoxCustomState();
}

class _TextBoxCustomState extends State<TextBoxCustom> {
  TextEditingController textController =
      TextEditingController(text: 'New Text');
  bool _isEditing = true;
  // textController.text = widget.editCtrl.textData;
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int fsize = widget.editCtrl.textSize;
    TextStyle fstyle = widget.editCtrl.textFontStyle;
    Color fcolor = widget.editCtrl.textColor;

    return Positioned(
      left: widget.editCtrl.textdx,
      top: widget.editCtrl.textdy,
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            _isEditing = !_isEditing;
          });
        },
        onTap: () {
          context.read<ControlProvider>().editingText = widget.editCtrl.id;
        },
        child: Draggable(
          onDragUpdate: (details) {
            context.read<ControlProvider>().updateText(
                  widget.editCtrl.id,
                  textController.text,
                  details.delta.dx,
                  details.delta.dy,
                  fcolor,
                  fstyle,
                  fsize,
                );
            //context.read<ControlProvider>().textPosY += details.delta.dy;
          },
          feedback: TextDisplayBox(
              textController: textController,
              fstyle: fstyle,
              fsize: fsize,
              fcolor: fcolor),
          childWhenDragging: Container(),
          child: Column(
            children: [
              //Text Feild for editor
              Container(
                //padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  //color: Colors.blue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _isEditing
                    ? Container(
                        //padding: const EdgeInsets.all(8.0),
                        height: 120,
                        width: 200,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isEditing = false;
                                });

                                // context
                                //     .read<ControlProvider>()
                                //     .removeText(widget.editCtrl.id);
                              },
                              icon: Icon(
                                Icons.close,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            TextField(
                              autofocus: true,
                              controller: textController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText:
                                    'Editable Text ${widget.editCtrl.id}',
                              ),
                            ),
                          ],
                        ),
                      )
                    : TextDisplayBox(
                        textController: textController,
                        fstyle: fstyle,
                        fsize: fsize,
                        fcolor: fcolor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
