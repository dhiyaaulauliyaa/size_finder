import 'dart:async';

import 'package:flutter/material.dart';

/// A simple Flutter widget to find the size of your widget.
/// 
/// The [SizeFinder] widget wraps around any child widget and calls
/// [onSizeChanged] whenever the child's size changes. It includes
/// built-in debouncing to prevent excessive callbacks during rapid
/// size changes.
///
/// Example:
/// ```dart
/// SizeFinder(
///   onSizeChanged: (Size size) {
///     print('Widget size changed to: $size');
///   },
///   child: Container(
///     width: 200,
///     height: 100,
///     child: Text('Hello World'),
///   ),
/// )
/// ```
class SizeFinder extends StatefulWidget {
  /// Creates a [SizeFinder] widget.
  ///
  /// The [onSizeChanged] and [child] arguments are required.
  ///
  /// The [debounceDuration] parameter controls the debouncing behavior:
  /// - First size detection: Always immediate (no delay)
  /// - Subsequent changes: Debounced by [debounceDuration] duration
  /// - Set to [Duration.zero] to disable debouncing
  const SizeFinder({
    super.key,
    required this.onSizeChanged,
    required this.child,
    this.debounceDuration = const Duration(milliseconds: 100),
  });

  /// The widget whose size changes will be tracked.
  final Widget child;

  /// Callback function called when the child widget's size changes.
  ///
  /// For the first size detection, this is called immediately.
  /// For subsequent changes, this is called after the [debounceDuration] period
  /// (unless [debounceDuration] is [Duration.zero]).
  final ValueChanged<Size> onSizeChanged;

  /// The delay period for debouncing size change callbacks.
  ///
  /// - Default: 100 milliseconds
  /// - Set to [Duration.zero] to disable debouncing
  /// - First size detection is always immediate regardless of this value
  ///
  /// Debouncing prevents excessive callbacks when the widget size
  /// changes rapidly (e.g., during animations or window resizing).
  final Duration debounceDuration;

  @override
  State<SizeFinder> createState() => _SizeFinderState();
}

class _SizeFinderState extends State<SizeFinder> {
  Size? _size;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(_checkSize);
    return widget.child;
  }

  void _checkSize(_) {
    if (!mounted) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox?.hasSize != true) return;

    final newSize = renderBox!.size;
    if (newSize == _size) return;

    final needDelay =
        _size != null && widget.debounceDuration != Duration.zero;
    _size = newSize;
    
    // If no need delay, immediately trigger the onSizeChanged callback
    if (!needDelay) return widget.onSizeChanged(newSize);

    // Cancel any pending delayed callback
    _debounceTimer?.cancel();

    // Subsequent changes - apply debounce delay
    _debounceTimer = Timer(widget.debounceDuration, () {
      if (mounted) widget.onSizeChanged(newSize);
    });
  }
}
