import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Container(
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
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(
                        0.8,
                      ),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Choose from Device',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
