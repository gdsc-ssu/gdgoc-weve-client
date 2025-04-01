import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class JuniorButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function() onPressed;

  const JuniorButton({
    super.key,
    required this.text,
    this.enabled = true,
    this.backgroundColor,
    this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // 활성화 상태에 따라 색상 결정
    final bgColor = backgroundColor ??
        (enabled ? WeveColor.main.yellow1_100 : WeveColor.main.yellow3);
    final txtColor = textColor ??
        (enabled ? WeveColor.main.yellowText : WeveColor.main.yellow4);

    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        width: double.infinity,
        height: 53,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: WeveText.semiHeader4(color: txtColor),
        ),
      ),
    );
  }
}
