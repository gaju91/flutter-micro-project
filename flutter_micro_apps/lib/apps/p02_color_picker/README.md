# Color Picker - Complete Flutter Guide

**Project**: App 2 of Flutter Micro Apps Curriculum
**Time**: 60 minutes
**Difficulty**: Beginner+
**Prerequisites**: Complete p01_counter_with_history first

---

## 🎯 What You'll Build

A color picker app that:
- ✅ Has 3 sliders for Red, Green, and Blue values (0-255)
- ✅ Shows live color preview as you adjust sliders
- ✅ Displays RGB values
- ✅ Shows hex color code (like #FF5733)
- ✅ Updates in real-time as sliders move

**Visual Preview:**
```
┌──────────────────────────┐
│      Color Picker        │ ← AppBar
├──────────────────────────┤
│                          │
│   ┌────────────────┐     │
│   │                │     │
│   │  Color Preview │     │ ← Large colored box
│   │                │     │
│   └────────────────┘     │
│                          │
│   RGB(255, 87, 51)       │ ← RGB values
│   #FF5733                │ ← Hex code
│                          │
│   Red: 255               │
│   [████████░░] ← Slider  │
│                          │
│   Green: 87              │
│   [███░░░░░░░] ← Slider  │
│                          │
│   Blue: 51               │
│   [██░░░░░░░░] ← Slider  │
│                          │
└──────────────────────────┘
```

---

## 🧠 Concepts You'll Learn

### Core Concepts (NEW):
1. **Slider widget** - Interactive range input control
2. **Color class** - RGB/Hex color manipulation
3. **Multiple state variables** - Managing related state
4. **Getters** - Computed properties from state
5. **String formatting** - Converting numbers to hex

### From Previous App:
- ✅ StatefulWidget (App 1)
- ✅ setState() (App 1)
- ✅ Column layout (App 1)

---

## 📚 Concept Explanations (Before Coding)

### 1. Slider Widget

**What is it?** An interactive control to select a value from a range.

**Basic usage:**
```dart
Slider(
  value: 128,           // Current value
  min: 0,               // Minimum value
  max: 255,             // Maximum value
  onChanged: (value) {  // Called when slider moves
    // Do something with new value
  },
)
```

**How it works:**
```
User drags slider
  ↓
onChanged() called with new value
  ↓
You update state with setState()
  ↓
UI rebuilds with new slider position
```

**Properties:**
- `value`: Current position (must be between min and max)
- `min`: Minimum value (default 0.0)
- `max`: Maximum value (default 1.0)
- `divisions`: Number of discrete intervals (optional)
- `label`: Text shown above slider when dragging
- `onChanged`: Function called when value changes

**Example with divisions:**
```dart
Slider(
  value: 5,
  min: 0,
  max: 10,
  divisions: 10,        // Creates 11 discrete points (0,1,2...10)
  label: '5',           // Shows "5" above slider
  onChanged: (value) {
    setState(() {
      myValue = value;
    });
  },
)
```

**Web dev equivalent:**
```html
<!-- HTML -->
<input type="range" min="0" max="255" value="128"
       oninput="handleChange(this.value)">

<!-- React -->
<input type="range" min={0} max={255} value={red}
       onChange={(e) => setRed(e.target.value)} />
```

---

### 2. Color Class in Flutter

**What is it?** Flutter's way to represent colors.

**Creating colors:**

**Option 1: From RGB (Red, Green, Blue)**
```dart
Color myColor = Color.fromRGBO(255, 87, 51, 1.0);
// R=255, G=87, B=51, Opacity=1.0 (fully opaque)

// Simpler version (opacity always 1.0):
Color myColor = Color.fromRGBO(255, 87, 51, 1.0);
```

**Option 2: From hex code**
```dart
Color myColor = Color(0xFFFF5733);
// 0xFF = opacity (FF = fully opaque)
// FF5733 = hex color code
```

**Option 3: Named colors**
```dart
Color myColor = Colors.red;
Color myColor = Colors.blue;
Color myColor = Colors.green;
// etc.
```

**Using colors:**
```dart
// In Container
Container(
  color: myColor,
  width: 100,
  height: 100,
)

// In Text
Text(
  'Hello',
  style: TextStyle(color: myColor),
)

// In decoration
Container(
  decoration: BoxDecoration(
    color: myColor,
    borderRadius: BorderRadius.circular(12),
  ),
)
```

**RGB values explained:**
- **Red**: 0-255 (0 = no red, 255 = maximum red)
- **Green**: 0-255
- **Blue**: 0-255
- **Combining**: Mix values to create any color
  - `RGB(255, 0, 0)` = Pure red
  - `RGB(0, 255, 0)` = Pure green
  - `RGB(0, 0, 255)` = Pure blue
  - `RGB(255, 255, 0)` = Yellow (red + green)
  - `RGB(0, 255, 255)` = Cyan (green + blue)
  - `RGB(255, 0, 255)` = Magenta (red + blue)
  - `RGB(255, 255, 255)` = White (all colors)
  - `RGB(0, 0, 0)` = Black (no colors)

---

### 3. Multiple State Variables

**In App 1**, we had simple state:
```dart
int _count = 0;  // Single value
```

**In App 2**, we have multiple related values:
```dart
double _red = 0;
double _green = 0;
double _blue = 0;
```

**Why double, not int?**
- Slider uses `double` type
- More precise (128.5 vs 128)
- We convert to int when displaying

**Managing multiple state:**
```dart
void _updateRed(double value) {
  setState(() {
    _red = value;  // Only red changes
  });
}

void _updateGreen(double value) {
  setState(() {
    _green = value;  // Only green changes
  });
}

void _updateBlue(double value) {
  setState(() {
    _blue = value;  // Only blue changes
  });
}
```

**All three affect the same result** (final color), but they're independent values.

---

### 4. Getters (Computed Properties)

**What is a getter?** A property calculated from other properties.

**Without getter:**
```dart
class _ColorPickerState extends State<ColorPicker> {
  double _red = 255;
  double _green = 87;
  double _blue = 51;

  @override
  Widget build(BuildContext context) {
    // Calculate color every time we need it
    Color currentColor = Color.fromRGBO(
      _red.toInt(),
      _green.toInt(),
      _blue.toInt(),
      1.0
    );

    return Container(color: currentColor);  // Use it here
    // ...
    return Text('...');  // Would need to recalculate if used again
  }
}
```

**With getter:**
```dart
class _ColorPickerState extends State<ColorPicker> {
  double _red = 255;
  double _green = 87;
  double _blue = 51;

  // Getter - computed property
  Color get currentColor {
    return Color.fromRGBO(
      _red.toInt(),
      _green.toInt(),
      _blue.toInt(),
      1.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: currentColor);  // Use like a property
    // ...
    return Text('$currentColor');  // Use again, no recalculation needed
  }
}
```

**Benefits:**
- ✅ Calculate once, use many times
- ✅ Cleaner code
- ✅ Easy to read: `currentColor` vs calculation
- ✅ Automatic updates when state changes

**Syntax:**
```dart
// Getter
ReturnType get propertyName {
  return calculatedValue;
}

// Short form (one-liner)
ReturnType get propertyName => calculatedValue;
```

**Examples:**
```dart
// Full name from first + last
String get fullName => '$firstName $lastName';

// Is adult
bool get isAdult => age >= 18;

// Total price with tax
double get totalPrice => price * (1 + taxRate);
```

**Web dev equivalent:**
```javascript
// JavaScript
class Person {
  constructor(firstName, lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
  }

  // Getter
  get fullName() {
    return `${this.firstName} ${this.lastName}`;
  }
}

const person = new Person('John', 'Doe');
console.log(person.fullName);  // "John Doe"
```

---

### 5. Hex Color Codes

**What is hex?** Hexadecimal (base 16) way to represent RGB colors.

**Format:** `#RRGGBB`
- RR = Red (00-FF in hex = 0-255 in decimal)
- GG = Green (00-FF)
- BB = Blue (00-FF)

**Examples:**
```
#FF0000 = RGB(255, 0, 0)   = Red
#00FF00 = RGB(0, 255, 0)   = Green
#0000FF = RGB(0, 0, 255)   = Blue
#FFFFFF = RGB(255, 255, 255) = White
#000000 = RGB(0, 0, 0)     = Black
#FF5733 = RGB(255, 87, 51) = Orange-red
```

**Converting decimal to hex:**

**Manual:**
```
255 ÷ 16 = 15 remainder 15
15 in hex = F
15 in hex = F
Result: FF
```

**In Dart:**
```dart
int red = 255;
String hexRed = red.toRadixString(16).toUpperCase().padLeft(2, '0');
// toRadixString(16) = convert to base 16 (hex)
// toUpperCase() = FF instead of ff
// padLeft(2, '0') = pad with 0 if single digit (F → 0F)
```

**Complete hex color:**
```dart
String getHexColor(int r, int g, int b) {
  String rHex = r.toRadixString(16).toUpperCase().padLeft(2, '0');
  String gHex = g.toRadixString(16).toUpperCase().padLeft(2, '0');
  String bHex = b.toRadixString(16).toUpperCase().padLeft(2, '0');
  return '#$rHex$gHex$bHex';
}

// Usage
getHexColor(255, 87, 51)  // Returns "#FF5733"
```

---

## 🏗️ Project Structure

```
p02_color_picker/
├── lib/
│   └── main.dart           ← All your code goes here
├── pubspec.yaml            ← Dependencies (already set up)
├── README.md               ← This file
└── ... (other Flutter files)
```

---

## 🚀 Step-by-Step Build Guide

### Step 0: Verify Setup

```bash
cd /Users/gajanandsharma/ai-learnings/flutter/p02_color_picker

# Run the default app
flutter run -d chrome
```

Press `q` to quit after verifying it works.

---

### Step 1: Clean Slate

Open `lib/main.dart` and **DELETE EVERYTHING**.

---

### Step 2: Import & Main Function

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const ColorPickerApp());
}
```

**Same as App 1** - entry point for the app.

---

### Step 3: Root App Widget

```dart
class ColorPickerApp extends StatelessWidget {
  const ColorPickerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Picker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ColorPickerScreen(),
    );
  }
}
```

**Same pattern as App 1**, just different title and color.

---

### Step 4: Create StatefulWidget

```dart
class ColorPickerScreen extends StatefulWidget {
  const ColorPickerScreen({Key? key}) : super(key: key);

