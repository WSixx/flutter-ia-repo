import 'package:cat_or_dog/screens/my_splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cat and Dog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySplashScreen(),
    );
  }
}
