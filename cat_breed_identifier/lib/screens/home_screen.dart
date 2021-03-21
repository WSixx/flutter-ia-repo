import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<File> imageFile;
  File _image;
  String result = 'BLACK CAT';
  ImagePicker imagePicker;

  Future<void> selectPhoto() async {}
  Future<void> capturePhoto() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 100,
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Stack(
                children: [
                  Center(
                    child: TextButton(
                      onPressed: selectPhoto,
                      onLongPress: capturePhoto,
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 30.0, right: 35.0, left: 18.0),
                        child: _image != null
                            ? Image.file(
                                _image,
                                height: 160,
                                width: 400,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 140,
                                height: 190,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  //size: 80,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 160,
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                '$result',
                textAlign: TextAlign.center,
                style: GoogleFonts.signika(
                  fontSize: 40,
                  color: Colors.blueAccent,
                  backgroundColor: Colors.white60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
