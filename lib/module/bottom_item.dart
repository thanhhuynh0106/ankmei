import 'package:flutter/material.dart';

class BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const BottomItem({super.key, 
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selColor = Theme.of(context).colorScheme.primary;
    final unSelColor = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: selColor.withValues(alpha: 0.12),
        highlightColor: selColor.withValues(alpha: 0.06),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  icon,
                  key: ValueKey(selected),
                  size: selected ? 26 : 24,
                  color: selected ? selColor : unSelColor,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected ? selColor : unSelColor,
                ),
                child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: selected ? 1 : 0,
                child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 16,
                  height: 2,
                  decoration: BoxDecoration(
                    color: selColor,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
