import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';
import 'package:weve_client/core/constants/fonts.dart';

class JuniorWorryProfileheader extends StatelessWidget {
  final String gov;
  final String govIcon;
  final String name;
  final String avatarImage;

  const JuniorWorryProfileheader({
    super.key,
    required this.gov,
    required this.govIcon,
    required this.name,
    required this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CustomSvgImages.getSvgImage(avatarImage),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$govIcon $gov", //  🇰🇷 대한민국
              style: WeveText.body1(color: WeveColor.gray.gray2),
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: WeveText.header3(color: WeveColor.gray.gray1),
            ),
          ],
        ),
      ],
    );
  }
}
