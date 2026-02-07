import 'package:flutter/material.dart';
import 'package:mingl_app/features/onboarding/models/user_profile_input.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/numeric_input_field.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/next_button.dart';
import 'package:mingl_app/features/onboarding/presentation/widgets/onboarding_spacing.dart';

class HeightInputScreen extends StatefulWidget {
  final UserProfileInput profileInput;

  const HeightInputScreen({super.key, required this.profileInput});

  @override
  State<HeightInputScreen> createState() => _HeightInputScreenState();
}

class _HeightInputScreenState extends State<HeightInputScreen> {
  final _controller = TextEditingController();

  void _onNext() {
    final value = int.tryParse(_controller.text);

    if (value == null) {
      throw UnimplementedError();
    }

    widget.profileInput.heightCm = value;
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
      title: 'Рост',
      body: Column(
        children: [
          NumericInputField(
            controller: _controller,
            labelText: 'Рост (см)',
          ),
          const OnboardingSpacing(),
          NextButton(onPressed: _onNext),
        ],
      ),
    );
  }
}
