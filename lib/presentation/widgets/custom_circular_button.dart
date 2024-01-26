import 'package:flutter/material.dart';

class CircularButton extends StatefulWidget {
  final Function onPressed;

  const CircularButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  _CircularButtonState createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: _isPressed
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            widget.onPressed();
          },
          onLongPress: () {
            setState(() {
              _isPressed = true;
            });
          },
          onLongPressEnd: (details) {
            setState(() {
              _isPressed = false;
            });
          },
          onLongPressCancel: () {
            setState(() {
              _isPressed = false;
            });
          },
          child: Ink(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                'Start',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
