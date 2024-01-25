library otp_verify;

import 'package:flutter/material.dart';

class OtpVerify extends StatefulWidget {
  final int numberOfFields;
  final TextStyle textStyle;
  final Function(String) onOtpEntered;

  const OtpVerify({
    Key? key,
    required this.numberOfFields,
    required this.textStyle,
    required this.onOtpEntered,
  }) : super(key: key);

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(widget.numberOfFields, (index) => FocusNode());
    controllers = List.generate(
      widget.numberOfFields,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(widget.numberOfFields, (index) {
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: SizedBox(
            width: 40,
            height: 40,
            child: TextField(
              focusNode: focusNodes[index],
              autofocus: index == 0,
              textAlign: TextAlign.center,
              controller: controllers[index],
              keyboardType: TextInputType.number,
              onChanged: (str) {
                if (str.length == 1) {
                  if (index < widget.numberOfFields - 1) {
                    focusNodes[index].unfocus();
                    FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                  } else {
                    focusNodes[index].unfocus();
                  }
                  if (index == widget.numberOfFields - 1) {
                    var otp =
                        controllers.map((controller) => controller.text).join();
                    widget.onOtpEntered(otp);
                  }
                } else if (str.isEmpty && index > 0) {
                  focusNodes[index].unfocus();
                  FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                }
              },
              maxLength: 1,
              style: widget.textStyle,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                counterText: '',
              ),
            ),
          ),
        );
      }),
    );
  }
}
