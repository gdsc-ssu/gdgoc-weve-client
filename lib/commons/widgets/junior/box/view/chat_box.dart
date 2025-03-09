import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class ChatBox extends StatelessWidget {
  final String title;
  final String text;

  const ChatBox({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: WeveColor.bg.bg3,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: WeveText.header4(color: WeveColor.main.yellowText),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: WeveColor.main.yellow4,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                text,
                style: WeveText.header4(color: WeveColor.main.yellow1_20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
