// lib/models/task.dart

class Task {
  final int id;
  final String title;
  final String description;
  final String status;
  final DateTime createdAt;
  final String priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.priority,
  });

  // Additional constructors or methods if needed
}
