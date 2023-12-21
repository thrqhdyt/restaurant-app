import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 56.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/error_image.png', // Replace with the path to your error image
            width: 150.0,
            height: 150.0,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Error loading restaurants',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
