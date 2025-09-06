import 'package:ankmei_app/custom_object/task.dart';
import 'package:flutter/material.dart';

class SubtaskWidget extends StatelessWidget {
  final Subtask subtask;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onToggle;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const SubtaskWidget({
    super.key,
    required this.subtask,
    this.onTap,
    this.onToggle,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ListTile(
        leading: Checkbox(
          value: subtask.isCompleted,
          onChanged: (value) => onToggle?.call(value ?? false),
        ),
        title: Text(
          subtask.title,
          style: TextStyle(
            decoration: subtask.isCompleted ? TextDecoration.lineThrough : null,
            color: subtask.isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: subtask.dueDate != null
            ? Text(
                'Due: ${_formatDate(subtask.dueDate!)}',
                style: TextStyle(
                  fontSize: 12,
                  color: _isOverdue(subtask.dueDate!) ? Colors.red : Colors.grey,
                ),
              )
            : null,
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: const Text('Edit'),
            ),
            PopupMenuItem(
              value: 'delete',
              child: const Text('Delete'),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit?.call();
                break;
              case 'delete':
                onDelete?.call();
                break;
            }
          },
        ),
        onTap: onTap,
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference == -1) return 'Yesterday';
    if (difference > 0) return '${difference}d left';
    if (difference < 0) return '${difference.abs()}d ago';
    
    return '${date.day}/${date.month}/${date.year}';
  }

  bool _isOverdue(DateTime dueDate) {
    return dueDate.isBefore(DateTime.now()) && !subtask.isCompleted;
  }
}