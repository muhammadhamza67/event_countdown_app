import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../models/event.dart';

class EventStorage {
  // Base URL depending on platform
  static String get baseUrl {
    if (kIsWeb) return "http://192.168.100.77:8000"; // your local IP
    if (Platform.isAndroid) return "http://10.0.2.2:8000";
    return "http://127.0.0.1:8000";
  }

  // ----------------------------
  // LOAD EVENTS FROM BACKEND
  // ----------------------------
  static Future<List<Event>> loadEvents() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/events"));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => Event.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load events: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching events: $e");
      return await loadLocalEvents();
    }
  }

  // ----------------------------
  // ADD EVENT (Static now)
  // ----------------------------
  static Future<void> addEvent(Event event) async {
    final uri = Uri.parse("$baseUrl/events");

    var request = http.MultipartRequest('POST', uri)
      ..fields['title'] = event.title
      ..fields['description'] = event.description
      ..fields['dateTime'] = event.dateTime.toIso8601String()
      ..fields['days'] = event.days
      ..fields['hours'] = event.hours
      ..fields['minutes'] = event.minutes
      ..fields['color'] = event.color
      ..fields['progressValue'] = event.progressValue.toString()
      ..fields['completed'] = event.completed.toString()
      ..fields['notes'] = event.notes
      ..fields['category'] = event.category
      ..fields['createdAt'] = event.createdAt.toIso8601String();

    // Add voice file if exists
    if (event.voicePath != null && event.voicePath!.isNotEmpty && !kIsWeb) {
      var file = await http.MultipartFile.fromPath('voice', event.voicePath!);
      request.files.add(file);
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Failed to add event: ${response.body}");
      } else {
        debugPrint("Event added successfully: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error adding event: $e");

      // Save locally if server fails
      var events = await loadLocalEvents();
      events.add(event);
      await saveEvents(events);
    }
  }

  // ----------------------------
  // DELETE EVENT
  // ----------------------------
  static Future<void> deleteEvent(String id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/events/$id"));
      if (response.statusCode != 200) {
        throw Exception("Failed to delete event: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error deleting event: $e");
    }
  }

  // ----------------------------
  // LOCAL STORAGE (JSON)
  // ----------------------------
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/events.json');
  }

  static Future<List<Event>> loadLocalEvents() async {
    try {
      final file = await _localFile;
      if (!(await file.exists())) await file.writeAsString('[]');
      final contents = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(contents);
      return jsonData.map((e) => Event.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveEvents(List<Event> events) async {
    final file = await _localFile;
    final jsonData = events.map((e) => e.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonData));
  }
}
