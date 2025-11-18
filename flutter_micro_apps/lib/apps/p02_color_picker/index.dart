import 'package:flutter/material.dart';

class ColorPickerApp extends StatefulWidget {
  const ColorPickerApp({Key? key}) : super(key: key);

  @override
  State<ColorPickerApp> createState() => _ColorPickerAppState();
}

class _ColorPickerAppState extends State<ColorPickerApp> {
  // State: RGB values (0-255)
  double _red = 255.0;
  double _green = 87.0;
  double _blue = 51.0;

  // Computed property: Current color from RGB
  Color get currentColor {
    return Color.fromRGBO(_red.toInt(), _green.toInt(), _blue.toInt(), 1.0);
  }

  // Computed property: Hex color code
  String get hexCode {
    String rHex = _red.toInt().toRadixString(16).toUpperCase().padLeft(2, '0');
    String gHex = _green
        .toInt()
        .toRadixString(16)
        .toUpperCase()
        .padLeft(2, '0');
    String bHex = _blue.toInt().toRadixString(16).toUpperCase().padLeft(2, '0');
    return '#$rHex$gHex$bHex';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Picker'), elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Color preview box
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: currentColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: currentColor.withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // RGB and Hex display
              Center(
                child: Column(
                  children: [
                    Text(
                      'RGB(${_red.toInt()}, ${_green.toInt()}, ${_blue.toInt()})',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      hexCode,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Red slider
              _buildSlider(
                label: 'Red',
                value: _red,
                color: Colors.red,
                onChanged: (value) {
                  setState(() {
                    _red = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Green slider
              _buildSlider(
                label: 'Green',
                value: _green,
                color: Colors.green,
                onChanged: (value) {
                  setState(() {
                    _green = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Blue slider
              _buildSlider(
                label: 'Blue',
                value: _blue,
                color: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    _blue = value;
                  });
                },
              ),

              const SizedBox(height: 32),

              // Reset button
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _red = 255.0;
                    _green = 87.0;
                    _blue = 51.0;
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset to Orange'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a slider
  Widget _buildSlider({
    required String label,
    required double value,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label and value
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value.toInt().toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Slider
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            thumbColor: color,
            overlayColor: color.withOpacity(0.2),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 255,
            divisions: 255,
            label: value.toInt().toString(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
