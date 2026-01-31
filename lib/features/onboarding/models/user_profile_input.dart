import 'package:mingl_app/features/onboarding/models/activity_level.dart';
import 'package:mingl_app/features/onboarding/models/sex.dart';

class UserProfileInput {
  int? age;
  double? weightKg;
  double? targetWeightKg;
  int? heightCm;
  Sex? sex;
  ActivityLevel? activityLevel;
  String? foodExceptions;
  String? foodPreferences;
}