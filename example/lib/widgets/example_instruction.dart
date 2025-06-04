import 'package:flutter/material.dart';

class ExampleInstruction extends StatelessWidget {
  const ExampleInstruction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[100]!, width: 1),
      ),
      child: Column(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.green[700],
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            'Use the sliders above to change container size',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Watch how SizeFinder detects changes with different debounce settings!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.green[600],
            ),
          ),
        ],
      ),
    );
  }
}
