import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/user_profile_input.dart';
import 'package:mingl_app/features/onboarding/models/sex.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/large_selection_button.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_spacing.dart';

class SexInputScreen extends StatefulWidget {
  final OnboardingInput profileInput;

  const SexInputScreen({super.key, required this.profileInput});

  @override
  State<SexInputScreen> createState() => _SexInputScreenState();
}

class _SexInputScreenState extends State<SexInputScreen> {
  void _onSelectSex(Sex sex) {
    widget.profileInput.sex = sex;
    // next screen
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