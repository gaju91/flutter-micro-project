# Quick Notes - Complete Flutter Guide

**Project**: App 3 of Flutter Micro Apps Curriculum
**Time**: 60 minutes
**Difficulty**: Beginner+
**Prerequisites**: Complete p01_counter_with_history and p02_color_picker first

---

## 🎯 What You'll Build

A quick notes app that:
- ✅ Has a text input field (multiline)
- ✅ Auto-saves as you type
- ✅ Persists notes locally (survives app restart)
- ✅ Shows last saved timestamp
- ✅ Has a clear/reset button
- ✅ Works offline (no internet needed)

**Visual Preview:**
```
┌──────────────────────────────┐
│       Quick Notes            │ ← AppBar
├──────────────────────────────┤
│                              │
│  ┌────────────────────────┐  │
│  │ Type your notes here...│  │
│  │                        │  │
│  │                        │  │ ← Multiline TextField
│  │                        │  │
│  │                        │  │
│  └────────────────────────┘  │
│                              │
│  💾 Saved at 2:34 PM         │ ← Status
│                              │
│  [ Clear Notes ]             │ ← Clear button
│                              │
└──────────────────────────────┘
```

---

## 🧠 Concepts You'll Learn

### Core Concepts (NEW):
1. **TextField** - Multiline text input widget
2. **TextEditingController** - Managing text input
3. **SharedPreferences** - Local persistent storage
4. **async/await** - Asynchronous operations
5. **initState** - Widget initialization

### From Previous Apps:
- ✅ StatefulWidget (App 1)
- ✅ setState() (App 1)
- ✅ Column layout (App 1)
- ✅ Buttons (App 1)

---

## 📚 Concept Explanations (Before Coding)

### 1. TextField Widget

**What is it?** A widget for user text input.

**Basic usage:**
```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Enter text',
    hintText: 'Type here...',
  ),
)
```

**Single line vs Multiline:**

**Single line (default):**
```dart
TextField()  // One line, Enter key submits
```

**Multiline:**
```dart
TextField(
  maxLines: null,  // Unlimited lines
  minLines: 3,     // Start with 3 visible lines
)
```

**Properties:**
- `decoration`: Visual styling (borders, labels, hints)
- `maxLines`: Maximum number of lines (null = unlimited)
- `minLines`: Minimum number of visible lines
- `controller`: TextEditingController to manage text
- `onChanged`: Callback when text changes
- `style`: Text style (font size, color)

**Web dev equivalent:**
```html
<!-- HTML -->
<textarea rows="5" placeholder="Type here..."></textarea>

<!-- React -->
<textarea
  value={text}
  onChange={(e) => setText(e.target.value)}
  rows={5}
/>
```

---

### 2. TextEditingController

**What is it?** A controller to manage TextField text programmatically.

**Why need it?**
- ✅ Read current text value
- ✅ Set text programmatically
- ✅ Listen to text changes
- ✅ Clear text easily

**Without controller (limited):**
```dart
TextField(
  onChanged: (value) {
    print(value);  // Can only react to changes
  },
)
// Can't set text, can't clear, can't get value on demand
```

**With controller (full control):**
```dart
class _MyState extends State<MyWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
        ),
        ElevatedButton(
          onPressed: () {
            print(_controller.text);  // Read text anytime
            _controller.text = 'New text';  // Set text
            _controller.clear();  // Clear text
          },
          child: Text('Action'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();  // Clean up when done
    super.dispose();
  }
}
```

**Key operations:**
```dart
// Create controller
final controller = TextEditingController();

// Get text
String text = controller.text;

// Set text
controller.text = 'Hello World';

// Clear text
controller.clear();

// Listen to changes
controller.addListener(() {
  print('Text changed: ${controller.text}');
});

// IMPORTANT: Dispose when done (prevent memory leaks)
controller.dispose();
```

**Web dev equivalent:**
```javascript
// React with ref
const textRef = useRef();

// Get value
const text = textRef.current.value;

// Set value
textRef.current.value = 'Hello';

// Clear
textRef.current.value = '';
```

---

### 3. SharedPreferences (Local Storage)

**What is it?** Flutter's way to save simple data locally (survives app restart).

**Similar to:**
- Web: `localStorage`
- Android: `SharedPreferences`
- iOS: `UserDefaults`

**What can you store?**
- ✅ String (text)
- ✅ int (numbers)
- ✅ double (decimals)
- ✅ bool (true/false)
- ✅ List<String> (list of strings)

