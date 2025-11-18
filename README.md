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

---

## 📱 The 8 Apps You'll Build

### 1. Counter with History (45 min)
**What you'll learn**: StatefulWidget, setState, Lists, ListView
**What you'll build**: Counter that tracks all changes in a scrollable list

---

### 2. Color Picker (60 min)
**What you'll learn**: Sliders, Colors, Multiple state variables
**What you'll build**: RGB sliders with live color preview & hex code

### 3. Quick Notes (60 min)
**What you'll learn**: Text input, Local storage, Async operations
**What you'll build**: Sticky note that auto-saves as you type

### 4. Todo List (90 min)
**What you'll learn**: Data models, JSON, Swipe gestures
**What you'll build**: Full CRUD todo app with local persistence

### 5. Random Dog Pictures (60 min)
**What you'll learn**: API calls, Network images, Loading states
**What you'll build**: Fetch & display random dog images from API

### 6. Weather App (90 min)
**What you'll learn**: API keys, Complex JSON, Dynamic UI
**What you'll build**: Real-time weather app with city search

### 7. Expense Tracker (120 min)
**What you'll learn**: Date pickers, Dropdowns, Filtering, Calculations
**What you'll build**: Track expenses by category with totals

### 8. Pomodoro Timer (90 min)
**What you'll learn**: Timers, Duration, Audio playback
**What you'll build**: 25/5 work/break timer with sound alerts

---

## 🚀 Quick Start

```bash
# Navigate to the consolidated project
cd /Users/gajanandsharma/ai-learnings/flutter/flutter_micro_apps

# Install dependencies
flutter pub get

# Run the app
flutter run -d chrome

# You'll see a home screen with tiles for all 8 apps!
# Tap any tile to launch that mini-app
```

---

## 📂 Project Structure

**NEW: All apps are now in ONE single Flutter project!**

```
flutter/
├── README.md                           (you are here)
├── micro-apps-curriculum.md            (detailed guide for all 8 apps)
│
└── flutter_micro_apps/                 ⭐ Main Project (ALL apps here!)
    ├── lib/
    │   ├── main.dart                   # Home screen with app tiles
    │   └── apps/
    │       ├── p01_counter_with_history/
    │       │   ├── index.dart          # App implementation
    │       │   └── README.md           # Detailed guide
    │       ├── p02_color_picker/
    │       ├── p03_quick_notes/
    │       ├── p04_todo_list/          # Coming soon
    │       ├── p05_dog_pictures/       # Coming soon
    │       ├── p06_weather_app/        # Coming soon
    │       ├── p07_expense_tracker/    # Coming soon
    │       └── p08_pomodoro_timer/     # Coming soon
    └── pubspec.yaml                    # All dependencies

Legacy (separate projects - deprecated):
├── p01_counter_with_history/           ⚠️ Old structure
├── p02_color_picker/                   ⚠️ Old structure
└── p03_quick_notes/                    ⚠️ Old structure
```

### Why Single Project?
- ✅ **Easier to manage** - One project instead of 8
- ✅ **Shared dependencies** - Add once, use everywhere
- ✅ **Easy navigation** - See all apps on home screen
- ✅ **Better organization** - Each app is just a folder
- ✅ **Cleaner repo** - No duplicate Flutter boilerplate

---

## 🎓 Learning Approach

### Build → Understand → Master

1. **Run the main app** - `flutter run` to see the home screen with all apps
2. **Choose an app** - Tap any app tile to launch it
3. **Read the guide** - Open the app's README.md for detailed explanation
4. **Study the code** - Open the app's index.dart to see the implementation
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
- ✅ Buttons
- ✅ Sliders
- ✅ Checkboxes
- ✅ Dropdowns
- ✅ Date pickers

### Data & Storage
- ✅ Lists (add, remove, update, filter)
- ✅ Models & classes
- ✅ JSON serialization
- ✅ Local persistence (shared_preferences)

### Network & APIs
- ✅ HTTP requests
- ✅ JSON parsing
- ✅ Loading states
- ✅ Error handling
- ✅ Network images

### Advanced
- ✅ Timers
- ✅ DateTime & Duration
- ✅ Audio playback
- ✅ Gestures (swipe, tap)
- ✅ Debouncing

---

## 📖 How to Use This Repo

### Quick Start (Recommended)

1. Navigate to `flutter_micro_apps/` directory
2. Run `flutter pub get` to install dependencies
3. Run `flutter run -d chrome` to launch the app
4. Tap any app tile to explore it
5. Read the app's README.md for detailed explanation
6. Study the app's index.dart for implementation
7. Experiment and learn!

### Deep Dive (For thorough understanding)

1. Open `micro-apps-curriculum.md` for comprehensive guides
2. Read each app section completely
3. Study the implementation in `flutter_micro_apps/lib/apps/`
4. Modify and experiment with the code
5. Move to the next app

---

## 💡 Tips for Success

1. **Type every line** - Don't copy-paste. Muscle memory matters.
2. **Test frequently** - Run after every small change
3. **Understand before moving on** - Don't rush
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

## 🎁 Bonus: Apps You Can Actually Use

After building these, you'll have:
- ✅ Personal note-taking app
- ✅ Todo list
- ✅ Expense tracker
- ✅ Pomodoro timer for productivity

Deploy them to your phone and use them daily!

---

## 🚀 Ready?

```bash
cd flutter_micro_apps
flutter pub get
flutter run -d chrome
```

**Tap the "Counter with History" tile to start with App 1!**

The best way to learn Flutter is to build. Let's go! 🏃‍♂️💨
