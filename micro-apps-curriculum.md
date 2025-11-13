# Flutter Micro Apps Curriculum
## Progressive Learning Path - Each App Builds on Previous

**Strategy**: Each app introduces 1-2 NEW concepts while practicing what you already learned.

---

## **App 1: Counter with History** ⭐ START HERE
**Time**: 45 mins | **Difficulty**: Beginner

### What's NEW:
- ✨ **StatefulWidget** - Widgets that can change
- ✨ **setState()** - Updating UI when data changes
- ✨ **Lists** - Managing collections of data
- ✨ **ListView** - Scrollable list of widgets

### Reinforces:
- Column, Row layouts (basic UI structure)
- Text, Button widgets
- Basic Dart (variables, functions)

**Note**: If you've never written Dart or Flutter before, don't worry! This first app teaches you everything you need. Just follow along and type the code.

### Features:
- Increment/Decrement counter
- Show history of all values
- Clear history button
- Scroll through history

### Key Concepts:
```dart
// NEW: StatefulWidget
class Counter extends StatefulWidget { }

// NEW: State class
class _CounterState extends State<Counter> {
  int count = 0;           // NEW: State variable
  List<int> history = [];  // NEW: List to track changes

  void increment() {
    setState(() {          // NEW: setState to update UI
      count++;
      history.add(count);  // NEW: Adding to list
    });
  }
}

// NEW: ListView to show history
ListView.builder(
  itemCount: history.length,
  itemBuilder: (context, index) => Text('${history[index]}'),
)
```

### What You'll Learn:
- How to make widgets that change over time
- How to update UI when data changes
- How to work with lists
- How to display lists efficiently

---

## **App 2: Color Picker** ⭐
**Time**: 60 mins | **Difficulty**: Beginner+

### What's NEW:
- ✨ **Slider widget** - Interactive range input
- ✨ **Color class** - Working with colors programmatically
- ✨ **Multiple state variables** - Managing related state
- ✨ **Container decoration** - Styling containers

### Reinforces:
- ✅ StatefulWidget (from App 1)
- ✅ setState() (from App 1)
- ✅ Column layout

### Features:
- 3 sliders (Red, Green, Blue)
- Live color preview
- Show RGB values
- Show hex color code

### Key Concepts:
```dart
class _ColorPickerState extends State<ColorPicker> {
  double red = 0;    // NEW: Multiple state variables
  double green = 0;
  double blue = 0;

  Color get currentColor => Color.fromRGBO(  // NEW: Color creation
    red.toInt(),
    green.toInt(),
    blue.toInt(),
    1.0
  );

  // NEW: Slider widget
  Slider(
    value: red,
    min: 0,
    max: 255,
    onChanged: (value) {
      setState(() => red = value);  // Update on slide
    },
  )

  // NEW: Container with color
  Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: currentColor,  // NEW: Dynamic color
      borderRadius: BorderRadius.circular(12),
    ),
  )
}
```

### What You'll Learn:
- How to use Slider for user input
- How to work with RGB colors
- How to manage multiple related state variables
- How to create computed values (getter)

---

## **App 3: Quick Notes (Single Note)** ⭐
**Time**: 60 mins | **Difficulty**: Intermediate

### What's NEW:
- ✨ **TextEditingController** - Managing text input
- ✨ **TextField** - Multiline text input
- ✨ **shared_preferences** - Saving data locally
- ✨ **async/await** - Asynchronous operations
- ✨ **initState/dispose** - Widget lifecycle

### Reinforces:
- ✅ StatefulWidget
- ✅ setState()

### Features:
- Single text area (like sticky note)
- Auto-saves every 2 seconds
- Loads saved note on app start
- Character count

