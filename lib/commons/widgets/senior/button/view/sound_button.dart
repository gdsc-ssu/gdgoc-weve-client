import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class SoundButton extends StatelessWidget {
  final String text;

  const SoundButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 45,
      decoration: BoxDecoration(
        color: WeveColor.main.orange1_30,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Text(text,
          style: WeveText.semiHeader4(color: WeveColor.main.orange1)),
    );
  }
}
