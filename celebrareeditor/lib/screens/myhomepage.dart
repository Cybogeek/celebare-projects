import 'package:flutter/material.dart';

import '../widgets/controlpanel.dart';
import '../widgets/editorcanvas.dart';
import '../widgets/editortopbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: deviceWidth > 750
            ? Column(
                children: [
                  const EditorTopBar(),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: EditorCanvas(screenHeight: deviceHeight * 0.8),
                      ),
                      Expanded(
                        flex: 1,
                        child: ControlPanel(
                          screenHeight: deviceHeight * 0.8,
                          screenWidth: deviceWidth,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const EditorTopBar(),
                    Column(
                      children: [
                        EditorCanvas(
                          screenHeight: deviceHeight * 0.55,
                        ),
                        ControlPanel(
                            screenHeight: deviceHeight * 0.35,
                            screenWidth: deviceWidth),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
