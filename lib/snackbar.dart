import 'package:flutter/material.dart';

class CustomSnackbar {
  CustomSnackbar(this.context) : super();

  BuildContext context;

  show(String message, Color _background, Color _textColor,
      [Duration timeToShow = const Duration(seconds: 2)]) {
    SnackBar _snackBar = SnackBar(
        duration: timeToShow,
        backgroundColor: _background,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(30.0),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: _textColor),
        ));
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    });
  }
} //
