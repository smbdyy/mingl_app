import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/onboarding_input.dart';
import 'package:mingl_app/features/onboarding/models/sex.dart';
import 'package:mingl_app/features/onboarding/presentation/height_input_screen.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/large_selection_button.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_spacing.dart';

class SexInputScreen extends StatelessWidget {
  final OnboardingInput onboardingInput;

  const SexInputScreen({super.key, required this.onboardingInput});

  void _onSelectSex(BuildContext context, Sex sex) {
    onboardingInput.sex = sex;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HeightInputScreen(onboardingInput: onboardingInput),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      title: 'Пол',
      body: Column(
        children: [
          LargeSelectionButton(
            onPressed: () => _onSelectSex(context, Sex.male),
            label: 'Мужской',
          ),
          const OnboardingSpacing.small(),
          LargeSelectionButton(
            onPressed: () => _onSelectSex(context, Sex.female),
            label: 'Женский',
          ),
        ],
      ),
    );
  }
}


