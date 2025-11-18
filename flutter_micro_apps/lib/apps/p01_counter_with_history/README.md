# Counter with History - Complete Flutter Guide

**Project**: App 1 of Flutter Micro Apps Curriculum
**Time**: 45-60 minutes
**Difficulty**: Beginner (Perfect for first Flutter app!)

---

## 🎯 What You'll Build

A counter app that:
- ✅ Has increment (+) and decrement (-) buttons
- ✅ Shows current count
- ✅ Tracks ALL changes in a scrollable history
- ✅ Has a "Clear History" button
- ✅ Updates UI instantly when you press buttons

**Visual Preview:**
```
┌──────────────────────────┐
│   Counter with History   │ ← AppBar
├──────────────────────────┤
│                          │
│      Count: 5            │ ← Big number display
│                          │
│   [  -  ]    [  +  ]     │ ← Buttons
│                          │
│   History:               │
│   ┌────────────────────┐ │
│   │ 1                  │ │
│   │ 2                  │ │
│   │ 3                  │ │
│   │ 4                  │ │ ← Scrollable list
│   │ 5                  │ │
│   └────────────────────┘ │
│                          │
│   [ Clear History ]      │ ← Clear button
│                          │
└──────────────────────────┘
```

---

## 🧠 Concepts You'll Learn

### Core Concepts (NEW):
1. **StatefulWidget** - Widgets that can change over time
2. **State** - Data that changes and updates the UI
3. **setState()** - How to tell Flutter to update the UI
4. **Lists** - Storing multiple values
5. **ListView.builder** - Efficient scrollable lists

### Basic Concepts (Used):
- Column layout
- Text widget
- Button widgets
- Basic Dart syntax

---

## 📚 Concept Explanations (Before Coding)

### 1. StatelessWidget vs StatefulWidget

**StatelessWidget**: Never changes after being created
```dart
// Example: A static label that never changes
class WelcomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Welcome!'); // Always shows "Welcome!"
  }
}
```

**StatefulWidget**: Can change over time (what we need!)
```dart
// Example: A counter that changes when you press a button
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0; // This can change!

  void increment() {
    setState(() {
      count++; // Update count AND tell Flutter to redraw
    });
  }
}
```

**When to use which?**
- Use **StatelessWidget** when: Text labels, icons, static images
- Use **StatefulWidget** when: Forms, counters, animations, anything that changes

---

### 2. What is "State"?

**State** = Data that can change and affects what users see

**Examples:**
- Counter number (changes when you press +/-)
- Checkbox (checked or unchecked)
- Text in a form (changes as user types)
- List of items (changes when you add/remove)

**Think of it like:**
```javascript
// In React:
const [count, setCount] = useState(0);

// In Flutter:
class _MyWidgetState extends State<MyWidget> {
  int count = 0; // This is state

  void increment() {
    setState(() => count++); // Update state
  }
}
```

---

### 3. How setState() Works

**Without setState()** (❌ WRONG):
```dart
int count = 0;

void increment() {
  count++; // Count increases but UI doesn't update!
}
```

**With setState()** (✅ CORRECT):
```dart
int count = 0;

void increment() {
  setState(() {
    count++; // Count increases AND Flutter redraws the widget
  });
}
```

**What setState() does:**
1. Runs the code inside `() { }`
2. Marks widget as "dirty" (needs redrawing)
3. Flutter calls `build()` again
4. UI updates with new values

**Flow:**
```
Button pressed
  ↓
increment() called
  ↓
setState(() { count++; })
  ↓
count changes from 5 to 6
  ↓
Flutter marks widget as dirty
  ↓
build() runs again
  ↓
Text widget shows "6" instead of "5"
  ↓
User sees updated UI
```

---

### 4. Lists in Dart

**Creating a list:**
```dart
List<int> numbers = []; // Empty list of integers
List<String> names = ['Alice', 'Bob']; // List with values
```

**Common operations:**
```dart
List<int> history = [];

// Add item
history.add(5);           // history = [5]
history.add(6);           // history = [5, 6]

// Get item
int first = history[0];   // first = 5
int last = history[history.length - 1]; // last = 6

// Remove item
history.removeAt(0);      // history = [6]

// Clear all
history.clear();          // history = []

// Check if empty
if (history.isEmpty) { }  // true if no items

// Get count
int count = history.length; // How many items
```

**In our app:**
```dart
List<int> history = [];

void increment() {
  setState(() {
    count++;
    history.add(count); // Add current count to history
  });
}
// After pressing + three times:
// count = 3
// history = [1, 2, 3]
```

---

### 5. ListView.builder (Efficient Lists)

