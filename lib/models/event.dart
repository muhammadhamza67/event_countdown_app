import 'dart:convert';

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  String days;            // Mutable for countdown
  String hours;           // Mutable for countdown
  String minutes;         // Mutable for countdown
  double progressValue;   // Mutable for progress bar
  final DateTime createdAt;
  final String color;
  final bool completed;
  final String notes;
  final String category;
  final String? voicePath;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    this.days = '0',
    this.hours = '0',
    this.minutes = '0',
    this.progressValue = 0.0,
    required this.createdAt,
    this.color = 'purple',
    this.completed = false,
    this.notes = '',
    this.category = 'Other',
    this.voicePath,
  });

  // Convert from JSON (from backend)
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dateTime: DateTime.parse(json['dateTime']),
      days: json['days'] ?? '0',
      hours: json['hours'] ?? '0',
      minutes: json['minutes'] ?? '0',
      progressValue: (json['progressValue'] ?? 0.0).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      color: json['color'] ?? 'purple',
      completed: json['completed'] ?? false,
      notes: json['notes'] ?? '',
      category: json['category'] ?? 'Other',
      voicePath: json['voicePath'],
    );
  }

  // Convert to JSON (for backend)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'progressValue': progressValue,
      'createdAt': createdAt.toIso8601String(),
      'color': color,
      'completed': completed,
      'notes': notes,
      'category': category,
      'voicePath': voicePath,
    };
  }

  // Optional: copyWith for immutability (if needed later)
  Event copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dateTime,
    String? days,
    String? hours,
    String? minutes,
    double? progressValue,
    DateTime? createdAt,
    String? color,
    bool? completed,
    String? notes,
    String? category,
    String? voicePath,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      days: days ?? this.days,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      progressValue: progressValue ?? this.progressValue,
      createdAt: createdAt ?? this.createdAt,
      color: color ?? this.color,
      completed: completed ?? this.completed,
      notes: notes ?? this.notes,
      category: category ?? this.category,
      voicePath: voicePath ?? this.voicePath,
    );
  }
}