  @override
  State<ColorPickerScreen> createState() => _ColorPickerScreenState();
}
```

---

### Step 5: State Class with Multiple Variables

```dart
class _ColorPickerScreenState extends State<ColorPickerScreen> {
  // Three state variables - one for each color channel
  double _red = 255.0;
  double _green = 87.0;
  double _blue = 51.0;

  // Getter for current color (computed from RGB values)
  Color get currentColor {
    return Color.fromRGBO(
      _red.toInt(),
      _green.toInt(),
      _blue.toInt(),
      1.0,
    );
  }

  // Getter for hex code
  String get hexCode {
    String rHex = _red.toInt().toRadixString(16).toUpperCase().padLeft(2, '0');
    String gHex = _green.toInt().toRadixString(16).toUpperCase().padLeft(2, '0');
    String bHex = _blue.toInt().toRadixString(16).toUpperCase().padLeft(2, '0');
    return '#$rHex$gHex$bHex';
  }

  @override
  Widget build(BuildContext context) {
    // UI code here (see complete code below)
  }
}
```

**Key points:**
- **Three state variables** instead of one
- **Two getters** for computed values
- **`.toInt()`** converts double to int for display and Color

---

## 🎨 Complete Code

Here's the complete `lib/main.dart`:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const ColorPickerApp());
}

class ColorPickerApp extends StatelessWidget {
  const ColorPickerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Picker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ColorPickerScreen(),
    );
  }
}

class ColorPickerScreen extends StatefulWidget {
  const ColorPickerScreen({Key? key}) : super(key: key);

  @override
  State<ColorPickerScreen> createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  // State: RGB values (0-255)
  double _red = 255.0;
  double _green = 87.0;
  double _blue = 51.0;

  // Computed property: Current color from RGB
  Color get currentColor {
    return Color.fromRGBO(
      _red.toInt(),
      _green.toInt(),
      _blue.toInt(),
      1.0,
    );
  }

  // Computed property: Hex color code
  String get hexCode {
    String rHex = _red.toInt().toRadixString(16).toUpperCase().padLeft(2, '0');
    String gHex = _green.toInt().toRadixString(16).toUpperCase().padLeft(2, '0');
    String bHex = _blue.toInt().toRadixString(16).toUpperCase().padLeft(2, '0');
    return '#$rHex$gHex$bHex';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Picker'),
        elevation: 0,
      ),
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
```