### Key Concepts:
```dart
class _QuickNoteState extends State<QuickNote> {
  late TextEditingController _controller;  // NEW: late keyword
  Timer? _saveTimer;                       // NEW: Timer for debouncing

  @override
  void initState() {                       // NEW: Lifecycle method
    super.initState();
    _controller = TextEditingController();
    _loadNote();                           // NEW: Load on start
  }

  @override
  void dispose() {                         // NEW: Cleanup
    _controller.dispose();                 // NEW: Must dispose controller
    _saveTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadNote() async {         // NEW: async function
    final prefs = await SharedPreferences.getInstance();  // NEW: await
    final text = prefs.getString('note') ?? '';
    _controller.text = text;
  }

  void _onTextChanged() {
    _saveTimer?.cancel();
    _saveTimer = Timer(Duration(seconds: 2), _saveNote);  // NEW: Debouncing
  }

  Future<void> _saveNote() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('note', _controller.text);
  }

  // NEW: TextField
  TextField(
    controller: _controller,
    maxLines: null,       // NEW: Unlimited lines
    expands: true,        // NEW: Fill space
    onChanged: (_) => _onTextChanged(),
  )
}
```

### What You'll Learn:
- How to manage text input with controllers
- How to save data that persists after app closes
- How to work with async/await
- How to debounce (delay action until user stops typing)
- Widget lifecycle (initState, dispose)

---

## **App 4: Todo List (Local Only)** ⭐
**Time**: 90 mins | **Difficulty**: Intermediate

### What's NEW:
- ✨ **List operations** - Add, remove, toggle
- ✨ **Custom models** - Todo class with properties
- ✨ **JSON serialization** - Convert objects to/from JSON
- ✨ **Checkbox widget** - Boolean UI element
- ✨ **Dismissible** - Swipe to delete

### Reinforces:
- ✅ StatefulWidget
- ✅ setState()
- ✅ ListView.builder
- ✅ TextEditingController
- ✅ shared_preferences
- ✅ async/await

### Features:
- Add todos with text input
- Mark todos as complete
- Delete todos (swipe)
- Persist todos locally
- Show count of completed/total

### Key Concepts:
```dart
// NEW: Custom model class
class Todo {
  final String id;
  final String text;
  final bool isDone;

  Todo({required this.id, required this.text, this.isDone = false});

  // NEW: JSON serialization
  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'isDone': isDone,
  };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'],
    text: json['text'],
    isDone: json['isDone'],
  );
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = todos.map((t) => t.toJson()).toList();  // NEW: map
    await prefs.setString('todos', jsonEncode(jsonList));    // NEW: jsonEncode
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('todos') ?? '[]';
    final jsonList = jsonDecode(jsonString) as List;         // NEW: jsonDecode
    todos = jsonList.map((j) => Todo.fromJson(j)).toList();
    setState(() {});
  }

  void _toggleTodo(String id) {
    setState(() {
      final index = todos.indexWhere((t) => t.id == id);    // NEW: indexWhere
      final todo = todos[index];
      todos[index] = Todo(                                   // NEW: replacing item
        id: todo.id,
        text: todo.text,
        isDone: !todo.isDone
      );
    });
    _saveTodos();
  }

  // NEW: Dismissible widget
  Dismissible(
    key: Key(todo.id),
    onDismissed: (_) => _deleteTodo(todo.id),
    background: Container(color: Colors.red),
    child: CheckboxListTile(                               // NEW: CheckboxListTile
      value: todo.isDone,
      onChanged: (_) => _toggleTodo(todo.id),
      title: Text(todo.text),
    ),
  )
}
```

### What You'll Learn:
- How to create custom data models
- How to convert objects to/from JSON
- How to work with lists (add, remove, update)
- How to use Dismissible for swipe gestures
- How to use Checkbox widgets

---

## **App 5: Random Dog Pictures** ⭐
**Time**: 60 mins | **Difficulty**: Intermediate

### What's NEW:
- ✨ **HTTP package** - Making API calls
- ✨ **Network images** - Loading images from URLs
- ✨ **Loading states** - Show spinner while loading
- ✨ **Error handling** - try/catch blocks
- ✨ **CircularProgressIndicator** - Loading spinner

