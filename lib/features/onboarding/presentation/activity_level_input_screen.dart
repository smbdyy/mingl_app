import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/user_profile_input.dart';
import 'package:mingl_app/features/onboarding/models/activity_level.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/activity_level_card.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/next_button.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_spacing.dart';

class ActivityLevelInputScreen extends StatefulWidget {
  final UserProfileInput profileInput;

  const ActivityLevelInputScreen({super.key, required this.profileInput});

  @override
  State<ActivityLevelInputScreen> createState() => _ActivityLevelInputScreenState();
}

class _ActivityLevelInputScreenState extends State<ActivityLevelInputScreen> {
  late ActivityLevel? _selectedLevel;

  @override
  void initState() {
    super.initState();
    _selectedLevel = widget.profileInput.activityLevel;
  }

  void _onNext() {
    if (_selectedLevel == null) {
      throw UnimplementedError();
    }

    widget.profileInput.activityLevel = _selectedLevel;
    // next screen
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      title: 'Уровень активности',
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...ActivityLevel.values.map(
              (level) => Column(
                children: [
                  ActivityLevelCard(
                    level: level,
                    isSelected: _selectedLevel == level,
                    onTap: () => setState(() => _selectedLevel = level),
                  ),
                  const OnboardingSpacing.small(),
                ],
              ),
            ),
            const OnboardingSpacing(),
            NextButton(onPressed: _onNext),
          ],
        ),
      ),
    );
  }
}
