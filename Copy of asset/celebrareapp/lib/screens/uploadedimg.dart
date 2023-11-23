import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_mask/widget_mask.dart';

class UploadedImage extends StatefulWidget {
  const UploadedImage({super.key, required this.selectedImg});
  final File? selectedImg;
  @override
  State<UploadedImage> createState() => _UploadedImageState();
}

class _UploadedImageState extends State<UploadedImage> {
  int imgIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.background),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.close_rounded,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Uploaded Image',
              style: GoogleFonts.quintessential(
                fontSize: 24,
                color: Theme.of(context).colorScheme.onBackground.withOpacity(
                      0.7,
                    ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.selectedImg != null
                ? imgIndex == 0
                    ? Image.file(
                        widget.selectedImg!,
                        height: 150.0,
                        width: 200.0,
                        fit: BoxFit.cover,
                      )
                    : _maskImage(widget.selectedImg!, imgIndex)
                : Container(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                    ),
                    child: Text(
                      'Orignal',
                      style: GoogleFonts.lato(fontSize: 18),
                    ),
                    onPressed: () {
                      setState(() {
                        imgIndex = 0;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        imgIndex = 1;
                      });
                    },
                    child: Image.asset(
                      'asset/user_image_frame_1.png',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        imgIndex = 2;
                      });
                    },
                    child: Image.asset('asset/user_image_frame_2.png'),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        imgIndex = 3;
                      });
                    },
                    child: Image.asset('asset/user_image_frame_3.png'),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        imgIndex = 4;
                      });
                    },
                    child: Image.asset(
                      'asset/user_image_frame_4.png',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      var returndata = Image.asset(widget.selectedImg!.path);
                      Navigator.of(context).pop(
                        imgIndex == 0
                            ? returndata
                            : _maskImage(
                                widget.selectedImg!,
                                imgIndex,
                              ),
                      );
                    },
                    child: const Text('Use this image'),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  WidgetMask _maskImage(File imageFile, int index) {
    final maskAssetPath =
        'asset/user_image_frame_$index.png'; // Customize this to your mask
    final maskedFile = WidgetMask(
      blendMode: BlendMode.screen,
      mask: Image.file(
        imageFile,
        alignment: Alignment.topCenter,
      ),
      child: Image.asset(
        maskAssetPath,
        height: 150,
        width: 200,
      ),
    );
    return maskedFile;
  }
}
