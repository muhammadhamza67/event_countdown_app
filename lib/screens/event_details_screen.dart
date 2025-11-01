import 'package:flutter/material.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6FA), // ✅ Consistent background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFA961C3)),
        title: const Text(
          'Event Details',
          style: TextStyle(
            color: Color(0xFFA961C3),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    const Text(
                      "Graduation Ceremony",
                      style: TextStyle(
                        color: Color(0xFFA961C3),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),

                    const Text(
                      "August 13, 5:00 PM",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),

                    const Text(
                      "Event Completed",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      "Notes",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),

                    TextField(
                      controller: _notesController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Write what made the event special...",
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Color(0xFFA961C3)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // 🟣 Action Buttons (Fixed bottom)
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    text: 'Cancel',
                    color: const Color(0xFFA961C3).withOpacity(0.3),
                    textColor: Colors.white,
                    onTap: () {
                      _notesController.clear();
                      Navigator.pop(context);
                    },
                  ),
                  _buildButton(
                    text: 'Save Note',
                    color: const Color(0xFFA961C3),
                    textColor: Colors.white,
                    onTap: () {
                      // TODO: Save logic
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 💜 Reusable Button (same as Add/Edit screens)
  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
      ),
    );
  }
} 