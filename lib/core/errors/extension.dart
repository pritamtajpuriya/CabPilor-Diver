import 'dart:developer';

import 'package:flutter/material.dart';

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (
        FocusScope.of(this).focusedChild?.context?.widget is! EditableText);
  }
}

extension ErrorsX on Map<String, dynamic> {
  String getErrorMessage() {
    String errorMessage = "";
    try {
      forEach((key, value) {
        final _value = value;

        if (_value is List) {
          for (var element in _value) {
            errorMessage = "$errorMessage " + element.toString();
          }
        } else if (_value is String) {
          errorMessage = _value;
        } else if (_value is Map) {
          Map<String, dynamic> msgMap = value;

          // calll self recursively
          errorMessage = msgMap.getErrorMessage();
        }
      });
    } catch (e) {
      errorMessage = "Unknown error occurred, please try again later.";
    }
    return errorMessage;
  }
}
