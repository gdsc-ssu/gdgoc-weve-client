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
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: WeveText.header3(color: WeveColor.gray.gray1),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: WeveText.body2(color: WeveColor.gray.gray5),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
