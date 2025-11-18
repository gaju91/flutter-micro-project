import 'package:flutter/material.dart';
import 'apps/p01_counter_with_history/index.dart';
import 'apps/p02_color_picker/index.dart';
import 'apps/p03_quick_notes/index.dart';

void main() {
  runApp(const FlutterMicroAppsMain());
}

class FlutterMicroAppsMain extends StatelessWidget {
  const FlutterMicroAppsMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Micro Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Micro Apps'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade50,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Learn Flutter by Building',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '8 progressive micro apps from scratch',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.95,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      AppTile(
                        title: 'Counter with\nHistory',
                        subtitle: '45 min',
                        icon: Icons.add_circle_outline,
                        color: Colors.pink,
                        isCompleted: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CounterWithHistoryApp(),
                            ),
                          );
                        },
                      ),
                      AppTile(
                        title: 'Color\nPicker',
                        subtitle: '60 min',
                        icon: Icons.palette_outlined,
                        color: Colors.purple,
                        isCompleted: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ColorPickerApp(),
                            ),
                          );
                        },
                      ),
                      AppTile(
                        title: 'Quick\nNotes',
                        subtitle: '60 min',
                        icon: Icons.note_outlined,
                        color: Colors.teal,
                        isCompleted: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuickNotesApp(),
                            ),
                          );
                        },
                      ),
                      AppTile(
                        title: 'Todo\nList',
                        subtitle: '90 min',
                        icon: Icons.checklist_outlined,
                        color: Colors.orange,
                        isCompleted: false,
                        onTap: () {
                          _showComingSoon(context, 'Todo List');
                        },
                      ),
                      AppTile(
                        title: 'Dog\nPictures',
                        subtitle: '60 min',
                        icon: Icons.pets_outlined,
                        color: Colors.brown,
                        isCompleted: false,
                        onTap: () {
                          _showComingSoon(context, 'Dog Pictures');
                        },
                      ),
                      AppTile(
                        title: 'Weather\nApp',
                        subtitle: '90 min',
                        icon: Icons.wb_sunny_outlined,
                        color: Colors.blue,
                        isCompleted: false,
                        onTap: () {
                          _showComingSoon(context, 'Weather App');
                        },
                      ),
                      AppTile(
                        title: 'Expense\nTracker',
                        subtitle: '120 min',
                        icon: Icons.account_balance_wallet_outlined,
                        color: Colors.green,
                        isCompleted: false,
                        onTap: () {
                          _showComingSoon(context, 'Expense Tracker');
                        },
                      ),
                      AppTile(
                        title: 'Pomodoro\nTimer',
                        subtitle: '90 min',
                        icon: Icons.timer_outlined,
                        color: Colors.red,
                        isCompleted: false,
                        onTap: () {
                          _showComingSoon(context, 'Pomodoro Timer');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String appName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$appName - Coming Soon!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class AppTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isCompleted;
  final VoidCallback onTap;

  const AppTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isCompleted ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(isCompleted ? 0.1 : 0.05),
                color.withOpacity(isCompleted ? 0.2 : 0.1),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Icon(
                    icon,
                    size: 42,
                    color: color,
                  ),
                  if (isCompleted)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
