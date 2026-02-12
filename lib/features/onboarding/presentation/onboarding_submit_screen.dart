import 'package:flutter/material.dart';
import 'package:mingl_app/features/bootstrap/loading_screen.dart';
import 'package:mingl_app/features/onboarding/models/onboarding_input.dart';
import 'package:mingl_app/features/onboarding/presentation/onboarding_finish_screen.dart';
import 'package:mingl_app/core/account/account_service.dart';
import 'package:mingl_app/di/setup_di.dart';

class OnboardingSubmitScreen extends StatefulWidget {
  final OnboardingInput onboardingInput;

  const OnboardingSubmitScreen({super.key, required this.onboardingInput});

  @override
  State<OnboardingSubmitScreen> createState() => _OnboardingSubmitScreenState();
}

class _OnboardingSubmitScreenState extends State<OnboardingSubmitScreen> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _submitNutritionProfile();
  }

  Future<void> _submitNutritionProfile() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    final accountService = getIt<AccountService>();

    try {
      final macros = await accountService.setNutritionProfile(
        age: widget.onboardingInput.age!,
        weightKg: widget.onboardingInput.weightKg!,
        targetWeightKg: widget.onboardingInput.targetWeightKg!,
        heightCm: widget.onboardingInput.heightCm!,
        sex: widget.onboardingInput.sex!.serverValue,
        activityLevel: widget.onboardingInput.activityLevel!.serverValue,
        foodExceptions: widget.onboardingInput.foodExceptions,
        foodPreferences: widget.onboardingInput.foodPreferences,
      );

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) =>
              OnboardingFinishScreen(recommendedDailyMacros: macros),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _isLoading = false;
      });

      print("ERROR HERE");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const LoadingScreen();

    if (_hasError) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Произошла ошибка при отправке данных.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitNutritionProfile,
                child: const Text('Попробовать заново'),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
