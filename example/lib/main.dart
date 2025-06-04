import 'package:flutter/material.dart';
import 'package:size_finder/size_finder.dart';
import 'package:size_finder_example/widgets/debounce_slider.dart';
import 'package:size_finder_example/widgets/demo_container.dart';
import 'package:size_finder_example/widgets/example_instruction.dart';

import 'package:size_finder_example/widgets/size_info.dart';
import 'package:size_finder_example/widgets/size_slider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SizeFinder Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SizeFinderExample(),
    );
  }
}

class SizeFinderExample extends StatefulWidget {
  const SizeFinderExample({super.key});

  @override
  State<SizeFinderExample> createState() => _SizeFinderExampleState();
}

class _SizeFinderExampleState extends State<SizeFinderExample> {
  Size? _currentSize;
  int _changeCount = 0;
  double _containerWidth = 200;
  double _containerHeight = 150;

  // Debounce setting (0-1000ms in 10 steps)
  double _debounceSliderValue = 1; // 0-10 scale

  // Screen size limits
  double _maxWidth = 400;
  final double _maxHeight = 300;
  static const double _minWidth = 80;
  static const double _minHeight = 60;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final screenSize = MediaQuery.of(context).size;
    _maxWidth = screenSize.width - 100;
  }

  void _onSizeChanged(Size size) {
    setState(() {
      _currentSize = size;
      _changeCount++;
    });

    debugPrint(
      'Container size: '
      '${size.width.toStringAsFixed(0)} x '
      '${size.height.toStringAsFixed(0)} '
      '(Debounce: $_debounceDisplayText)',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('SizeFinder Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              /* Debounce Slider */
              DebounceSlider(
                debounceDisplayText: _debounceDisplayText,
                debounceSliderValue: _debounceSliderValue,
                onChanged: (value) => setState(
                  () => _debounceSliderValue = value,
                ),
              ),
              const SizedBox(height: 16),

              /* Size Sliders */
              SizeSliders(
                containerWidth: _containerWidth,
                containerHeight: _containerHeight,
                minWidth: _minWidth,
                maxWidth: _maxWidth,
                minHeight: _minHeight,
                maxHeight: _maxHeight,
                onWidthChanged: (value) => setState(
                  () => _containerWidth = value,
                ),
                onHeightChanged: (value) => setState(
                  () => _containerHeight = value,
                ),
              ),
              const SizedBox(height: 16),

              /* Instruction */
              ExampleInstruction(),
              const SizedBox(height: 16),

              /* Main container area */
              Container(
                height: _maxHeight,
                alignment: Alignment.topCenter,

                // *** SizeFinder Implementation *** //
                child: SizeFinder(
                  onSizeChanged: _onSizeChanged,
                  debounceDuration: _debounceDuration,
                  child: DemoContainer(
                    containerWidth: _containerWidth,
                    containerHeight: _containerHeight,
                    currentSize: _currentSize,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /* Size Info */
              SizeInfo(
                changeCount: _changeCount,
                debounceDisplayText: _debounceDisplayText,
                currentSize: _currentSize,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Convert slider value (0-10) to duration
  Duration get _debounceDuration {
    int milliseconds = (_debounceSliderValue * 100).round(); // 0-2000ms
    return Duration(milliseconds: milliseconds);
  }

  String get _debounceDisplayText =>
      '${(_debounceDuration.inMilliseconds / 1000).toStringAsFixed(1)}s';
}
