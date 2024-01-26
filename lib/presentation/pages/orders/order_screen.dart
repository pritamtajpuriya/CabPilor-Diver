import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late CameraController _controller;

  late XFile _videoFile;

  bool _isRecording = false;

  late Timer _timer;

  int _secondsRemaining = 30;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
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

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    await _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: GestureDetector(
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
        ),
      ),
    );
  }
}