---

## 📖 Understanding the Code

### SingleChildScrollView
```dart
SingleChildScrollView(
  child: ...
)
```
**Why?** Makes content scrollable if it doesn't fit on screen.
**When needed?** Long content, small screens, keyboard appearing.

---

### BoxDecoration with Shadow
```dart
Container(
  decoration: BoxDecoration(
    color: currentColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: currentColor.withOpacity(0.5),
        blurRadius: 20,
        offset: Offset(0, 10),
      ),
    ],
  ),
)
```

**Properties:**
- `color`: Background color
- `borderRadius`: Rounded corners
- `boxShadow`: Drop shadow effect
  - `color`: Shadow color (same as box, 50% opacity)
  - `blurRadius`: How blurry (higher = softer)
  - `offset`: Shadow position (x, y)

---

### Helper Method Pattern
```dart
Widget _buildSlider({
  required String label,
  required double value,
  required Color color,
  required ValueChanged<double> onChanged,
}) {
  // Build and return widget
}
```

**Why create helper method?**
- ✅ Avoid repeating code (DRY principle)
- ✅ Easier to maintain (change once, applies everywhere)
- ✅ Cleaner build() method
- ✅ Reusable component

**Usage:**
```dart
// Instead of copying this 3 times:
_buildSlider(label: 'Red', value: _red, color: Colors.red, ...);
_buildSlider(label: 'Green', value: _green, color: Colors.green, ...);
_buildSlider(label: 'Blue', value: _blue, color: Colors.blue, ...);
```

