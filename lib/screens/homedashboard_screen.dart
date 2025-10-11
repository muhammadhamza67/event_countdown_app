import 'package:flutter/material.dart';

// ✅ Import all your other screens
import 'package:event_countdown_app/screens/edit_event_screen.dart';
import 'package:event_countdown_app/screens/add_event_screen.dart';
import 'package:event_countdown_app/screens/event_details_screen.dart';
import 'package:event_countdown_app/screens/events_list_screen.dart';
import 'package:event_countdown_app/screens/profile_preferences_screen.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6FA), // 🌸 Soft background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6FA),
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Hello, Hamza",
            style: TextStyle(
              color: Color(0xFFA961C3),
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 0.5,
            ),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFFA961C3)),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),

      // 🟣 Drawer Menu
      endDrawer: Drawer(
        backgroundColor: const Color(0xFFFDF6FA),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFA961C3),
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // 🔹 Navigation Items
            _drawerItem(
              context,
              "Add Event",
              Icons.add_circle_outline,
              const AddEventScreen(),
            ),
            _drawerItem(
              context,
              "Edit Event",
              Icons.edit_calendar,
              const EditEventScreen(),
            ),
            _drawerItem(
              context,
              "Event Details",
              Icons.event_available,
              const EventDetailsScreen(),
            ),
            _drawerItem(
              context,
              "Events List",
              Icons.list_alt,
              const EventsListScreen(),
            ),
            _drawerItem(
              context,
              "Profile Preferences",
              Icons.person_outline,
              const ProfilePreferencesScreen(),
            ),
          ],
        ),
      ),

      // 🧱 Dashboard Body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Event Cards
            _buildEventCard(
              title: "Exam Deadline",
              date: "Tomorrow, August 13, 5:00 PM",
              days: "02",
              hours: "03",
              minutes: "25",
              color: Colors.green,
              progressValue: 0.3,
            ),
            const SizedBox(height: 25),
            _buildEventCard(
              title: "Team Meeting",
              date: "Monday, August 15, 5:00 PM",
              days: "05",
              hours: "07",
              minutes: "40",
              color: Colors.orange,
              progressValue: 0.55,
            ),
            const SizedBox(height: 25),
            _buildEventCard(
              title: "Project Presentation",
              date: "Friday, August 25, 2:00 PM",
              days: "15",
              hours: "17",
              minutes: "30",
              color: Colors.red,
              progressValue: 0.75,
            ),

            const Spacer(),

            // ➕ Add Event Button
            Center(
              child: FloatingActionButton(
                backgroundColor: const Color(0xFFA961C3),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddEventScreen()),
                  );
                },
                child: const Icon(Icons.add, size: 30, color: Colors.white),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // 🔹 Drawer Item Widget
  static ListTile _drawerItem(
    BuildContext context,
    String title,
    IconData icon,
    Widget destination,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFA961C3)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFA961C3),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // close drawer
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }

  // 🔹 Event Card Widget
  Widget _buildEventCard({
    required String title,
    required String date,
    required String days,
    required String hours,
    required String minutes,
    required Color color,
    required double progressValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
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
          color: color,
          backgroundColor: Colors.grey[300],
          minHeight: 10,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }

  // 🔹 Countdown Box Widget
  Widget _buildTimeBox(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
