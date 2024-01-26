import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class CustomVideoPicker extends StatefulWidget {
  final void Function(File?) onVideoPicked;

  CustomVideoPicker({required this.onVideoPicked});

  @override
  _CustomVideoPickerState createState() => _CustomVideoPickerState();
}

class _CustomVideoPickerState extends State<CustomVideoPicker> {
  late CameraController _controller;
  late XFile _videoFile;
  bool _isRecording = false;
  late Timer _timer;
  int _secondsRemaining = 30;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _isRecording ? _stopVideoRecording() : _startVideoRecording();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CameraPreview(_controller),
                _isRecording
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Recording: $_secondsRemaining s',
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              icon: Icon(Icons.stop),
                              onPressed: _stopVideoRecording,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      )
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: IconButton(
                          icon: Icon(Icons.videocam),
                          onPressed: _startVideoRecording,
                          color: Colors.white,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    await _controller.initialize();
  }

  Future<void> _startVideoRecording() async {
    try {
      final appDir = await getTemporaryDirectory();
      final uniqueId = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${appDir.path}/video_$uniqueId.mp4';
      await _controller.startVideoRecording();
      setState(() {
        _isRecording = true;
      });

      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_secondsRemaining == 0) {
          _stopVideoRecording();
        } else {
          setState(() {
            _secondsRemaining--;
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopVideoRecording() async {
    if (!_controller.value.isRecordingVideo) {
      return;
    }
    _timer.cancel();
    await _controller.stopVideoRecording();
    setState(() {
      _isRecording = false;
    });
    widget.onVideoPicked(File(_videoFile.path));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