**What can't you store directly?**
- ❌ Objects (need JSON conversion)
- ❌ Large files (use file storage)
- ❌ Sensitive data (use secure storage)

**Setup (already done in pubspec.yaml):**
```yaml
dependencies:
  shared_preferences: ^2.0.0
```

**Basic usage:**

**1. Import:**
```dart
import 'package:shared_preferences/shared_preferences.dart';
```

**2. Save data:**
```dart
Future<void> saveNote(String text) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('my_note', text);
}
```

**3. Load data:**
```dart
Future<String?> loadNote() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('my_note');  // Returns null if not found
}
```

**4. Delete data:**
```dart
Future<void> deleteNote() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('my_note');
}
```

**All operations:**
```dart
final prefs = await SharedPreferences.getInstance();

// Save different types
await prefs.setString('name', 'John');
await prefs.setInt('age', 25);
await prefs.setDouble('price', 9.99);
await prefs.setBool('isDark', true);
await prefs.setStringList('tags', ['flutter', 'dart']);

// Load different types
String? name = prefs.getString('name');
int? age = prefs.getInt('age');
double? price = prefs.getDouble('price');
bool? isDark = prefs.getBool('isDark');
List<String>? tags = prefs.getStringList('tags');

// Check if exists
bool hasName = prefs.containsKey('name');

// Delete
await prefs.remove('name');

// Clear all
await prefs.clear();
```

**Web dev equivalent:**
```javascript
// localStorage (Web)
localStorage.setItem('my_note', 'Hello World');
const text = localStorage.getItem('my_note');
localStorage.removeItem('my_note');
localStorage.clear();
```

---

### 4. async/await (Asynchronous Programming)

**What is it?** Way to handle operations that take time (network, file I/O, database).

**Why needed?**
Some operations don't complete instantly:
- Reading from storage (takes milliseconds)
- Network requests (takes seconds)
- File operations (varies)

**Without async (❌ WRONG - blocks UI):**
```dart
String loadData() {
  // This would freeze the app while waiting!
  return readFromDisk();  // Takes time
}
```