---

### SliderTheme
```dart
SliderTheme(
  data: SliderThemeData(
    activeTrackColor: color,
    thumbColor: color,
    overlayColor: color.withOpacity(0.2),
  ),
  child: Slider(...),
)
```

**What it does:** Customizes slider appearance.
**Properties:**
- `activeTrackColor`: Color of filled track
- `thumbColor`: Color of draggable circle
- `overlayColor`: Color when pressing thumb

---

### ValueChanged<double>
```dart
required ValueChanged<double> onChanged,
```

**What is it?** Type definition for a callback function.
**Equivalent to:** `void Function(double value)`

**Usage:**
```dart
// When defining parameter:
ValueChanged<double> onChanged

// When passing:
onChanged: (value) {
  setState(() {
    _red = value;
  });
}
```

---

## 🏃 Running Your App

```bash
flutter run -d chrome
```

---

## 🧪 Testing Your App

### Test 1: Red Slider
1. Move red slider to 255
2. Green and blue to 0
3. Should see pure red color
4. Hex code: `#FF0000`

### Test 2: Green Slider
1. Red to 0, Green to 255, Blue to 0
2. Should see pure green
3. Hex code: `#00FF00`

### Test 3: Blue Slider
1. Red to 0, Green to 0, Blue to 255
2. Should see pure blue
3. Hex code: `#0000FF`

