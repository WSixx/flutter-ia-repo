import 'package:cat_breed_identifier/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: HomeScreen(),
      title: Text(
        'Cat Breed Identifier',
        style: GoogleFonts.signika(
          color: Colors.pink,
          fontWeight: FontWeight.bold,
          fontSize: 80,
        ),
        textAlign: TextAlign.center,
      ),
      image: Image.asset('assets/images/icon.jpg'),
      backgroundColor: Colors.white,
      photoSize: 130,
      loaderColor: Colors.red,
      loadingText: Text(
        'Loading',
        style: GoogleFonts.brawler(
          fontSize: 18.0,
          color: Colors.pinkAccent,
        ),
      ),
    );
  }
}
