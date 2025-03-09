import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';

class SpeechButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isListening;

  const SpeechButton({
    super.key,
    required this.onTap,
    required this.isListening,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: WeveColor.main.orange1,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: CustomIcons.getIcon(CustomIcons.seniorRecording, size: 50),
      ),
    );
  }
}
