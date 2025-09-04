import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String category;
  final TaskPriority priority;
  final List<String> assignees;
  final int progress;
  final DateTime? dueDate;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    this.assignees = const [],
    this.progress = 0,
    this.dueDate,
  });
}

enum TaskPriority { low, medium, high, urgent }

extension TaskPriorityExtension on TaskPriority {
  String get label {
    switch (this) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
      case TaskPriority.urgent:
        return 'Urgent';
    }
  }

  Color get colorPriority {
    switch (this) {
      case TaskPriority.low:
        return const Color.fromARGB(255, 113, 227, 117);
      case TaskPriority.medium:
        return const Color.fromARGB(255, 107, 179, 237);
      case TaskPriority.high:
        return const Color.fromARGB(255, 244, 172, 65);
      case TaskPriority.urgent:
        return const Color.fromARGB(255, 222, 52, 40);
    }
  }

  Color get colorBackground {
    switch (this) {
      case TaskPriority.low:
        return const Color(0xFFEFFAF3);
      case TaskPriority.medium:
        return const Color(0xFFFFF6E5);
      case TaskPriority.high:
        return const Color(0xFFFFEFEF);
      case TaskPriority.urgent:
        return const Color(0xFFFFE9EC);
    }
  }
}
