import 'package:flutter/material.dart';

class OnboardingSpacing extends StatelessWidget {
  final double height;

  const OnboardingSpacing({
    super.key,
    this.height = 24,
  });

  const OnboardingSpacing.small({super.key}) : height = 16;
  const OnboardingSpacing.large({super.key}) : height = 32;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
