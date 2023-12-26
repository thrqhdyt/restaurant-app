import 'package:flutter/material.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/network_error.png', // Replace with the path to your error image
            width: 100.0,
            height: 100.0,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'No Internet Connection\nPlease Check your Internet Connection!!',
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
