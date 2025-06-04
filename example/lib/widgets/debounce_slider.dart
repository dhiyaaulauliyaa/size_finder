import 'package:flutter/material.dart';

class DebounceSlider extends StatelessWidget {
  const DebounceSlider({
    super.key,
    required this.debounceDisplayText,
    required this.debounceSliderValue,
    required this.onChanged,
  });

  final String debounceDisplayText;
  final double debounceSliderValue;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple[100]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.timer,
                color: Colors.purple[700],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Debounce Duration',
                style: TextStyle(
                  color: Colors.purple[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple[700],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  debounceDisplayText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.purple[400],
              inactiveTrackColor: Colors.purple[200],
              thumbColor: Colors.purple[600],
              overlayColor: Colors.purple[200]?.withValues(alpha: 0.3),
            ),
            child: Slider(
              value: debounceSliderValue,
              min: 0,
              max: 10,
              divisions: 10,
              onChanged: onChanged,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0ms\n(Immediate)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.purple[600],
                ),
              ),
              Text(
                '0.5s',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.purple[600],
                ),
              ),
              Text(
                '1s\n(Max)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.purple[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
