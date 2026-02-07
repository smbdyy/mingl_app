
import 'package:mingl_app/features/onboarding/models/activity_level.dart';

class ActivityLevelData {
  final ActivityLevel level;
  final String title;
  final String description;

  ActivityLevelData({
    required this.level,
    required this.title,
    required this.description,
  });
}

final activityLevelDescriptions = {
  ActivityLevel.resting: ActivityLevelData(
    level: ActivityLevel.resting,
    title: 'Сидячий образ жизни',
    description: 'Почти весь день сидишь, прогулки <30 минут, никакой физической нагрузки.',
  ),
  ActivityLevel.light: ActivityLevelData(
    level: ActivityLevel.light,
    title: 'Низкая активность',
    description: 'Прогулки 30–60 минут в день или 1–3 тренировки в неделю.',
  ),
  ActivityLevel.moderate: ActivityLevelData(
    level: ActivityLevel.moderate,
    title: 'Средняя активность',
    description: 'Прогулки 60–90 минут в день или 3–5 тренировок в неделю.',
  ),
  ActivityLevel.high: ActivityLevelData(
    level: ActivityLevel.high,
    title: 'Выше среднего',
    description: 'Более 90 минут активного движения каждый день или ежедневные тренировки средней интенсивности.',
  ),
  ActivityLevel.veryHigh: ActivityLevelData(
    level: ActivityLevel.veryHigh,
    title: 'Высокая активность',
    description: 'Ежедневные интенсивные тренировки и/или физическая работа с высокими нагрузками.',
  ),
};
