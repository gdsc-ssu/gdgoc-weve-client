import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class JuniorHeader extends StatelessWidget {
  const JuniorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 260,
          height: 36,
          child: CustomIcons.getIcon(CustomIcons.logo),
        ),
        Text(
          "세대를 잇는 따뜻한 대화",
          style: WeveText.body3(color: WeveColor.main.orange2),
        )
      ],
    );
  }
}
