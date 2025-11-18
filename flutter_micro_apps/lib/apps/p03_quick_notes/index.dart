import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuickNotesApp extends StatefulWidget {
  const QuickNotesApp({Key? key}) : super(key: key);

  @override
  State<QuickNotesApp> createState() => _QuickNotesAppState();
}

class _QuickNotesAppState extends State<QuickNotesApp> {
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
      appBar: AppBar(title: const Text('Quick Notes'), elevation: 0),
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
                    // Auto-save when text changes
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
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
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
