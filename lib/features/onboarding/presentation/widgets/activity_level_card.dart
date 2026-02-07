
import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/activity_level.dart';
import 'package:mingl_app/features/onboarding/presentation/helpers/activity_level_helper.dart';

class ActivityLevelCard extends StatelessWidget {
  final ActivityLevel level;
  final bool isSelected;
  final VoidCallback onTap;

  const ActivityLevelCard({
    super.key,
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final data = activityLevelDescriptions[level]!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    data.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: Colors.blue),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              data.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
