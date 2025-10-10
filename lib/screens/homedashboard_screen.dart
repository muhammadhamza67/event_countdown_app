import 'package:flutter/material.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Hello, Hamza",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),

      // 🧭 Drawer menu (optional)
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Event Countdown',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Event'),
              onTap: () => Navigator.pushNamed(context, '/addEvent'),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Past Events'),
              onTap: () => Navigator.pushNamed(context, '/past'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
      ),

      // 🧱 Body content
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // 📅 Event Cards
            _buildEventCard(
              title: "Exam Deadline",
              date: "Tomorrow, August 13, 5:00 PM",
              days: "02",
              hours: "03",
              minutes: "25",
              color: Colors.green,
            ),
            const SizedBox(height: 25),
            _buildEventCard(
              title: "Team Meeting",
              date: "Monday, August 15, 5:00 PM",
              days: "05",
              hours: "07",
              minutes: "40",
              color: Colors.orange,
            ),
            const SizedBox(height: 25),
            _buildEventCard(
              title: "Project Presentation",
              date: "Friday, August 25, 2:00 PM",
              days: "15",
              hours: "17",
              minutes: "30",
              color: Colors.red,
            ),

            const Spacer(),

            // ➕ Add Event Button
            Center(
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, '/addEvent');
                },
                child: const Icon(Icons.add, size: 30, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget for event card
  Widget _buildEventCard({
    required String title,
    required String date,
    required String days,
    required String hours,
    required String minutes,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            _buildTimeBox(days, "Days"),
            const SizedBox(width: 10),
            _buildTimeBox(hours, "Hours"),
            const SizedBox(width: 10),
            _buildTimeBox(minutes, "Minutes"),
          ],
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: 0.7,
          color: color,
          backgroundColor: Colors.grey[300],
          minHeight: 5,
        ),
      ],
    );
  }

  // 🔹 Countdown Time Box
  Widget _buildTimeBox(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }
}
