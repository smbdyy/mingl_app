import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/onboarding_input.dart';
import 'package:mingl_app/features/onboarding/presentation/food_preferences_input_screen.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/large_text_input_field.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/next_button.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_spacing.dart';

class FoodExceptionsInputScreen extends StatefulWidget {
  final OnboardingInput onboardingInput;

  const FoodExceptionsInputScreen({super.key, required this.onboardingInput});

  @override
  State<FoodExceptionsInputScreen> createState() => _FoodExceptionsInputScreenState();
}

class _FoodExceptionsInputScreenState extends State<FoodExceptionsInputScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.onboardingInput.foodExceptions ?? '',
    );
  }

  void _onNext() {
    widget.onboardingInput.foodExceptions = _controller.text.isEmpty
      ? null
      : _controller.text;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FoodPreferencesInputScreen(onboardingInput: widget.onboardingInput),
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
      title: 'Исключить продукты',
      body: SingleChildScrollView(
        child: Column(
          children: [
            LargeTextInputField(
              controller: _controller,
              labelText: 'Какие продукты исключить?',
              hintText: 'Например: молоко, арахис, глютен...',
            ),
            const OnboardingSpacing(),
            NextButton(onPressed: _onNext),
          ],
        ),
      ),
    );
  }
}
