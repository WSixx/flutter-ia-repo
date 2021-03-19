import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  Future<void> detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }

    setState(() {
      _image = File(image.path);
    });
    detectImage(_image);
  }

  Future<void> pickGallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    setState(() {
      _image = File(image.path);
    });
    detectImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              'Coding Cafe',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Cats and Dogs Detector App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: _loading
                  ? Container(
                      width: 350,
                      child: Column(
                        children: [
                          Image.asset('assets/cat_dog_icon.png'),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            child: Image.file(_image),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _output != null
                              ? Text(
                                  '${_output[0]['label']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => pickImage(),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 220,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Capture a Photo',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => pickGallery(),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 220,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Select a Photo',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
