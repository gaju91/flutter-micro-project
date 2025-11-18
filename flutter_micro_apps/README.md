# Flutter Micro Apps - Learn by Doing

**Philosophy**: Learn Flutter by building real, useful apps. No theory-heavy lectures. Just code, build, understand.

---

## 🎯 What This Is

**8 progressive micro apps** that teach Flutter from scratch through hands-on building.

- ✅ **No prerequisites** - Start from zero
- ✅ **Learn by doing** - Build real apps, not toy examples
- ✅ **Progressive** - Each app introduces new concepts
- ✅ **Standalone** - Complete in itself, no external courses needed
- ✅ **Practical** - Apps you can actually use
- ✅ **Single Project** - All apps in one Flutter project!

---

## 📱 The 8 Apps You'll Build

### ✅ 1. Counter with History (45 min) - COMPLETED
**What you'll learn**: StatefulWidget, setState, Lists, ListView
**What you'll build**: Counter that tracks all changes in a scrollable list

### ✅ 2. Color Picker (60 min) - COMPLETED
**What you'll learn**: Sliders, Colors, Multiple state variables
**What you'll build**: RGB sliders with live color preview & hex code

### ✅ 3. Quick Notes (60 min) - COMPLETED
**What you'll learn**: Text input, Local storage, Async operations
**What you'll build**: Sticky note that auto-saves as you type

### 🔜 4. Todo List (90 min) - Coming Soon
**What you'll learn**: Data models, JSON, Swipe gestures
**What you'll build**: Full CRUD todo app with local persistence

### 🔜 5. Random Dog Pictures (60 min) - Coming Soon
**What you'll learn**: API calls, Network images, Loading states
**What you'll build**: Fetch & display random dog images from API

### 🔜 6. Weather App (90 min) - Coming Soon
**What you'll learn**: API keys, Complex JSON, Dynamic UI
**What you'll build**: Real-time weather app with city search

### 🔜 7. Expense Tracker (120 min) - Coming Soon
**What you'll learn**: Date pickers, Dropdowns, Filtering, Calculations
**What you'll build**: Track expenses by category with totals

### 🔜 8. Pomodoro Timer (90 min) - Coming Soon
**What you'll learn**: Timers, Duration, Audio playback
**What you'll build**: 25/5 work/break timer with sound alerts

---

## 🚀 Quick Start

```bash
# Navigate to the project
cd /Users/gajanandsharma/ai-learnings/flutter/flutter_micro_apps

# Install dependencies
flutter pub get

# Run the app
flutter run -d chrome
# or
flutter run -d macos
```

You'll see a home screen with tiles for all 8 apps. Tap any tile to launch that mini-app!

---

## 📂 Project Structure

```
flutter_micro_apps/
├── lib/
│   ├── main.dart                          # Home screen with app tiles
│   └── apps/
│       ├── p01_counter_with_history/
│       │   ├── index.dart                 # Counter app implementation
│       │   └── README.md                  # Detailed guide for this app
│       ├── p02_color_picker/
│       │   ├── index.dart                 # Color picker implementation
│       │   └── README.md                  # Detailed guide for this app
│       ├── p03_quick_notes/
│       │   ├── index.dart                 # Quick notes implementation
│       │   └── README.md                  # Detailed guide for this app
│       ├── p04_todo_list/                 # Coming soon
│       ├── p05_dog_pictures/              # Coming soon
│       ├── p06_weather_app/               # Coming soon
│       ├── p07_expense_tracker/           # Coming soon
│       └── p08_pomodoro_timer/            # Coming soon
├── pubspec.yaml                           # All dependencies
└── README.md                              # This file
```

### Benefits of Single Project Structure:
- ✅ **Easier to manage** - One project instead of 8
- ✅ **Shared dependencies** - Add once, use everywhere
- ✅ **Easy navigation** - See all apps in one place
- ✅ **Better organization** - Each app is just a folder
- ✅ **Cleaner repo** - No duplicate Flutter boilerplate

---

## 🎓 Learning Approach

### Build → Understand → Master

1. **Launch the app** - Run `flutter run` to see the home screen
2. **Choose an app** - Tap any app tile to open it
3. **Read the guide** - Check the app's README.md for detailed explanation
4. **Study the code** - Open the app's index.dart file
5. **Experiment** - Modify values, break things, fix them
6. **Move to next app** - Builds on what you just learned

### No Prerequisites

Start at App 1 even if you've never written Dart or Flutter before. The curriculum teaches you everything as you build.

---

## ⏱️ Time Investment

- **Each app**: 45-120 mins
- **Total**: ~10 hours
- **Recommended pace**: 1-2 apps per week
- **Result**: Solid Flutter foundation in 1 month

---

## 🎯 Concept Progression

```
App 1: Counter
  └─> Learn: StatefulWidget, setState, Lists

App 2: Color Picker
  └─> NEW: Sliders, Colors, Multiple state
  └─> Practice: StatefulWidget, setState

App 3: Quick Notes
  └─> NEW: Text input, Local storage, Async
  └─> Practice: StatefulWidget, setState

App 4: Todo List
  └─> NEW: Models, JSON, Gestures
  └─> Practice: Text input, Local storage, Lists

App 5: Dog Pictures
  └─> NEW: HTTP, Network images, Loading
  └─> Practice: Async operations

App 6: Weather
  └─> NEW: API keys, Complex JSON
  └─> Practice: HTTP, Loading, Text input

App 7: Expenses
  └─> NEW: Pickers, Dropdowns, Filtering
  └─> Practice: Models, JSON, Storage

App 8: Pomodoro
  └─> NEW: Timers, Audio
  └─> Practice: StatefulWidget, DateTime
```

---

## 🏆 What You'll Know After All 8 Apps

### Core Flutter
- ✅ Widgets (Stateless & Stateful)
- ✅ Layouts (Column, Row, ListView)
- ✅ State management (setState)
- ✅ Navigation
- ✅ Lifecycle (initState, dispose)

### User Input
- ✅ TextField (single & multi-line)
- ✅ Buttons, Sliders, Checkboxes, Dropdowns, Date pickers

### Data & Storage
- ✅ Lists, Models & classes, JSON serialization
- ✅ Local persistence (shared_preferences)

### Network & APIs
- ✅ HTTP requests, JSON parsing, Loading states, Error handling

### Advanced
- ✅ Timers, DateTime & Duration, Audio playback, Gestures

---

## 💡 Tips for Success

1. **Run the app first** - See what you're building
2. **Read the README** - Each app has detailed explanations
3. **Study the code** - Understand every line
4. **Experiment** - Change values, break things, fix them
5. **Take breaks** - Let concepts sink in between apps
6. **Build in order** - Each app teaches prerequisites for the next

---

## 🔧 Requirements

- Flutter SDK installed
- Code editor (VS Code recommended)
- Chrome (for web testing) or device emulator
- 10 hours of focused time

---

## 🚦 Getting Started

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run the app**:
   ```bash
   flutter run -d chrome
   ```

3. **Start with App 1**: Tap the "Counter with History" tile

4. **Read the guide**: Open `lib/apps/p01_counter_with_history/README.md`

5. **Study the code**: Open `lib/apps/p01_counter_with_history/index.dart`

6. **Experiment and learn!**

---

**Ready?** 🚀

Run `flutter run` and start building! The best way to learn Flutter is to code. Let's go! 🏃‍♂️💨
