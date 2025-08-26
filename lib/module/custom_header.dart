import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String displayName;
  final String username;
  final String backgroundUrl;
  final String avatarUrl;
  final List<Widget>? badges;

  const CustomHeader({
    super.key,
    required this.displayName,
    required this.username,
    required this.backgroundUrl,
    required this.avatarUrl,
    this.badges,
  });


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )
      ),
      padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // banner image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Container(
              height: 135,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundUrl),
                  fit: BoxFit.cover,
                )
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black26,
                    ]
                  )
                ),
              ),
            )
          ),
            // avatar
          Positioned(
            left: 8,
            top: 135 - 30,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
               Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black26)],
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(avatarUrl),
                    backgroundColor: Colors.grey.shade200,
                  ),
               ),
              ],
            )
          ),

          // info
          Positioned(
            left: 16 + 50 * 2 + 12,
            top: 140,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  username,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 8),
                if (badges!.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: badges!,
                  ),
              ],
            ),
          ),

        ],
      )
    );
  }
}