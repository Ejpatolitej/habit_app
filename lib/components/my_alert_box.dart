import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;

  const MyAlertBox({
    super.key, 
    required this.controller, 
    required this.onSave, 
    required this.onCancel,
    required this.hintText,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          ),
      ),
      actions: [
        MaterialButton(
          onPressed: onCancel,
          color: const Color.fromARGB(255, 100, 10, 115),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: onSave,
          color: const Color.fromARGB(255, 100, 10, 115),
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
