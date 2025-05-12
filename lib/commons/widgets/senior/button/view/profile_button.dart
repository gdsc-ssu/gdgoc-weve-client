import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

enum SeniorProfileType { profile, language, phone, ask, etc }

class SeniorProfileButton extends StatelessWidget {
  final String text;
  final SeniorProfileType profileType;
  final VoidCallback? onTap;

  const SeniorProfileButton({
    super.key,
    required this.text,
    required this.profileType,
    this.onTap,
  });

  // 아이콘을 동적으로 찾는 함수
  String findIconData(SeniorProfileType type) {
    switch (type) {
      case SeniorProfileType.profile:
        return CustomIcons.myMy;
      case SeniorProfileType.language:
        return CustomIcons.myEarth;
      case SeniorProfileType.phone:
        return CustomIcons.myPhone;
      case SeniorProfileType.ask:
        return CustomIcons.mySendDeactive;
      case SeniorProfileType.etc:
        return CustomIcons.myEtc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: WeveColor.bg.bg3,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIcons.getIcon(findIconData(profileType), size: 24),
            const SizedBox(width: 10),
            Text(
              text,
              style: WeveText.header4(color: WeveColor.main.yellowText),
            ),
          ],
        ),
      ),
    );
  }
}