**With async (✅ CORRECT - doesn't block):**
```dart
Future<String> loadData() async {
  // App stays responsive while waiting
  String data = await readFromDisk();
  return data;
}
```

**Key concepts:**

**1. Future** - Represents a value that will be available in the future
```dart
Future<String> getData() async {
  // Will return String, but later
  await Future.delayed(Duration(seconds: 2));
  return 'Data loaded';
}
```

**2. async** - Marks function as asynchronous
```dart
Future<void> myFunction() async {
  // Can use 'await' inside
}
```

**3. await** - Waits for Future to complete
```dart
Future<void> example() async {
  print('Start');
  String result = await getData();  // Waits here
  print(result);  // Prints after 2 seconds
}
```

**Flow example:**
```dart
Future<void> saveAndShow() async {
  print('Saving...');
  await save();  // Waits for save to finish
  print('Saved!');  // Runs after save completes
}
```

**Multiple awaits:**
```dart
Future<void> multipleOperations() async {
  await operation1();  // Wait for first
  await operation2();  // Then second
  await operation3();  // Then third
}
```

**Error handling:**
```dart
Future<void> loadData() async {
  try {
    String data = await loadFromDisk();
    print(data);
  } catch (e) {
    print('Error: $e');
  }
}
```

**Web dev equivalent:**
```javascript
// JavaScript async/await
async function loadData() {
  try {
    const response = await fetch('/api/data');
    const data = await response.json();
    return data;
  } catch (error) {
    console.error(error);
  }
}

// Promises (older way)
loadData()
  .then(data => console.log(data))
  .catch(error => console.error(error));
```

---

### 5. initState() - Widget Initialization

**What is it?** Special method that runs once when StatefulWidget is created.

**When does it run?**
```
Widget created
  ↓
initState() called (ONCE)
  ↓
build() called (first time)
  ↓
User interacts
  ↓
setState() called
  ↓
build() called again
  ↓
(initState NOT called again)
```

**Use cases:**
- ✅ Initialize controllers
- ✅ Load saved data
- ✅ Start timers
- ✅ Subscribe to streams
- ✅ One-time setup

**Basic usage:**
```dart
class _MyWidgetState extends State<MyWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();  // MUST call this first

    // Your initialization code here
    _counter = 10;
    print('Widget initialized');
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_counter');
  }
}
```

**Loading data in initState:**
```dart
class _NotesState extends State<Notes> {
  String _note = '';

  @override
  void initState() {
    super.initState();
    _loadNote();  // Load saved note
  }

  Future<void> _loadNote() async {
    final prefs = await SharedPreferences.getInstance();
    final savedNote = prefs.getString('note') ?? '';
    setState(() {
      _note = savedNote;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_note);
  }
}
```

**IMPORTANT: Can't use async directly in initState**
```dart
// ❌ WRONG
@override
void initState() async {  // Can't make initState async!
  super.initState();
  await loadData();
}

// ✅ CORRECT
@override
void initState() {
  super.initState();
  loadData();  // Call async function without await
}

Future<void> loadData() async {
  // Async work here
}
```

**Lifecycle methods:**
```dart
class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
    print('1. Created (runs once)');
  }

  @override
  Widget build(BuildContext context) {
    print('2. Building UI (runs many times)');
    return Container();
  }

  @override
  void dispose() {
    print('3. Destroyed (runs once at end)');
    super.dispose();
  }
}
```

**Web dev equivalent:**
```javascript
// React
useEffect(() => {
  // Runs once on mount
  loadData();
}, []);  // Empty dependency array

// Class component
componentDidMount() {
  // Runs once on mount
  this.loadData();
}
```

---

## 🏗️ Project Structure

```
p03_quick_notes/
├── lib/
│   └── main.dart           ← All your code goes here
├── pubspec.yaml            ← Add shared_preferences dependency
├── README.md               ← This file
└── ... (other Flutter files)
```

---

## 🚀 Step-by-Step Build Guide

### Step 0: Add Dependency

Open `pubspec.yaml` and add `shared_preferences`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
```

Then run:
```bash
cd /Users/gajanandsharma/ai-learnings/flutter/p03_quick_notes
flutter pub get
```

---

### Step 1: Clean Slate

Open `lib/main.dart` and **DELETE EVERYTHING**.

---

### Step 2: Import Statements

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
```

**Two imports:**
1. `material.dart` - Flutter widgets (as before)
2. `shared_preferences.dart` - Local storage

---

### Step 3: Main Function

```dart
void main() {
  runApp(const QuickNotesApp());
}
```

**Same as previous apps** - entry point.

---

### Step 4: Root App Widget

```dart
class QuickNotesApp extends StatelessWidget {
  const QuickNotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const NotesScreen(),
    );
  }
}
```

---

### Step 5: Create StatefulWidget

```dart
class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}
```

---

### Step 6: State Class with Controller

```dart
class _NotesScreenState extends State<NotesScreen> {
  // TextEditingController to manage TextField
  final TextEditingController _controller = TextEditingController();

  // State for last saved time
  String _lastSaved = 'Not saved yet';

  // Storage keys
  static const String _notesKey = 'quick_notes';
  static const String _timestampKey = 'last_saved';

  @override
  void initState() {
    super.initState();
    _loadNote();  // Load saved note when app starts
  }

  @override
  void dispose() {
    _controller.dispose();  // Clean up controller
    super.dispose();
  }

  // Load note from storage
  Future<void> _loadNote() async {
    final prefs = await SharedPreferences.getInstance();
    final savedNote = prefs.getString(_notesKey) ?? '';
    final savedTime = prefs.getString(_timestampKey) ?? '';

    setState(() {
      _controller.text = savedNote;
      if (savedTime.isNotEmpty) {
        _lastSaved = 'Saved at $savedTime';
      }
    });
  }

  // Save note to storage
  Future<void> _saveNote() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_notesKey, _controller.text);

    final now = DateTime.now();
    final timeStr = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
    await prefs.setString(_timestampKey, timeStr);

    setState(() {
      _lastSaved = 'Saved at $timeStr';
    });
  }

  // Clear notes
  Future<void> _clearNote() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_notesKey);
    await prefs.remove(_timestampKey);

    setState(() {
      _controller.clear();
      _lastSaved = 'Notes cleared';
    });
  }

  @override
  Widget build(BuildContext context) {
    // UI code here (see complete code below)
  }
}
```

---

## 🎨 Complete Code

Here's the complete `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const QuickNotesApp());
}

class QuickNotesApp extends StatelessWidget {
  const QuickNotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const NotesScreen(),
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _controller = TextEditingController();
  String _lastSaved = 'Not saved yet';

