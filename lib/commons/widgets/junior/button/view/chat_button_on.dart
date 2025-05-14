import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class ChatButtonOn extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  const ChatButtonOn({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: WeveColor.bg.bg3,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: WeveText.header4(color: WeveColor.main.yellowText),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: double.infinity,
              height: 53,
              decoration: BoxDecoration(
                color: WeveColor.main.yellow4,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                buttonText,
                style: WeveText.semiHeader4(color: WeveColor.main.yellow1_20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
