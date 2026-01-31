import 'package:mingl_app/features/onboarding/models/activity_level.dart';
import 'package:mingl_app/features/onboarding/models/sex.dart';

class NutritionProfileInput {
  final int? age;
  final double? weightKg;
  final double? targetWeightKg;
  final int? heightCm;
  final Sex? sex;
  final ActivityLevel? activityLevel;
  final String? foodExceptions;
  final String? foodPreferences;

  NutritionProfileInput({
    required this.age,
    required this.weightKg,
    required this.targetWeightKg,
    required this.heightCm,
    required this.sex,
    required this.activityLevel,
    required this.foodExceptions,
    required this.foodPreferences});
}