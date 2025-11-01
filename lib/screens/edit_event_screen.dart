import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime(2025, 11, 5, 10, 0);
  TimeOfDay selectedTime = const TimeOfDay(hour: 10, minute: 0);
  String? selectedCategory = "Work";

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
          'Edit Event',
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
            // 📝 Scrollable form
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    _buildLabel("Event Title"),
                    TextField(
                      controller: titleController,
                      decoration: _inputDecoration('Exams Deadline'),
                    ),
                    const SizedBox(height: 20),

                    _buildLabel("Description"),
                    TextField(
                      controller: descriptionController,
                      decoration: _inputDecoration('Math Final Exam'),
                    ),
                    const SizedBox(height: 20),

                    _buildLabel("Date & Time"),
                    GestureDetector(
                      onTap: _pickDateTime,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${DateFormat('MMM d, yyyy').format(selectedDate)}   ${selectedTime.format(context)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Icon(Icons.calendar_today,
                                color: Color(0xFFA961C3)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildLabel("Category (Optional)"),
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
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: Colors.black),
                          items: categories.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child:
                                  Text(value, style: const TextStyle(fontSize: 16)),
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
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // 🟣 Action Buttons (fixed bottom, same as Add Event)
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    text: 'Delete Event',
                    color: const Color(0xFFA961C3).withOpacity(0.3),
                    textColor: Colors.white,
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildButton(
                    text: 'Save Changes',
                    color: const Color(0xFFA961C3),
                    textColor: Colors.white,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🌸 Label
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // 🌸 Input Decoration
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Color(0xFFA961C3)),
      ),
    );
  }

  // 💜 Buttons (same size & spacing as AddEvent)
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

  // 🕓 DateTime Picker
  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (time == null) return;

    setState(() {
      selectedDate = date;
      selectedTime = time;
    });
  }
}
