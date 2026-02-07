
import 'package:flutter/material.dart';

class LargeTextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? helperText;
  final int minLines;
  final int maxLines;

  const LargeTextInputField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.helperText,
    this.minLines = 5,
    this.maxLines = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            helperText: helperText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            'Вводится текстом в свободной форме',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }
}
