import 'package:flutter/material.dart';

class EventsListScreen extends StatelessWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {"title": "Exam Deadline", "date": "Aug 9, 2025", "status": "Expired"},
      {"title": "Team Meeting", "date": "Aug 11, 2025", "status": "Completed"},
      {"title": "Project Presentation", "date": "Aug 15, 2025", "status": "Upcoming"},
    ];

    Color getStatusColor(String status) {
      switch (status) {
        case "Completed":
          return Colors.green;
        case "Expired":
          return Colors.grey;
        case "Upcoming":
          return const Color(0xFFA961C3);
        default:
          return Colors.black;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6FA),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Events',
          style: TextStyle(
            color: Color(0xFFA961C3),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            children: [
              // 🔍 Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search events...',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFA961C3)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // 📅 Events List
              Expanded(
                child: ListView.separated(
                  itemCount: events.length,
                  separatorBuilder: (_, __) => const Divider(height: 25, color: Colors.black12),
                  itemBuilder: (context, index) {
                    final e = events[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e["title"]!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              e["date"]!,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),

                        // Status
                        Text(
                          e["status"]!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: getStatusColor(e["status"]!),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
