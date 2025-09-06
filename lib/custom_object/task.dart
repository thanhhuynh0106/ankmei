import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Subtask {
  final String? id;
  final String title;
  final bool isCompleted;
  final List<String> assignees;
  final int orderIndex;
  final DateTime? dueDate;
  final int progress;

  Subtask({
    this.id,
    required this.title,
    this.isCompleted = false,
    this.assignees = const [],
    this.dueDate,
    this.orderIndex = 0,
    this.progress = 0,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) =>
      _$SubtaskFromJson(json);
  Map<String, dynamic> toJson() => _$SubtaskToJson(this);

  Subtask copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    List<String>? assignees,
    int? orderIndex,
    DateTime? dueDate,
  }) {
    return Subtask(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      assignees: assignees ?? this.assignees,
      orderIndex: orderIndex ?? this.orderIndex,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}

@JsonSerializable()
class Task {
  final String id;
  final String title;
  final String description;
  final String category;
  final TaskPriority priority;
  final List<String> assignees;
  final int progress;

  final TaskStatus status;
  final DateTime? dueDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String createdBy;
  final List<Subtask> subtasks;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    this.status = TaskStatus.todo,
    required this.createdBy,
    this.assignees = const [],
    this.progress = 0,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
    this.subtasks = const [],
  });

  int get completedSubtasksCount => subtasks.where((s) => s.isCompleted).length;
  int get totalSubtasksCount => subtasks.length;
  double get subtasksProgress => totalSubtasksCount > 0
      ? completedSubtasksCount / totalSubtasksCount
      : 0.0;

  Task addSubtask(Subtask subtask) {
    final newSubtasks = List<Subtask>.from(subtasks)..add(subtask);
    return copyWith(subtasks: newSubtasks);
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    TaskPriority? priority,
    TaskStatus? status,
    String? createdBy,
    List<String>? assignees,
    int? progress,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Subtask>? subtasks,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      assignees: assignees ?? this.assignees,
      progress: progress ?? this.progress,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      subtasks: subtasks ?? this.subtasks,
    );
  }
}

enum TaskStatus { todo, inProgress, completed, cancelled }

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

extension TaskStatusExtension on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.todo:
        return 'To Do';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get colorStatus {
    switch (this) {
      case TaskStatus.todo:
        return const Color.fromARGB(255, 123, 196, 251);
      case TaskStatus.inProgress:
        return const Color.fromARGB(255, 237, 255, 97);
      case TaskStatus.completed:
        return const Color.fromARGB(255, 11, 176, 8);
      case TaskStatus.cancelled:
        return const Color.fromARGB(255, 222, 52, 40);
    }
  }
}
