import 'package:flutter/material.dart';

class SizeSliders extends StatelessWidget {
  const SizeSliders({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
    required this.minWidth,
    required this.maxWidth,
    required this.minHeight,
    required this.maxHeight,
    required this.onWidthChanged,
    required this.onHeightChanged,
  });

  final double containerWidth;
  final double containerHeight;

  final double minWidth;
  final double maxWidth;

  final double minHeight;
  final double maxHeight;

  final ValueChanged<double> onWidthChanged;
  final ValueChanged<double> onHeightChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.tune,
                color: Colors.blue[700],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Container Size Controls',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Width slider
          Row(
            children: [
              Icon(Icons.width_normal, color: Colors.blue[600], size: 18),
              const SizedBox(width: 8),
              Text(
                'Width: ${containerWidth.toInt()}px',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.blue[400],
              inactiveTrackColor: Colors.blue[200],
              thumbColor: Colors.blue[600],
              overlayColor: Colors.blue[200]?.withValues(alpha: 0.3),
            ),
            child: Slider(
              value: containerWidth,
              min: minWidth,
              max: maxWidth,
              divisions: ((maxWidth - minWidth) / 10).round(),
              onChanged: onWidthChanged,
            ),
          ),

          const SizedBox(height: 8),

          // Height slider
          Row(
            children: [
              Icon(Icons.height, color: Colors.green[600], size: 18),
              const SizedBox(width: 8),
              Text(
                'Height: ${containerHeight.toInt()}px',
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.green[400],
              inactiveTrackColor: Colors.green[200],
              thumbColor: Colors.green[600],
              overlayColor: Colors.green[200]?.withValues(alpha: 0.3),
            ),
            child: Slider(
              value: containerHeight,
              min: minHeight,
              max: maxHeight,
              divisions: ((maxHeight - minHeight) / 10).round(),
              onChanged: onHeightChanged,
            ),
          ),

          const SizedBox(height: 8),

          // Range display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Min: ${minWidth.toInt()}×${minHeight.toInt()}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Max: ${maxWidth.toInt()}×${maxHeight.toInt()}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
