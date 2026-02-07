import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/onboarding_input.dart';
import 'package:mingl_app/features/onboarding/models/sex.dart';
import 'package:mingl_app/features/onboarding/presentation/height_input_screen.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/large_selection_button.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_spacing.dart';

class SexInputScreen extends StatefulWidget {
  final OnboardingInput onboardingInput;

  const SexInputScreen({super.key, required this.onboardingInput});

  @override
  State<SexInputScreen> createState() => _SexInputScreenState();
}

class _SexInputScreenState extends State<SexInputScreen> {
  void _onSelectSex(Sex sex) {
    widget.onboardingInput.sex = sex;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HeightInputScreen(onboardingInput: widget.onboardingInput),
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
            onPressed: () => _onSelectSex(Sex.male),
            label: 'Мужской',
          ),
          const OnboardingSpacing.small(),
          LargeSelectionButton(
            onPressed: () => _onSelectSex(Sex.female),
            label: 'Женский',
          ),
        ],
      ),
    );
  }
}