  static const String _notesKey = 'quick_notes';
  static const String _timestampKey = 'last_saved';

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadNote() async {
    final prefs = await SharedPreferences.getInstance();
    final savedNote = prefs.getString(_notesKey) ?? '';
    final savedTime = prefs.getString(_timestampKey) ?? '';

    setState(() {
      _controller.text = savedNote;
      if (savedTime.isNotEmpty) {
        _lastSaved = 'Saved at $savedTime';
      }
    });
  }

  Future<void> _saveNote() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_notesKey, _controller.text);

    final now = DateTime.now();
    final timeStr = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
    await prefs.setString(_timestampKey, timeStr);

    setState(() {
      _lastSaved = 'Saved at $timeStr';
    });
  }

  Future<void> _clearNote() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_notesKey);
    await prefs.remove(_timestampKey);

    setState(() {
      _controller.clear();
      _lastSaved = 'Notes cleared';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Notes'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Multiline text field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal.shade200, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    hintText: 'Type your notes here...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  style: const TextStyle(fontSize: 16),
                  onChanged: (value) {
                    // Auto-save when text changes (debounced in real app)
                    _saveNote();
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Status row
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Text(
                  _lastSaved,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Buttons row
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _saveNote,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Now'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _clearNote,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Clear'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 📖 Understanding the Code

### Static Const for Keys
```dart
static const String _notesKey = 'quick_notes';
static const String _timestampKey = 'last_saved';
```

**Why?**
- Prevents typos (use `_notesKey` instead of typing string multiple times)
- Easy to change (update once, applies everywhere)
- `static const` = compile-time constant (memory efficient)

---

### TextField Expands
```dart
TextField(
  maxLines: null,     // Unlimited lines
  expands: true,      // Fills available space
  textAlignVertical: TextAlignVertical.top,  // Start from top
)
```

**Properties explained:**
- `maxLines: null` - No line limit
- `expands: true` - Takes all available height (must be in Expanded widget)
- `textAlignVertical: TextAlignVertical.top` - Text starts at top, not center

---

### InputDecoration
```dart
decoration: InputDecoration(
  hintText: 'Type your notes here...',
  border: InputBorder.none,
  contentPadding: EdgeInsets.all(16),
)
```

**Properties:**
- `hintText` - Placeholder text (grey, disappears when typing)
- `border` - Border style (none = no border, we use Container border instead)
- `contentPadding` - Internal spacing

---

### Auto-Save on Change
```dart
TextField(
  onChanged: (value) {
    _saveNote();  // Saves every time text changes
  },
)
```

**How it works:**
```
User types "H"
  ↓
onChanged('H') called
  ↓
_saveNote() runs
  ↓
"H" saved to storage
  ↓
User types "e"
  ↓
onChanged('He') called
  ↓
_saveNote() runs
  ↓
"He" saved to storage
```

**Note:** In production, you'd use debouncing (wait X seconds before saving).

---

### DateTime Formatting
```dart
final now = DateTime.now();
final timeStr = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
```

**Breaking down:**
- `DateTime.now()` - Current date and time
- `now.hour` - Hour (0-23)
- `now.minute.toString().padLeft(2, '0')` - Minute with leading zero
  - `5.toString()` = "5"
  - `5.toString().padLeft(2, '0')` = "05"
- Result: "14:05" instead of "14:5"

---

### Null-Coalescing Operator
```dart
final savedNote = prefs.getString(_notesKey) ?? '';
```

**What `??` does:**
```dart
// If left side is null, use right side
String? value = null;
String result = value ?? 'default';  // result = 'default'

String? value = 'hello';
String result = value ?? 'default';  // result = 'hello'
```

**In our code:**
- If note exists: use saved note
- If note doesn't exist (null): use empty string ''

---

## 🏃 Running Your App

```bash
# Make sure you ran pub get
flutter pub get

# Run the app
flutter run -d chrome
```

---

## 🧪 Testing Your App

### Test 1: Save Note
1. Type some text: "Hello Flutter"
2. Status should show "Saved at [time]"
3. Refresh the page (Ctrl+R / Cmd+R)
4. Text should still be there ✅

### Test 2: Auto-Save
1. Type some text
2. Watch status update automatically
3. Every keystroke saves

### Test 3: Clear Button
1. Type text
2. Press "Clear" button
3. Text disappears
4. Status shows "Notes cleared"

### Test 4: Persistence
1. Type "My important note"
2. Close browser tab completely
3. Re-run app: `flutter run -d chrome`
4. Note should still be there ✅

### Test 5: Long Text
1. Type many lines (50+ lines)
2. TextField should scroll
3. All text should save

### Test 6: Save Now Button
1. Type text
2. Press "Save Now" button
3. Status updates with new timestamp

---

## 🐛 Common Issues & Solutions

### Issue 1: Notes don't persist after restart
**Cause:** Not using `await` with SharedPreferences
**Solution:** Always use `await prefs.setString()`

### Issue 2: "The method 'getString' isn't defined"
**Cause:** Forgot to import `shared_preferences`
**Solution:** Add `import 'package:shared_preferences/shared_preferences.dart';`

### Issue 3: TextField doesn't show loaded text
**Cause:** Setting `_controller.text` outside `setState()`
**Solution:** Always update controller inside `setState(() {})`

### Issue 4: "Bad state: Unhandled exception"
**Cause:** Not calling `flutter pub get` after adding dependency
**Solution:** Run `flutter pub get` in terminal

### Issue 5: Text starts in center instead of top
**Cause:** Missing `textAlignVertical: TextAlignVertical.top`
**Solution:** Add this property to TextField

---

## 🎯 Key Takeaways

After building this app, you now understand:

✅ **TextField** - How to get multiline text input
✅ **TextEditingController** - How to manage and control text
✅ **SharedPreferences** - How to save data locally
✅ **async/await** - How to handle asynchronous operations
✅ **initState()** - How to initialize widgets
✅ **dispose()** - How to clean up resources
✅ **Data persistence** - How apps remember data between sessions

---

## 🚀 Challenges (Try These!)

### Challenge 1: Add Character Count
Show "X characters" below the text field.
Hint: `_controller.text.length`

### Challenge 2: Add Word Count
Show "X words" as well.
Hint: `text.split(' ').where((word) => word.isNotEmpty).length`

### Challenge 3: Multiple Notes
Allow creating multiple named notes.
Show list of notes, tap to edit.

### Challenge 4: Auto-Save with Debouncing
Only save after user stops typing for 2 seconds.
Hint: Use `Timer` and `Timer.cancel()`

### Challenge 5: Dark Mode Toggle
Add switch to enable dark mode.
Save preference with SharedPreferences.

### Challenge 6: Export Notes
Add button to copy all text to clipboard.
Hint: Use `Clipboard.setData()`

### Challenge 7: Last Modified Date
Show full date and time (not just time).
Hint: Format with `intl` package

---

## 📚 Quick Reference

### TextField Template
```dart
TextField(
  controller: _controller,
  maxLines: null,
  decoration: InputDecoration(
    hintText: 'Enter text...',
    border: OutlineInputBorder(),
  ),
  onChanged: (value) {
    // Handle change
  },
)
```

### SharedPreferences Template
```dart
// Save
final prefs = await SharedPreferences.getInstance();
await prefs.setString('key', 'value');

// Load
final value = prefs.getString('key') ?? 'default';

// Remove
await prefs.remove('key');
```

### Controller Pattern
```dart
// In State class
final TextEditingController _controller = TextEditingController();

// In initState
@override
void initState() {
  super.initState();
  _controller.text = 'Initial value';
}

// In dispose
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

### Async Function Template
```dart
Future<void> myAsyncFunction() async {
  try {
    final result = await someAsyncOperation();
    setState(() {
      // Update state with result
    });
  } catch (e) {
    print('Error: $e');
  }
}
```

---

## 🎓 Comparison with Previous Apps

| Aspect | App 1 (Counter) | App 2 (Color Picker) | App 3 (Quick Notes) |
|--------|----------------|----------------------|---------------------|
| **Input method** | Buttons | Sliders | Text field |
| **State type** | int | 3 doubles | String (controller) |
| **Persistence** | None | None | SharedPreferences |
| **Async** | No | No | Yes (async/await) |
| **Initialization** | Simple | Simple | Load saved data |
| **Cleanup** | None | None | Dispose controller |
| **Complexity** | Simple | Moderate | Moderate+ |

---

## 🔗 Next Steps

### Ready for App 4?
Once comfortable with this app, move to:
**App 4: Todo List** - Learn data models, JSON serialization, and swipe gestures!

**What you'll learn:**
- Data models (classes)
- JSON encoding/decoding
- List operations (add, remove, update)
- Checkbox widgets
- Dismissible (swipe to delete)

---

**Congratulations!** 🎉 You've mastered text input and local storage!

Now you can build apps that:
- Take user text input
- Save data between sessions
- Handle async operations
- Manage text programmatically

This is a huge milestone! Most useful apps need these capabilities. 🚀
