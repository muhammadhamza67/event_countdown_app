import 'package:flutter/material.dart';
import '../services/event_storage.dart';
import '../models/event.dart';
import 'edit_event_screen.dart';
import 'add_event_screen.dart';
import 'event_details_screen.dart';
import 'events_list_screen.dart';
import 'profile_preferences_screen.dart';
import 'dart:async';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _selectedIndex = 0;
  late Future<List<Event>> _eventsFuture;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _eventsFuture = _loadAndUpdateEvents();

    // Refresh every minute to keep countdowns live
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      setState(() {
        _eventsFuture = _loadAndUpdateEvents();
      });
    });
  }

  Future<List<Event>> _loadAndUpdateEvents() async {
    final events = await EventStorage.loadEvents();
    for (var e in events) {
      final now = DateTime.now();
      final target = e.dateTime;
      final diff = target.difference(now);

      // Remaining time
      e.days = diff.inDays.toString();
      e.hours = (diff.inHours % 24).toString();
      e.minutes = (diff.inMinutes % 60).toString();

      // Progress: 1 means complete, 0 means just started
      final totalDuration = target.difference(e.createdAt);
      if (totalDuration.inSeconds > 0) {
        final progress =
            1 - (diff.inSeconds / totalDuration.inSeconds).clamp(0.0, 1.0);
        e.progressValue = progress;
      } else {
        e.progressValue = 1.0;
      }
    }
    return events;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final List<Widget> _staticScreens = const [
    AddEventScreen(),
    EventsListScreen(),
    EditEventScreen(),
    EventDetailsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6FA),
      body: _selectedIndex == 0
          ? DashboardView(eventsFuture: _eventsFuture)
          : _staticScreens[_selectedIndex - 1],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFFDF6FA),
        selectedItemColor: const Color(0xFFA961C3),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.edit_calendar_outlined), label: 'Edit'),
          BottomNavigationBarItem(icon: Icon(Icons.event_available_outlined), label: 'Details'),
        ],
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  final Future<List<Event>> eventsFuture;
  const DashboardView({super.key, required this.eventsFuture});

  /// Dynamic progress color based on remaining time
  Color _getProgressColor(double progressValue) {
    if (progressValue <= 0.33) {
      return Colors.green; // plenty of time left
    } else if (progressValue <= 0.66) {
      return Colors.orange; // medium time left
    } else {
      return Colors.red; // almost due
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6FA),
        elevation: 0,
        title: const Text(
          "Hello, Hamza",
          style: TextStyle(
            color: Color(0xFFA961C3),
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Color(0xFFA961C3)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePreferencesScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Event>>(
        future: eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFA961C3)));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No events found."));
          }

          final events = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: _buildEventCard(
                  title: event.title,
                  date: event.dateTime,
                  days: event.days,
                  hours: event.hours,
                  minutes: event.minutes,
                  progressValue: event.progressValue,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEventCard({
    required String title,
    required DateTime date,
    required String days,
    required String hours,
    required String minutes,
    required double progressValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        Text(
          "${date.month}/${date.day}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2,'0')}",
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            _buildTimeBox(days, "Days"),
            const SizedBox(width: 10),
            _buildTimeBox(hours, "Hours"),
            const SizedBox(width: 10),
            _buildTimeBox(minutes, "Minutes"),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progressValue,
          color: _getProgressColor(progressValue),
          backgroundColor: Colors.grey[300],
          minHeight: 10,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }

  Widget _buildTimeBox(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }
}
