# SizeFinder

[![pub package](https://img.shields.io/pub/v/size_finder.svg)](https://pub.dev/packages/size_finder)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/dhiyaaulauliyaa/size_finder/blob/master/LICENSE)

A simple Flutter widget to find the size of your widget.

## [Test The Package](https://dhiyaaulauliyaa.github.io/size_finder/)

- **Access the example web page [here](https://dhiyaaulauliyaa.github.io/size_finder/)**
- **The homepage features an interactive demo of the SizeFinder widget**
- **Use the sliders to adjust container size and see real-time size detection**
- **Test different debounce durations from 0ms to 1 second**
- **Watch the change counter to see how debouncing affects callback frequency**

## Features

✅ **Efficient size tracking** - Monitors child widget size changes with minimal overhead  
✅ **Smart debouncing** - Prevents excessive callbacks during rapid size changes  
## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  size_finder: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## Basic Usage

```dart
import 'package:size_finder/size_finder.dart';

SizeFinder(
  onSizeChanged: (Size size) {
    print('Widget size: ${size.width} x ${size.height}');
  },
  child: Container(
    width: 200,
    height: 100,
    child: Text('Hello World'),
  ),
)
```

## Advanced Usage

### Custom Debounce Delay

```dart
SizeFinder(
  onSizeChanged: (Size size) {
    // This will be called 200ms after the last size change
    handleResize(size);
  },
  updateDelay: const Duration(milliseconds: 200),
  child: YourWidget(),
)
```

### Disable Debouncing (Immediate Updates)

```dart
SizeFinder(
  onSizeChanged: (Size size) {
    // Called immediately on every size change
    immediateUpdate(size);
  },
  updateDelay: Duration.zero,
  child: YourWidget(),
)
```

## How It Works

The `SizeFinder` widget uses Flutter's rendering system to efficiently detect size changes without performance overhead:

### Size Detection Mechanism

1. **RenderBox Access**: Uses `context.findRenderObject()` to directly access the widget's `RenderBox`
2. **Post-Frame Callbacks**: Leverages `WidgetsBinding.instance.addPostFrameCallback()` to check size after each frame render
3. **Direct Size Reading**: Reads the actual rendered size using `renderBox.size` property

### Technical Implementation

```dart
void _checkSize(_) {
  // Get the RenderBox from the widget's context
  final renderBox = context.findRenderObject() as RenderBox?;
  
  // Ensure the widget has been rendered and has a size
  if (renderBox?.hasSize != true) return;
  
  // Get the actual rendered size
  final newSize = renderBox!.size;
  
  // Compare with previous size to detect changes
  if (newSize == _previousSize) return;
  
  // Process the size change...
}
```

### Callback Execution Flow

```
Widget Build → Layout Phase → Render Phase → Post-Frame Callback → Size Check → Callback (if changed)
     ↓              ↓              ↓                    ↓                ↓              ↓
  setState()    Measure       Paint Widget      _checkSize()      Compare      onSizeChanged()
```

### Debouncing Implementation

1. **First Detection**: When `_previousSize == null`, callback executes immediately
2. **Subsequent Changes**: When `_previousSize != null`, debounce timer starts
3. **Timer Cancellation**: New size changes cancel previous timers, ensuring only the latest size triggers callback
4. **Final Callback**: After delay period, `onSizeChanged` is called with the most recent size



## API Reference

### SizeFinder

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `onSizeChanged` | `ValueChanged<Size>` | required | Callback function called when size changes |
| `child` | `Widget` | required | The widget whose size will be monitored |
| `updateDelay` | `Duration` | `100ms` | Debounce delay for size change callbacks |

### Callback Behavior

- **First size detection**: Always called immediately (no debouncing)
- **Subsequent changes**: Debounced according to `updateDelay`
- **Zero delay**: Set `updateDelay` to `Duration.zero` to disable debouncing
- **Rapid changes**: Only the latest size in a series of rapid changes triggers the callback

## Performance Tips

1. **Use appropriate debounce delays**:
   - UI updates: 100-150ms
   - Expensive calculations: 200-300ms
   - Simple logging: 50ms or Duration.zero

2. **Avoid heavy operations in callbacks**:
   ```dart
   // ❌ Heavy operation in callback
   onSizeChanged: (size) {
     heavyCalculation(size); // Blocks UI
   }
   
   // ✅ Defer heavy operations
   onSizeChanged: (size) {
     Future.microtask(() => heavyCalculation(size));
   }
   ```

3. **Consider callback frequency**:
   ```dart
   // ❌ Too frequent for expensive operations
   updateDelay: Duration.zero,
   
   // ✅ Balanced for most use cases
   updateDelay: const Duration(milliseconds: 100),
   ```

## Example Project

Check out the [example](example/) directory for a complete demonstration of `SizeFinder` with:
- Interactive sliders to resize widgets
- Real-time size display
- Change counter to show debouncing in action
- Animated containers

To run the example:
```bash
cd example
flutter run
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you find this package helpful, please 👍 like it on [pub.dev](https://pub.dev/packages/size_finder) and ⭐ star the repo on GitHub!

For issues and feature requests, please file them in the [issue tracker](https://github.com/yourusername/size_finder/issues).