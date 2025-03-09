import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class InputHeader extends StatelessWidget {
  final String title;
  final String text;
  const InputHeader({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: WeveText.header3(color: WeveColor.gray.gray1),
        ),
        Text(
          title,
          style: WeveText.body2(color: WeveColor.gray.gray5),
        )
      ],
    );
  }
}
