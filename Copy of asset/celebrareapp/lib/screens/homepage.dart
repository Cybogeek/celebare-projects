import 'dart:io';

import 'package:celebrareapp/screens/uploadedimg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late File _selectedImage;
  late File _croppedImage;
  Widget? _finalImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(
                0.8,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          widget.title,
          style: GoogleFonts.quintessential(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Upload Image',
                    style: GoogleFonts.quintessential(
                      fontSize: 18,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(
                            0.8,
                          ),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pickImage();
                      // _showModal(context);
                    },
                    child: Text(
                      'Choose from Device',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          if (_finalImage != null) _finalImage!,
        ],
      ),
    );
  }

  Future<void> _showModal() async {
    var result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: UploadedImage(
            selectedImg: _croppedImage,
          ),
        );
      },
    );
    setState(() {
      _finalImage = result;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // setState(() async {
      _selectedImage = File(pickedFile.path);
      _cropImage();
      // });

      if (!mounted) return;
    }
  }

  Future<void> _cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _selectedImage.path,
      aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 2),
      compressQuality: 100,
      maxHeight: MediaQuery.of(context).size.height.round(),
      maxWidth: MediaQuery.of(context).size.width.round(),
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarColor:
              Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
          toolbarTitle: '',
          statusBarColor: Theme.of(context).colorScheme.onBackground,
          backgroundColor: Colors.black.withOpacity(0.6),
          lockAspectRatio: false,
          toolbarWidgetColor: Colors.white,
        ),
      ],
    );
    if (croppedFile != null) {
      // setState(() {
      _croppedImage = File(croppedFile.path);
      // });
      _showModal();
    }
  }
}
