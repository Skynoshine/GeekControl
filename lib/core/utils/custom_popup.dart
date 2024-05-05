import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;

  const CustomPopup({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed ?? () => Navigator.pop(context),
          child: Text(buttonText),
        ),
      ],
    );
  }
}
