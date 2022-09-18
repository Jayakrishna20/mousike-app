import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImageDetection extends StatefulWidget {
  final CameraDescription? cameras;
  final CameraController? camcontroller;
  final String? output;
  const ImageDetection({Key? key, this.camcontroller, this.cameras,this.output})
      : super(key: key);

  @override
  State<ImageDetection> createState() => _ImageDetectionState();
}

class _ImageDetectionState extends State<ImageDetection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MOUSIKE',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: !widget.camcontroller!.value.isInitialized
                  ? Container()
                  : AspectRatio(aspectRatio: widget.camcontroller!.value.aspectRatio,
                  child: CameraPreview(widget.camcontroller!),
                  ),
            ),
          ),
          Text(widget.output!
          ,style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            
          ),
          ),
        ],
      ),
    );
  }
}