### Reinforces:
- ✅ StatefulWidget
- ✅ setState()
- ✅ async/await

### Features:
- Fetch random dog image from API
- Show image full screen
- "Next" button to get new image
- Loading indicator
- Error message if fails

### Key Concepts:
```dart
import 'package:http/http.dart' as http;  // NEW: HTTP package
import 'dart:convert';

class _DogPicturesState extends State<DogPictures> {
  String? imageUrl;
  bool isLoading = false;  // NEW: Loading state
  String? error;           // NEW: Error state

  Future<void> _fetchDog() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {                                        // NEW: try/catch
      final response = await http.get(           // NEW: HTTP GET request
        Uri.parse('https://dog.ceo/api/breeds/image/random')
      );

      if (response.statusCode == 200) {          // NEW: Check status code
        final data = jsonDecode(response.body);  // Parse JSON response
        setState(() {
          imageUrl = data['message'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {                                // NEW: Catch errors
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // NEW: Conditional UI based on state
    if (isLoading) {
      return CircularProgressIndicator();        // NEW: Loading spinner
    }

    if (error != null) {
      return Text('Error: $error');
    }

    return Column(
      children: [
        // NEW: Network image
        Image.network(
          imageUrl ?? '',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return CircularProgressIndicator();
          },
        ),
        ElevatedButton(
          onPressed: _fetchDog,
          child: Text('Next Dog'),
        ),
      ],
    );
  }
}
```

### What You'll Learn:
- How to make HTTP requests to APIs
- How to parse JSON responses
- How to handle loading states
- How to handle errors gracefully
- How to load images from network

---

## **App 6: Weather App** ⭐
**Time**: 90 mins | **Difficulty**: Intermediate+

### What's NEW:
- ✨ **API keys** - Using environment variables
- ✨ **Query parameters** - Sending data in URLs
- ✨ **Icons based on data** - Dynamic UI
- ✨ **User input with API** - TextField triggers API call
- ✨ **Data models** - Complex JSON parsing

### Reinforces:
- ✅ HTTP requests (from App 5)
- ✅ async/await
- ✅ Loading states (from App 5)
- ✅ Error handling (from App 5)
- ✅ TextEditingController (from App 3)

### Features:
- Enter city name
- Fetch current weather
- Show temperature, conditions, humidity
- Icon changes based on weather
- Error if city not found

### Key Concepts:
```dart
class Weather {                          // NEW: Complex model
  final String city;
  final double temp;
  final String condition;
  final int humidity;

  Weather.fromJson(Map<String, dynamic> json)
    : city = json['name'],
      temp = json['main']['temp'].toDouble(),     // NEW: Nested JSON
      condition = json['weather'][0]['main'],     // NEW: Array in JSON
      humidity = json['main']['humidity'];
}

class _WeatherAppState extends State<WeatherApp> {
  final String apiKey = 'YOUR_API_KEY';  // NEW: API key

  Future<Weather> _fetchWeather(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather'
      '?q=$city'                         // NEW: Query parameter
      '&appid=$apiKey'                   // NEW: API key in URL
      '&units=metric'
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('City not found');
    }
  }

  IconData _getWeatherIcon(String condition) {  // NEW: Dynamic icons
    switch (condition) {
      case 'Clear': return Icons.wb_sunny;
      case 'Clouds': return Icons.cloud;
      case 'Rain': return Icons.beach_access;
      default: return Icons.wb_cloudy;
    }
  }
}
```

### What You'll Learn:
- How to use API keys securely
- How to send parameters in API requests
- How to parse complex nested JSON
- How to change UI based on data
- How to handle user input with APIs

---

## **App 7: Expense Tracker** ⭐
**Time**: 120 mins | **Difficulty**: Advanced

### What's NEW:
- ✨ **DateTime picker** - Selecting dates
- ✨ **Dropdown** - Select from options
- ✨ **Filtering** - Show subset of data
- ✨ **Calculations** - Sum, average, grouping
- ✨ **Charts** (optional)** - Visual data representation

