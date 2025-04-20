import 'package:flutter/material.dart';

class SeniorInputField extends StatelessWidget {
  final String title;
  final String placeholder;
  final ValueChanged<String>? onChanged;

  const SeniorInputField({
    super.key,
    required this.title,
    required this.placeholder,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: placeholder,
            border: const OutlineInputBorder(),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
