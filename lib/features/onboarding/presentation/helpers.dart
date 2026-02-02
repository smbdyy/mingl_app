import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/user_profile_input.dart';
import 'package:mingl_app/features/onboarding/presentation/age_input_screen.dart';

Widget getOnboardingStartScreen() {
  return AgeInputScreen(profileInput: UserProfileInput());
}