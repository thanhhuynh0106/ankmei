import 'package:ankmei_app/custom_object/task.dart';
import 'package:flutter/material.dart';

class CreateTaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  static String _friendlyDue(DateTime dt) {
    final now = DateTime.now();
    final d = DateTime(dt.year, dt.month, dt.day);
    final t = DateTime(now.year, now.month, now.day);
    final diff = d.difference(t).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    if (diff == -1) return 'Yesterday';
    if (diff > 1 && diff <= 7) return '${diff}d';
    if (diff < -1 && diff >= -7) return '${diff.abs()}d ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }



  const CreateTaskCard({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= Category + Priority !!!!!!!!!!!!!!!!!!!!!!!!!
              Row(
                children: [
                    _Chip(label: task.category, fg: Colors.green, bg: Colors.orangeAccent, dot: false, icon: Icons.category),
                    SizedBox(width: 10),
                    _Chip(label: task.priority.label, fg: task.priority.colorPriority, bg: task.priority.colorBackground, dot: true),
                ],
              ),
              SizedBox(height: 10),
              // ================= Title !!!!!!!!!!!!!!!!!!!!!!!!!
              Text(
                task.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6),
              // ================= Description !!!!!!!!!!!!!!!!!!!!!!!!!
              Text(
                task.description,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12),
              Divider(height: 1, color: Colors.grey.withValues(alpha: 0.3)),
              SizedBox(height: 12),
              // ================= Assignees + Due Date + Progress !!!!!!!!!!!!!!!!!!!!!!!!!
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Assignees(assignees: task.assignees),
                  Spacer(),
                  if (task.dueDate != null) ...[
                    const Icon(Icons.schedule, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(_friendlyDue(task.dueDate!)),
                    const SizedBox(width: 12),
                  ],
                  // const Icon(Icons.attachment, size: 16, color: Colors.grey),
                  // const SizedBox(width: 4),
                  // Text('${task.attachments}', style: textSub),
                  // const SizedBox(width: 12),
                  // const Icon(Icons.mode_comment_outlined, size: 16, color: Colors.grey),
                  // const SizedBox(width: 4),
                  // Text('${task.comments}', style: textSub),
                ],
              )
            ],
          )
        )
      )
    );
  }
}






class _Chip extends StatelessWidget {
  final String label;
  final Color fg;
  final Color bg;
  final bool dot;
  final IconData? icon;

  const _Chip({
    required this.label, required this.fg, required this.bg, required this.dot, this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 4),
          ],
          if (dot) ...[
            Container(width: 8, height: 8, decoration: BoxDecoration(color: fg, shape: BoxShape.circle)),
            const SizedBox(width: 6),
          ],
          Text(label, style: TextStyle(fontSize: 12, color: fg, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}


class _Assignees extends StatelessWidget {
  final List<String> assignees;
  const _Assignees({required this.assignees});

  @override
  Widget build(BuildContext context) {
    if (assignees.isEmpty) return const SizedBox.shrink();

    final avatars = assignees.take(4).toList();
    final extra = assignees.length - avatars.length;

    return SizedBox(
      height: 28,
      width: (avatars.length * 20).toDouble() + (extra > 0 ? 22 : 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < avatars.length; i++)
            Positioned(
              left: i * 20.0,
              child: _AvatarChip(value: avatars[i]),
            ),
          if (extra > 0)
            Positioned(
              left: avatars.length * 20.0,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey.shade300,
                child: Text(
                  '+$extra',
                  style: const TextStyle(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AvatarChip extends StatelessWidget {
  final String value;
  const _AvatarChip({required this.value});

  bool get _isUrl => value.startsWith('http://') || value.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: _isUrl ? NetworkImage(value) : null,
      child: !_isUrl
          ? Text(
              value.length >= 2 ? value.substring(0, 2).toUpperCase() : value.toUpperCase(),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black87),
            )
          : null,
    );
  }
}