import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty_data.png', // Replace with the path to your error image
            width: 100.0,
            height: 100.0,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Data is Empty',
            style: TextStyle(color: Colors.amber),
          ),
        ],
      ),
    );
  }
}
