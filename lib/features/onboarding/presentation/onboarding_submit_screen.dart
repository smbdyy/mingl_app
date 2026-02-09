
import 'package:flutter/material.dart';
import 'package:mingl_app/core/macros/macros.dart';
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
  late Future<Macros> _submitFuture;

  @override
  void initState() {
    super.initState();
    _submitFuture = _submitNutritionProfile();
  }

  Future<Macros> _submitNutritionProfile() async {
    final accountService = getIt<AccountService>();

    return await accountService.setNutritionProfile(
      age: widget.onboardingInput.age!,
      weightKg: widget.onboardingInput.weightKg!,
      targetWeightKg: widget.onboardingInput.targetWeightKg!,
      heightCm: widget.onboardingInput.heightCm!,
      sex: widget.onboardingInput.sex!.serverValue,
      activityLevel: widget.onboardingInput.activityLevel!.serverValue,
      foodExceptions: widget.onboardingInput.foodExceptions,
      foodPreferences: widget.onboardingInput.foodPreferences,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Macros>(
        future: _submitFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return _buildErrorWidget(context, snapshot.error.toString());
          }

          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => OnboardingFinishScreen(recommendedDailyMacros: snapshot.data!),
                ),
              );
            });

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Ошибка при загрузке профиля',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Вернуться назад'),
          ),
        ],
      ),
    );
  }
}
