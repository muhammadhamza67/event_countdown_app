import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/event.dart';

class EventStorage {
  static List<Event> _cachedEvents = [];

  // ✅ Load events from JSON file
  static Future<List<Event>> loadEvents() async {
    if (_cachedEvents.isNotEmpty) return _cachedEvents;

    try {
      // Read the JSON file as a string
      final String response = await rootBundle.loadString('assets/events.json');

      // Decode JSON into a map
      final Map<String, dynamic> jsonData = jsonDecode(response);

      // Extract the list of events safely
      if (jsonData.containsKey('events') && jsonData['events'] is List) {
        final List<dynamic> data = jsonData['events'];
        _cachedEvents = data.map((e) => Event.fromJson(e)).toList();
      } else {
        print("⚠️ No 'events' key found or it’s not a list.");
        _cachedEvents = [];
      }

      return _cachedEvents;
    } catch (e) {
      print("❌ Error loading events: $e");
      return [];
    }
  }

  // ✅ Cache or save events (for now, only in memory for web)
  static Future<void> saveEvents(List<Event> events) async {
    _cachedEvents = events;
    print("✅ (Web Mode) Events cached temporarily — not saved permanently.");
  }
}
