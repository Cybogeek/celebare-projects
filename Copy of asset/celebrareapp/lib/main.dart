import 'package:celebrareapp/screens/splash.dart';
import 'package:flutter/material.dart';

///File by @ Sukant, Hosted on https://github.com/Cybogeek/celebare-projects/tree/main/Copy%20of%20asset/celebrareapp
///Demo App Coded for Celebrare
///Potential for Improvement- Better UI with Material3 design. The Features can be improved with custom shaders, as well as optmised plugins for quality image editing.
///Plugins used - Image Picker, Image Cropper, and Widget Mask, all hosted on https://pub.dev
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Celebrare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        // useMaterial3: true,
      ),
      home: const SplashScreen(title: 'Celebrare App'),
    );
  }
}
