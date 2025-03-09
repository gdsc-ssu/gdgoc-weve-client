import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';
import 'package:weve_client/core/constants/fonts.dart';

class ProfileHeader extends StatelessWidget {
  final String gov;
  final int age;
  final String name;
  final String avatarImage;

  const ProfileHeader({
    super.key,
    required this.gov,
    required this.age,
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
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$gov에 사는 $age세",
              style: WeveText.header4(color: WeveColor.gray.gray1),
            ),
            Text(
              "$name의 고민",
              style: WeveText.header4(color: WeveColor.gray.gray1),
            ),
          ],
        ),
      ],
    );
  }
}
