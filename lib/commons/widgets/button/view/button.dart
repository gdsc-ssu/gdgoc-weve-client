import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/fonts.dart';

class Button extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final void Function() onPressed;
  const Button(
      {super.key,
      required this.text,
      required this.backgroundColor,
      required this.textColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 310,
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(text, style: WeveText.semiHeader4(color: textColor)),
      ),
    );
  }
}
