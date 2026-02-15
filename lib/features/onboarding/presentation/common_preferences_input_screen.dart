import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/onboarding_input.dart';
import 'package:mingl_app/features/onboarding/presentation/onboarding_submit_screen.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/large_text_input_field.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/next_button.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_spacing.dart';

class CommonPreferencesInputScreen extends StatefulWidget {
  final OnboardingInput onboardingInput;

  const CommonPreferencesInputScreen({super.key, required this.onboardingInput});

  @override
  State<CommonPreferencesInputScreen> createState() => _CommonPreferencesInputScreenState();
}

class _CommonPreferencesInputScreenState extends State<CommonPreferencesInputScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.onboardingInput.commonPreferences ?? '',
    );
  }

  void _onNext() {
    widget.onboardingInput.commonPreferences = _controller.text.isEmpty
      ? null
      : _controller.text;

    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OnboardingSubmitScreen(onboardingInput: widget.onboardingInput),
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
      title: 'Пожелания',
      body: SingleChildScrollView(
        child: Column(
          children: [
            LargeTextInputField(
              controller: _controller,
              labelText: 'Какие есть пожелания?',
              hintText: 'Например: больше овощей, острая еда, можно приготовить без духовки...',
            ),
            const OnboardingSpacing(),
            NextButton(onPressed: _onNext),
          ],
        ),
      ),
    );
  }
}
