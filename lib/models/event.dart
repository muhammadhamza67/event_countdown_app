class Event {
  String id;
  String title;
  String description;
  String dateTime; // ISO date string like "2025-10-20T17:00:00Z"
  String category;
  bool completed;
  String notes;
  String color;

  // 👇 New computed fields for dashboard countdown
  String days = "0";
  String hours = "0";
  String minutes = "0";
  double progressValue = 0.0;
  DateTime? createdAt;

  // 👇 New field for voice recording
  String voicePath;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.category,
    required this.completed,
    required this.notes,
    this.color = "purple",
    this.days = "0",
    this.hours = "0",
    this.minutes = "0",
    this.progressValue = 0.0,
    this.createdAt,
    this.voicePath = '', // default empty
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dateTime: json['datetime'] ?? '',
      category: json['category'] ?? '',
      completed: json['completed'] ?? false,
      notes: json['notes'] ?? '',
      color: json['color'] ?? 'purple',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      voicePath: json['voicePath'] ?? '', // read from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'datetime': dateTime,
      'category': category,
      'completed': completed,
      'notes': notes,
      'color': color,
      'createdAt': createdAt?.toIso8601String(),
      'voicePath': voicePath, // include in JSON
    };
  }
}
