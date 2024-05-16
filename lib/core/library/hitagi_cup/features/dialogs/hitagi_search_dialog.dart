import 'package:flutter/material.dart';

class HitagiSearchDialog extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  const HitagiSearchDialog({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          isDense: true,
          prefixIcon: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (onSubmitted != null) {
                onSubmitted!(controller.text);
              }
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
