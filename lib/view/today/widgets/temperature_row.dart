import 'package:flutter/material.dart';

class TemperatureRow extends StatelessWidget {
  const TemperatureRow({
    super.key,
    required this.temp,
  });

  final String temp;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          temp,
          style: const TextStyle(
            fontSize: 70,
          ),
        ),
        const Text(
          "O",
          style: TextStyle(fontSize: 20),
        ),
        const Text(
          "C",
          style: TextStyle(fontSize: 70, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