### Test 4: Mix Colors
1. Red: 255, Green: 255, Blue: 0
2. Should see yellow
3. Hex code: `#FFFF00`

### Test 5: White & Black
1. All 255 → White (`#FFFFFF`)
2. All 0 → Black (`#000000`)

### Test 6: Reset Button
1. Change all sliders
2. Press "Reset to Orange"
3. Should return to RGB(255, 87, 51)

---

## 🐛 Common Issues & Solutions

### Issue 1: Slider doesn't move
**Cause:** Forgot `setState()` in `onChanged`
**Solution:** Always wrap state changes in `setState(() { })`

### Issue 2: Color doesn't update
**Cause:** Not using getter, or getter not recalculating
**Solution:** Make sure `currentColor` is a getter, not a variable

### Issue 3: Hex code shows wrong value
**Cause:** Forgot `.toInt()` when converting double
**Solution:** Always convert to int: `_red.toInt()`

### Issue 4: Slider jumps around
**Cause:** `value` not matching state variable
**Solution:** Pass correct state variable to each slider

---

## 🎯 Key Takeaways

After building this app, you now understand:

✅ **Slider widget** - How to get user input from ranges
✅ **Color manipulation** - RGB and hex color codes
✅ **Multiple state variables** - Managing related state
✅ **Getters** - Computed properties from state
✅ **Helper methods** - Reusable widget builders
✅ **String formatting** - Converting numbers to different bases
✅ **Real-time updates** - UI responding instantly to input

---

## 🚀 Challenges (Try These!)

### Challenge 1: Add Alpha (Opacity) Slider
Add a 4th slider for opacity (0-1).
Update `Color.fromRGBO()` to use this value.

### Challenge 2: Color Presets
Add buttons for preset colors:
- Red button → Set RGB(255, 0, 0)
- Green button → Set RGB(0, 255, 0)
- Blue button → Set RGB(0, 0, 255)

### Challenge 3: Random Color
Add button that generates random RGB values.
Hint: `Random().nextInt(256)` gives 0-255.

### Challenge 4: Save Favorite Colors
Keep a list of favorite colors.
Add button to save current color to list.
Display saved colors below.

### Challenge 5: Copy Hex Code
Add button next to hex code to copy it to clipboard.
Show snackbar: "Copied #FF5733 to clipboard!"

---

## 📚 Quick Reference

### Slider Template
```dart
Slider(
  value: _myValue,
  min: 0,
  max: 100,
  divisions: 100,
  label: _myValue.toInt().toString(),
  onChanged: (value) {
    setState(() {
      _myValue = value;
    });
  },
)
```

### Getter Template
```dart
ReturnType get propertyName => calculatedValue;

// Example
Color get currentColor => Color.fromRGBO(
  _red.toInt(), _green.toInt(), _blue.toInt(), 1.0
);
```

### Hex Conversion
```dart
String toHex(int value) {
  return value.toRadixString(16).toUpperCase().padLeft(2, '0');
}
```

### Multiple State Updates
```dart
setState(() {
  _red = 255;
  _green = 100;
  _blue = 50;
});
```

---

## 🎓 Comparison with App 1

| Aspect | App 1 (Counter) | App 2 (Color Picker) |
|--------|----------------|----------------------|
| **State variables** | 1 (count) | 3 (red, green, blue) |
| **Input method** | Buttons | Sliders |
| **Computed values** | None | Color & hex code (getters) |
| **State updates** | Increment/decrement | Continuous (slider drag) |
| **Complexity** | Simple | Moderate |

---

## 🔗 Next Steps

### Ready for App 3?
Once comfortable with this app, move to:
**App 3: Quick Notes** - Learn TextEditingController, local storage, and async operations!

**What you'll learn:**
- Text input (single & multiline)
- Saving data locally
- Auto-save with debouncing
- async/await basics

---

**Congratulations!** 🎉 You've mastered Sliders and multiple state management!

Now you can build any app that needs user input ranges (volume controls, brightness, filters, etc.) and work with colors! 🌈
