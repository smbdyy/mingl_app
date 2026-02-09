import 'package:flutter/material.dart';
import 'package:mingl_app/core/macros/macros.dart';

class OnboardingFinishScreen extends StatelessWidget {
  final Macros recommendedDailyMacros; 

  const OnboardingFinishScreen({super.key, required this.recommendedDailyMacros});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль готов')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 64,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            const Text(
              'Профиль успешно создан!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
                'Ваши рекомендуемые макронутриенты:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              _buildMacroCard('Ккал', recommendedDailyMacros.kCal),
              _buildMacroCard('Белки', recommendedDailyMacros.proteinGrams),
              _buildMacroCard('Жиры', recommendedDailyMacros.fatGrams),
              _buildMacroCard('Углеводы', recommendedDailyMacros.carbohydrateGrams),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // todo main screen
              },
              child: const Text('Начать'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroCard(String label, int value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
