import 'package:flutter/material.dart';
import 'dart:math' as math;

class DemoContainer extends StatelessWidget {
  const DemoContainer({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
    required this.currentSize,
  });

  final double containerWidth;
  final double containerHeight;
  final Size? currentSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue[400]!,
            Colors.purple[400]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.crop_free,
                color: Colors.blue[700],
                size: math.min(containerWidth, containerHeight) * 0.12,
              ),
              const SizedBox(height: 8),
              Text(
                'Real Size:\n'
                '${containerWidth.toInt()} × '
                '${containerHeight.toInt()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: math.min(containerWidth, containerHeight) * 0.05,
                ),
              ),
              if (currentSize != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Detected:\n'
                  '${currentSize!.width.toStringAsFixed(0)} × '
                  '${currentSize!.height.toStringAsFixed(0)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: math.min(containerWidth, containerHeight) * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
