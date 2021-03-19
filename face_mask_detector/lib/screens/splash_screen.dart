import 'package:face_mask_detector/screens/home_screen.dart';
import 'package:flutter/material.dart';
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
      title: Text(
        'Face MasK Detector',
        style: TextStyle(
          fontSize: 20,
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
      image: Image.asset('assets/splash.png'),
      photoSize: 130,
      backgroundColor: Colors.white,
      loaderColor: Colors.blueAccent,
      loadingText: Text(
        'Loading',
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 16,
        ),
      ),
      navigateAfterSeconds: HomeScreen(),
    );
  }
}
