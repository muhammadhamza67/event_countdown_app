import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedCategory;

  final List<String> categories = ['Work', 'Study', 'Personal', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFA961C3)),
        title: const Text(
          'Add New Event',
          style: TextStyle(
            color: Color(0xFFA961C3),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📝 Event Title
            const Text(
              'Event Title',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: titleController,
              decoration: _inputDecoration('Exams Deadline'),
            ),
            const SizedBox(height: 20),

            // 📝 Description
            const Text(
              'Description',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: descriptionController,
              decoration: _inputDecoration('Math Final Exam'),
            ),
            const SizedBox(height: 20),

            // 🗓️ Date & Time
            const Text(
              'Date & Time',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2030),
                );
                if (date == null) return;

                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time == null) return;

                setState(() {
                  selectedDate = date;
                  selectedTime = time;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? 'Nov 5, 2025    10:00 AM'
                          : '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}   ${selectedTime?.format(context) ?? ''}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today, color: Color(0xFFA961C3)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🏷️ Category
            const Text(
              'Category (Optional)',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  hint: const Text('Work'),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                  items: categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 16)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel
                _buildButton(
                  text: 'Cancel',
                  color: const Color(0xFFA961C3).withOpacity(0.3),
                  textColor: Colors.white,
                  onTap: () => Navigator.pop(context),
                ),
                // Save Event
                _buildButton(
                  text: 'Save Event',
                  color: const Color(0xFFA961C3),
                  textColor: Colors.white,
                  onTap: () {
                    // TODO: Add save logic
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // 🌸 Reusable Input Decoration
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFA961C3)),
      ),
    );
  }

  // 💜 Reusable Button
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
        minimumSize: const Size(140, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
