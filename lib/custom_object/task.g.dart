// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subtask _$SubtaskFromJson(Map<String, dynamic> json) => Subtask(
  id: json['id'] as String?,
  title: json['title'] as String,
  isCompleted: json['isCompleted'] as bool? ?? false,
  assignees:
      (json['assignees'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  orderIndex: (json['orderIndex'] as num?)?.toInt() ?? 0,
  progress: (json['progress'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SubtaskToJson(Subtask instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'isCompleted': instance.isCompleted,
  'assignees': instance.assignees,
  'orderIndex': instance.orderIndex,
  'dueDate': instance.dueDate?.toIso8601String(),
  'progress': instance.progress,
};

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  priority: $enumDecode(_$TaskPriorityEnumMap, json['priority']),
  status:
      $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
      TaskStatus.todo,
  createdBy: json['createdBy'] as String,
  assignees:
      (json['assignees'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  progress: (json['progress'] as num?)?.toInt() ?? 0,
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  subtasks:
      (json['subtasks'] as List<dynamic>?)
          ?.map((e) => Subtask.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'category': instance.category,
  'priority': _$TaskPriorityEnumMap[instance.priority]!,
  'assignees': instance.assignees,
  'progress': instance.progress,
  'status': _$TaskStatusEnumMap[instance.status]!,
  'dueDate': instance.dueDate?.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'createdBy': instance.createdBy,
  'subtasks': instance.subtasks,
};

const _$TaskPriorityEnumMap = {
  TaskPriority.low: 'low',
  TaskPriority.medium: 'medium',
  TaskPriority.high: 'high',
  TaskPriority.urgent: 'urgent',
};

const _$TaskStatusEnumMap = {
  TaskStatus.todo: 'todo',
  TaskStatus.inProgress: 'inProgress',
  TaskStatus.completed: 'completed',
  TaskStatus.cancelled: 'cancelled',
};
