import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/user_profile_input.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/large_text_input_field.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/next_button.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_spacing.dart';

class FoodPreferencesInputScreen extends StatefulWidget {
  final UserProfileInput profileInput;

  const FoodPreferencesInputScreen({super.key, required this.profileInput});

  @override
  State<FoodPreferencesInputScreen> createState() => _FoodPreferencesInputScreenState();
}

class _FoodPreferencesInputScreenState extends State<FoodPreferencesInputScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.profileInput.foodPreferences ?? '',
    );
  }

  void _onNext() {
    widget.profileInput.foodPreferences = _controller.text.isEmpty
      ? null
      : _controller.text;

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
      title: 'Пожелания к блюдам',
      body: SingleChildScrollView(
        child: Column(
          children: [
            LargeTextInputField(
              controller: _controller,
              labelText: 'Какие есть пожелания?',
              hintText: 'Например: больше овощей, вегетарианские блюда, острая еда...',
            ),
            const OnboardingSpacing(),
            NextButton(onPressed: _onNext),
          ],
        ),
      ),
    );
  }
}
