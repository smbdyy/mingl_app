import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/onboarding_input.dart';
import 'package:mingl_app/features/onboarding/presentation/target_weight_input_screen.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/numeric_input_field.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/next_button.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_spacing.dart';

class WeightInputScreen extends StatefulWidget {
  final OnboardingInput onboardingInput;

  const WeightInputScreen({super.key, required this.onboardingInput});

  @override
  State<WeightInputScreen> createState() => _WeightInputScreenState();
}

class _WeightInputScreenState extends State<WeightInputScreen> {
  final _controller = TextEditingController();

  void _onNext() {
    final value = double.tryParse(_controller.text);

    if (value == null) {
      throw UnimplementedError();
    }

    widget.onboardingInput.weightKg = value;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TargetWeightInputScreen(onboardingInput: widget.onboardingInput),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      title: 'Вес',
      body: Column(
        children: [
          NumericInputField(
            controller: _controller,
            labelText: 'Вес (кг)',
          ),
          const OnboardingSpacing(),
          NextButton(onPressed: _onNext),
        ],
      ),
    );
  }
}
