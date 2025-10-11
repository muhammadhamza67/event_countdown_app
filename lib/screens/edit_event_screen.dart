import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime selectedDate = DateTime(2025, 11, 5, 10, 0);
  String category = "Work";

  @override
  Widget build(BuildContext context) {
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
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Edit Event",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Event Title
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Event Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Date and Time
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _pickDateTime,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: "Date & Time",
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          DateFormat('MMM d, yyyy   hh:mm a').format(selectedDate),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: category,
                decoration: const InputDecoration(
                  labelText: "Category (Optional)",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: "Work", child: Text("Work")),
                  DropdownMenuItem(value: "Study", child: Text("Study")),
                  DropdownMenuItem(value: "Personal", child: Text("Personal")),
                ],
                onChanged: (value) {
                  setState(() {
                    category = value!;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade100,
                      foregroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Delete Event"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Save"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }
}