**Why not just use Column?**
```dart
// ❌ BAD: If you have 1000 items, creates 1000 widgets at once!
Column(
  children: [
    Text('Item 1'),
    Text('Item 2'),
    // ... 998 more
    Text('Item 1000'),
  ],
)
```

**✅ GOOD: ListView.builder creates widgets only when visible**
```dart
ListView.builder(
  itemCount: 1000, // Total items
  itemBuilder: (context, index) {
    // This runs ONLY for visible items (maybe 10-20 at a time)
    return Text('Item ${index + 1}');
  },
)
```

**How it works:**
```
Screen shows items 0-9 (10 visible)
  ↓
Flutter calls itemBuilder for indexes 0-9
  ↓
Creates 10 widgets
  ↓
User scrolls down
  ↓
Items 10-19 now visible
  ↓
Flutter calls itemBuilder for indexes 10-19
  ↓
Items 0-9 are removed from memory
  ↓
Memory efficient! ✅
```

**Our usage:**
```dart
ListView.builder(
  itemCount: history.length, // How many items in history
  itemBuilder: (context, index) {
    // This runs for each visible item
    int value = history[index]; // Get value at this position
    return ListTile(
      title: Text('$value'),
    );
  },
)
```

---

## 🏗️ Project Structure

```
p01_counter_with_history/
├── lib/
│   └── main.dart           ← All your code goes here
├── pubspec.yaml            ← Dependencies (already set up)
├── README.md               ← This file
└── ... (other Flutter files)
```

**You only need to edit `lib/main.dart`!**

---

## 🚀 Step-by-Step Build Guide

### Step 0: Verify Setup

```bash
# Make sure you're in the project directory
cd /Users/gajanandsharma/ai-learnings/flutter/p01_counter_with_history

# Run the default app to verify everything works
flutter run -d chrome
```

You should see the default Flutter counter app. Press `q` to quit.

---

### Step 1: Clean the Slate

Open `lib/main.dart` and **DELETE EVERYTHING**. Start fresh!

---

### Step 2: Import Flutter Material

Every Flutter app needs this:

```dart
import 'package:flutter/material.dart';
```

**What it does:**
- Imports all Material Design widgets (Text, Button, AppBar, etc.)
- Like `import React from 'react'` in JavaScript

---

### Step 3: Create main() Function

```dart
void main() {
  runApp(const CounterApp());
}
```

