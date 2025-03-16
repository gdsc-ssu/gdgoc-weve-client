import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class SeniorInputField extends StatelessWidget {
  final String title;
  final String placeholder;

  const SeniorInputField({
    super.key,
    required this.title,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: WeveText.semiHeader4(color: WeveColor.gray.gray3)),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: WeveColor.bg.bg2,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: WeveText.semiHeader4(color: WeveColor.gray.gray5),
              border: InputBorder.none,
            ),
            style: WeveText.semiHeader4(color: WeveColor.gray.gray1),
          ),
        ),
      ],
    );
  }
}
