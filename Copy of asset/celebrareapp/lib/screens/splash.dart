import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});
  final String title;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MyHomePage(title: 'Add Image / Icon'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.title,
          style: GoogleFonts.greatVibes(
            fontSize: 40,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