### Reinforces:
- ✅ Custom models (from App 4)
- ✅ JSON serialization (from App 4)
- ✅ ListView (from App 1)
- ✅ TextField (from App 3)
- ✅ shared_preferences (from App 3)
- ✅ Dismissible (from App 4)

### Features:
- Add expenses (amount, category, date)
- List all expenses
- Filter by category
- Show total spent
- Delete expenses
- Persist data

### Key Concepts:
```dart
enum Category { food, transport, entertainment, other }  // NEW: Enum

class Expense {
  final String id;
  final double amount;
  final Category category;
  final DateTime date;
  final String note;

  // JSON serialization with enum
  Map<String, dynamic> toJson() => {
    'category': category.toString(),     // NEW: Enum to string
  };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    category: Category.values.firstWhere(  // NEW: String to enum
      (c) => c.toString() == json['category']
    ),
  );
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  List<Expense> expenses = [];
  Category? selectedFilter;

  List<Expense> get filteredExpenses {   // NEW: Computed list
    if (selectedFilter == null) return expenses;
    return expenses.where(              // NEW: Filtering
      (e) => e.category == selectedFilter
    ).toList();
  }

  double get totalSpent {                // NEW: Reduce/sum
    return expenses.fold(0.0, (sum, e) => sum + e.amount);
  }

  // NEW: Date picker
  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  // NEW: Dropdown
  DropdownButton<Category>(
    value: selectedFilter,
    items: Category.values.map((cat) {
      return DropdownMenuItem(
        value: cat,
        child: Text(cat.toString().split('.').last),  // NEW: Enum display
      );
    }).toList(),
    onChanged: (value) {
      setState(() => selectedFilter = value);
    },
  )
}
```

### What You'll Learn:
- How to use enums for categories
- How to use date picker
- How to use dropdown menus
- How to filter lists
- How to calculate totals and aggregates

---

## **App 8: Pomodoro Timer** ⭐
**Time**: 90 mins | **Difficulty**: Advanced

### What's NEW:
- ✨ **Timer class** - Periodic events
- ✨ **Duration** - Time calculations
- ✨ **Sound** - Playing audio
- ✨ **Background state** - Keep timer running
- ✨ **Circular progress** - Visual timer

### Reinforces:
- ✅ StatefulWidget
- ✅ setState()

### Features:
- 25 min work / 5 min break
- Start/pause/reset
- Show countdown
- Circular progress indicator
- Sound when complete
- Auto-switch work/break

### Key Concepts:
```dart
import 'dart:async';                    // NEW: Timer
import 'package:audioplayers/audioplayers.dart';  // NEW: Audio

class _PomodoroState extends State<Pomodoro> {
  Timer? _timer;                        // NEW: Timer instance
  Duration workDuration = Duration(minutes: 25);
  Duration breakDuration = Duration(minutes: 5);
  Duration currentDuration = Duration(minutes: 25);
  Duration remaining = Duration(minutes: 25);
  bool isRunning = false;
  bool isWorkTime = true;

  void _startTimer() {
    isRunning = true;
    _timer = Timer.periodic(            // NEW: Timer.periodic
      Duration(seconds: 1),
      (timer) {
        setState(() {
          if (remaining.inSeconds > 0) {
            remaining = Duration(seconds: remaining.inSeconds - 1);
          } else {
            _onTimerComplete();
          }
        });
      },
    );
  }

  void _pauseTimer() {
    _timer?.cancel();                   // NEW: Cancel timer
    setState(() => isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      isRunning = false;
      remaining = currentDuration;
    });
  }

  Future<void> _onTimerComplete() async {
    _timer?.cancel();

    // NEW: Play sound
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/bell.mp3'));

    // Switch work/break
    setState(() {
      isWorkTime = !isWorkTime;
      currentDuration = isWorkTime ? workDuration : breakDuration;
      remaining = currentDuration;
      isRunning = false;
    });
  }

  String _formatDuration(Duration d) {  // NEW: Duration formatting
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}';
  }

  // NEW: Circular progress
  CircularProgressIndicator(
    value: 1 - (remaining.inSeconds / currentDuration.inSeconds),
    strokeWidth: 8,
  )

  @override
  void dispose() {
    _timer?.cancel();                   // NEW: Cancel in dispose
    super.dispose();
  }
}
```

