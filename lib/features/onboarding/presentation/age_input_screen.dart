import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/onboarding_input.dart';
import 'package:mingl_app/features/onboarding/presentation/sex_input_screen.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/numeric_input_field.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/next_button.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_spacing.dart';

class AgeInputScreen extends StatefulWidget {
  final OnboardingInput onboardingInput;

  const AgeInputScreen({super.key, required this.onboardingInput});

  @override
  State<AgeInputScreen> createState() => _AgeInputScreenState();
}

class _AgeInputScreenState extends State<AgeInputScreen> {
  final _controller = TextEditingController();

  void _onNext() {
    final value = int.tryParse(_controller.text);

    if (value == null) {
      throw UnimplementedError();
    }

    widget.onboardingInput.age = value;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SexInputScreen(onboardingInput: widget.onboardingInput),
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
      title: 'Возраст',
      body: Column(
        children: [
          NumericInputField(
            controller: _controller,
            labelText: 'Возраст',
          ),
          const OnboardingSpacing(),
          NextButton(onPressed: _onNext),
        ],
      ),
    );
  }
}