import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:event_countdown_app/screens/homedashboard_screen.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:path_provider/path_provider.dart';
import '../services/event_storage.dart';
import '../models/event.dart';

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

  late stt.SpeechToText _speech;
  bool _isListening = false;

  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  String? _voicePath;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _recorder = FlutterSoundRecorder();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    await _recorder!.openRecorder();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    _recorder!.closeRecorder();
    super.dispose();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              titleController.text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _recordVoice() async {
    if (_isRecording) {
      await _recorder!.stopRecorder();
      setState(() => _isRecording = false);
    } else {
      final dir = await getApplicationDocumentsDirectory();
      _voicePath =
          '${dir.path}/event_${DateTime.now().millisecondsSinceEpoch}.aac';
      await _recorder!.startRecorder(toFile: _voicePath);
      setState(() => _isRecording = true);
    }
  }

  Future<void> _saveEvent() async {
    if (titleController.text.isEmpty || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final combinedDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime?.hour ?? 0,
      selectedTime?.minute ?? 0,
    );

    final event = Event(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      description: descriptionController.text,
      dateTime: combinedDateTime,
      days: '0',
      hours: '0',
      minutes: '0',
      color: 'purple',
      progressValue: 0.0,
      completed: false,
      notes: '',
      category: selectedCategory ?? 'Other',
      voicePath: _voicePath,
      createdAt: DateTime.now(),
    );

    try {
      await EventStorage.addEvent(event);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event saved successfully!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeDashboardScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving event: $e')),
      );
    }
  }

  Widget _buildLabel(String text) => Padding(
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

  InputDecoration _inputDecoration(String hint) => InputDecoration(
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

  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) =>
      ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 16),
        ),
      );

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildLabel("Event Title"),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Exams Deadline',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFA961C3)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isListening ? Icons.mic : Icons.mic_none,
                            color: const Color(0xFFA961C3),
                          ),
                          onPressed: _listen,
                        ),
                      ),
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
                                  ? 'Select Date & Time'
                                  : '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year} ${selectedTime?.format(context) ?? ''}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Icon(Icons.calendar_today, color: Color(0xFFA961C3)),
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
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _recordVoice,
                        icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                        label: Text(_isRecording ? 'Stop Recording' : 'Record Voice'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA961C3),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    text: 'Cancel',
                    color: const Color(0xFFA961C3).withOpacity(0.3),
                    textColor: Colors.white,
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildButton(
                    text: 'Save Event',
                    color: const Color(0xFFA961C3),
                    textColor: Colors.white,
                    onTap: _saveEvent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
