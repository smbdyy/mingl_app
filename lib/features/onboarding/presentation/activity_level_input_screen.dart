import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/onboarding_input.dart';
import 'package:mingl_app/features/onboarding/models/activity_level.dart';
import 'package:mingl_app/features/onboarding/presentation/weight_input_screen.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/activity_level_card.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/next_button.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_spacing.dart';

class ActivityLevelInputScreen extends StatefulWidget {
  final OnboardingInput onboardingInput;

  const ActivityLevelInputScreen({super.key, required this.onboardingInput});

  @override
  State<ActivityLevelInputScreen> createState() => _ActivityLevelInputScreenState();
}

class _ActivityLevelInputScreenState extends State<ActivityLevelInputScreen> {
  late ActivityLevel? _selectedLevel;

  @override
  void initState() {
    super.initState();
    _selectedLevel = widget.onboardingInput.activityLevel;
  }

  void _onNext() {
    if (_selectedLevel == null) {
      throw UnimplementedError();
    }

    widget.onboardingInput.activityLevel = _selectedLevel;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WeightInputScreen(onboardingInput: widget.onboardingInput),
      ),
    );
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
