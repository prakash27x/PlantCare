import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> responseData;

  const ResultPage({super.key, required this.responseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            for (var i = 0; i < 3; i++) ...[
              Text(
                "Prediction ${i + 1}: ${responseData['prediction_${i + 1}']['class_name']}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Confidence: ${responseData['prediction_${i + 1}']['confidence']}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "Treatment: ${responseData['prediction_${i + 1}']['treatment']}",
                style: const TextStyle(fontSize: 16),
              ),
              const Divider(),
            ],
          ],
        ),
      ),
    );
  }
}
