import 'package:flutter/material.dart';

class ResultNotFound extends StatelessWidget {
  const ResultNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/no_result.png', // Replace with the path to your error image
            width: 150.0,
            height: 150.0,
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Result Not Found!',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