### What You'll Learn:
- How to use Timer for periodic updates
- How to work with Duration
- How to play sounds
- How to format time displays
- How to cancel timers properly

---

## **Learning Progression Summary**

```
App 1: Counter
  └─> Teaches: StatefulWidget, setState, Lists, ListView

App 2: Color Picker
  └─> NEW: Slider, Colors, Multiple state
  └─> Uses: StatefulWidget, setState

App 3: Quick Notes
  └─> NEW: TextEditingController, shared_preferences, async/await, lifecycle
  └─> Uses: StatefulWidget, setState

App 4: Todo List
  └─> NEW: Models, JSON, List operations, Dismissible
  └─> Uses: TextEditingController, shared_preferences, ListView

App 5: Random Dog Pictures
  └─> NEW: HTTP, Network images, Loading states, Error handling
  └─> Uses: StatefulWidget, async/await

App 6: Weather App
  └─> NEW: API keys, Query params, Complex JSON, Dynamic UI
  └─> Uses: HTTP, Loading states, TextEditingController

App 7: Expense Tracker
  └─> NEW: Enums, DatePicker, Dropdown, Filtering, Calculations
  └─> Uses: Models, JSON, ListView, shared_preferences

App 8: Pomodoro Timer
  └─> NEW: Timer, Duration, Audio, Circular progress
  └─> Uses: StatefulWidget, setState, lifecycle
```

---

## **Concept Mastery Checklist**

After completing all 8 apps, you will have mastered:

### State Management
- ✅ StatefulWidget vs StatelessWidget
- ✅ setState() for updating UI
- ✅ Managing multiple state variables
- ✅ Computed properties (getters)

### Widgets
- ✅ Text, Button, Icon
- ✅ TextField (single & multi-line)
- ✅ ListView.builder
- ✅ Slider
- ✅ Checkbox
- ✅ Dropdown
- ✅ Dismissible
- ✅ CircularProgressIndicator
- ✅ Image.network

### Data & Persistence
- ✅ Lists (add, remove, update, filter)
- ✅ Custom models
- ✅ JSON serialization
- ✅ shared_preferences
- ✅ Enums

### Async Programming
- ✅ async/await
- ✅ Future
- ✅ HTTP requests
- ✅ Error handling (try/catch)
- ✅ Loading states

### Lifecycle
- ✅ initState
- ✅ dispose
- ✅ Controllers (create & dispose)

### APIs & Network
- ✅ HTTP GET requests
- ✅ JSON parsing
- ✅ API keys
- ✅ Query parameters
- ✅ Network images

### Time & Dates
- ✅ DateTime
- ✅ Duration
- ✅ Timer
- ✅ DatePicker

### Advanced
- ✅ Debouncing
- ✅ Filtering & sorting
- ✅ Calculations (sum, average)
- ✅ Playing sounds
- ✅ Dynamic UI based on data

---

## **Next Steps After Completing All 8**

You'll be ready for:
- Provider state management
- SQLite database
- Firebase integration
- Complex navigation
- Animations
- Custom widgets
- Publishing to stores

---

## **Time Investment**

- **Total Time:** ~10 hours (spread over 2-3 weeks)
- **Average:** 1 app every 2-3 days
- **Result:** Solid Flutter foundation

---

## **How to Use This Curriculum**

1. Build apps IN ORDER (each builds on previous)
2. Type ALL code yourself (no copy-paste)
3. Understand EVERY line before moving on
4. Experiment with variations
5. Take breaks between apps to let concepts sink in

---

**Ready to start with App 1: Counter with History?**
