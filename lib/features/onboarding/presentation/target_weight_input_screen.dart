
import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/user_profile_input.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/numeric_input_field.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/next_button.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_spacing.dart';

class TargetWeightInputScreen extends StatefulWidget {
  final UserProfileInput profileInput;

  const TargetWeightInputScreen({super.key, required this.profileInput});

  @override
  State<TargetWeightInputScreen> createState() => _TargetWeightInputScreenState();
}

class _TargetWeightInputScreenState extends State<TargetWeightInputScreen> {
  final _controller = TextEditingController();

  void _onNext() {
    final value = double.tryParse(_controller.text);

    if (value == null) {
      throw UnimplementedError();
    }

    widget.profileInput.targetWeightKg = value;
    // next screen
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      title: 'Желаемый вес',
      body: Column(
        children: [
          NumericInputField(
            controller: _controller,
            labelText: 'Желаемый вес (кг)',
          ),
          const OnboardingSpacing(),
          NextButton(onPressed: _onNext),
        ],
      ),
    );
  }
}