**Line by line:**
- `void main()` - Entry point (every Dart app starts here)
- `runApp()` - Flutter function that starts the app
- `const CounterApp()` - Creates instance of our app widget (we'll create this next)

---

### Step 4: Create CounterApp Widget (Root)

```dart
class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter with History',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterScreen(),
    );
  }
}
```

**Line by line:**

**Line 1:** `class CounterApp extends StatelessWidget`
- Creates a new class named `CounterApp`
- Extends (inherits from) `StatelessWidget`
- This widget never changes (just sets up the app)

**Line 2:** `const CounterApp({Key? key}) : super(key: key);`
- Constructor for CounterApp
- `{Key? key}` - Optional parameter (used by Flutter internally)
- `: super(key: key)` - Pass key to parent class
- `const` - This widget is constant (optimization)

**Line 4:** `@override`
- Annotation saying we're overriding parent's build method

**Line 5:** `Widget build(BuildContext context)`
- Every widget must have a `build` method
- Returns what to display
- `BuildContext context` - Information about where widget is in the tree

**Line 6:** `return MaterialApp(`
- Root widget for Material Design apps
- Provides theme, navigation, etc.

**Line 7:** `title: 'Counter with History',`
- App title (shows in task switcher)

**Lines 8-10:** Theme configuration
- `primarySwatch: Colors.blue` - Main color scheme

**Line 11:** `home: const CounterScreen(),`
- First screen to show (we'll create this next)

---

### Step 5: Create CounterScreen (StatefulWidget)

Now for the main screen with state!

```dart
class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}
```

**Line by line:**

**Line 1:** `class CounterScreen extends StatefulWidget`
- Creates a stateful widget (can change over time)

**Line 4:** `State<CounterScreen> createState() => _CounterScreenState();`
- StatefulWidget requires this method
- Creates the State object that holds the changing data
- Returns instance of `_CounterScreenState` (we'll create next)

**Why two classes?**
- `CounterScreen` - The widget (doesn't change)
- `_CounterScreenState` - The state (holds changing data)
- Flutter can rebuild UI without recreating state

---

### Step 6: Create State Class (The Main Part!)

This is where all the action happens!

```dart
class _CounterScreenState extends State<CounterScreen> {
  // State variables
  int _count = 0;
  List<int> _history = [];

  // Methods to modify state
  void _increment() {
    setState(() {
      _count++;
      _history.add(_count);
    });
  }

  void _decrement() {
    setState(() {
      _count--;
      _history.add(_count);
    });
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // UI code here (see complete code below)
    );
  }
}
```

**Breaking down the state variables:**
```dart
int _count = 0;
List<int> _history = [];
```

**Why `_` (underscore)?**
- Makes variable private to this file
- Convention: prefix private variables with `_`
- Like `private` keyword in other languages

---

## 🎨 Complete Code

Here's the complete `lib/main.dart` - **copy this entire file:**

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter with History',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  // State variables
  int _count = 0;
  List<int> _history = [];

  // Increment counter
  void _increment() {
    setState(() {
      _count++;
      _history.add(_count);
    });
  }

  // Decrement counter
  void _decrement() {
    setState(() {
      _count--;
      _history.add(_count);
    });
  }

  // Clear history
  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter with History'),
      ),
      body: Column(
        children: [
          // Current count display (2/5 of space)
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Count:',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '$_count',
                    style: const TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Increment/Decrement buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _decrement,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    '-',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                ElevatedButton(
                  onPressed: _increment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),

          // History section (3/5 of space)
          Expanded(
            flex: 3,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'History:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: _history.isEmpty
                      ? const Center(
                          child: Text(
                            'No history yet. Press + or - to start!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _history.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              title: Text(
                                '${_history[index]}',
                                style: const TextStyle(fontSize: 18),
                              ),
                            );
                          },
                        ),
                ),
                if (_history.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _clearHistory,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Clear History'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 🏃 Running Your App

```bash
# Run in Chrome (easiest for development)
flutter run -d chrome

# Or run on connected device
flutter devices           # See available devices
flutter run -d <device>   # Run on specific device
```

---

## 🧪 Testing Your App

Try these scenarios:

1. **Increment test:**
   - Press + five times
   - Count should show "5"
   - History should show [1, 2, 3, 4, 5]

2. **Decrement test:**
   - Press - three times
   - Count should show "2"
   - History should show [1, 2, 3, 4, 5, 4, 3, 2]

3. **Clear test:**
   - Press "Clear History"
   - History should be empty
   - Count should stay the same

4. **Scroll test:**
   - Press + many times (20+)
   - History should scroll smoothly

---

## 🐛 Common Issues & Solutions

### Issue 1: "setState() called after dispose()"
**Cause:** Calling setState when widget is no longer in tree
**Solution:** Already handled (not an issue in this app)

### Issue 2: History doesn't update
**Cause:** Forgot to call `setState()`
**Solution:** Always wrap state changes in `setState(() { })`

### Issue 3: List doesn't scroll
**Cause:** ListView not wrapped in Expanded
**Solution:** Already fixed in code above

### Issue 4: Buttons don't respond
**Cause:** `onPressed: null` or method not defined
**Solution:** Make sure `onPressed: _increment` (no parentheses!)

---

## 🎯 Key Takeaways

After building this app, you now understand:

✅ **StatefulWidget** - How to make widgets that change
✅ **setState()** - How to update UI when data changes
✅ **Lists** - How to store and display multiple values
✅ **ListView.builder** - How to create efficient scrollable lists
✅ **State management** - How to manage changing data
✅ **Event handling** - How button presses trigger actions
✅ **Conditional rendering** - How to show/hide widgets based on state

---

## 🚀 Next Steps

### Experiment Ideas:
1. Add a "Reset" button that sets count to 0
2. Change the colors of the buttons
3. Show sum of all history values
4. Add a maximum count limit (e.g., can't go above 10)
5. Show how many times + and - were pressed

### Ready for App 2?
Once you're comfortable with this app, move to:
**App 2: Color Picker** - Learn Sliders and working with multiple state variables!

---

## 📚 Quick Reference

### setState Pattern
```dart
void changeValue() {
  setState(() {
    // Change state variables here
    _count++;
    _list.add(value);
  });
}
```

### List Operations
```dart
List<int> numbers = [];
numbers.add(5);              // Add item
numbers.remove(5);           // Remove specific value
numbers.removeAt(0);         // Remove at index
numbers.clear();             // Remove all
numbers.length;              // Count items
numbers.isEmpty;             // Check if empty
numbers[0];                  // Get first item
```

### ListView.builder Template
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('${items[index]}'),
    );
  },
)
```

---

**Congratulations!** 🎉 You've built your first real Flutter app!

Type the code, run it, and experiment. That's how you learn! 🚀
