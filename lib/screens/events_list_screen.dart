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
          return Colors.purple;
        default:
          return Colors.black;
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Events",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  itemCount: events.length,
                  separatorBuilder: (_, __) => const Divider(height: 25),
                  itemBuilder: (context, index) {
                    final e = events[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e["title"]!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              e["date"]!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          e["status"]!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
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
