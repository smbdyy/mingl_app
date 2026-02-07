import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const NextButton({
    super.key,
    required this.onPressed,
    this.label = 'Далее',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
