import 'package:camera/camera.dart';
import 'package:face_mask_detector/main.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CameraImage imgCamera;
  CameraController cameraController;
  bool isWorking = false;
  String result = '';

  @override
  void initState() {
    super.initState();

    iniCamera();
    loadModel();
  }

  iniCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.high);

    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        cameraController.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imageFromStream,
                  runModelOnFrame(),
                }
            });
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model.tflite',
      labels: 'assets/labels.txt',
    );
  }

  runModelOnFrame() async {
    if (imgCamera != null) {
      var recognition = await Tflite.runModelOnFrame(
        bytesList: imgCamera.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera.height,
        imageWidth: imgCamera.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.1,
        asynch: true,
      );
      result = "";
      recognition.forEach((response) {
        result += response['label'] + '\n';
      });

      setState(() {
        result;
      });
      isWorking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Center(
              child: Text(''),
            ),
          ),
        ),
        body: Column(
          children: [
            Positioned(
              top: 0,
              left: 0,
              width: size.width,
              height: size.height - 100,
              child: Container(
                height: size.height - 100,
                child: (!cameraController.value.isInitialized)
                    ? Container()
                    : AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: CameraPreview(cameraController),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
