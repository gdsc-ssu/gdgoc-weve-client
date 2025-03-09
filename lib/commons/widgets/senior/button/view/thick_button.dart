import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class ThickButton extends StatelessWidget {
  final String text;

  final void Function() onPressed;

  const ThickButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 350,
        height: 100,
        decoration: BoxDecoration(
          color: WeveColor.main.yellow1_100,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(text,
            style: WeveText.header3(color: WeveColor.main.yellowText)),
      ),
    );
  }
}
