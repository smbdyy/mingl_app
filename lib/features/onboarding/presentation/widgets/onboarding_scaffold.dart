
import 'package:flutter/material.dart';

class OnboardingScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const OnboardingScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [body],
        ),
      ),
    );
  }
}
