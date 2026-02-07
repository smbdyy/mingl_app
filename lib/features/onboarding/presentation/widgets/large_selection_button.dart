import 'package:flutter/material.dart';

class LargeSelectionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const LargeSelectionButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
