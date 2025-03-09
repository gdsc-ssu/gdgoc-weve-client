import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class LetterButtonOn extends StatelessWidget {
  final String countryName;
  final String countryEmoji;
  final VoidCallback onTap;

  const LetterButtonOn({
    super.key,
    required this.countryName,
    required this.countryEmoji,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 163,
        height: 140,
        decoration: BoxDecoration(
          color: WeveColor.main.yellow1_100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                CustomIcons.getIcon(CustomIcons.seniorLetterOn, size: 81),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "$countryEmoji $countryName",
              style: WeveText.header5(color: WeveColor.main.yellowText),
            ),
          ],
        ),
      ),
    );
  }
}
