import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

enum ProfileType { profile, language, phone, ask, etc }

class JuniorProfileButton extends StatelessWidget {
  final String text;
  final ProfileType profileType;
  final VoidCallback? onTap;

  const JuniorProfileButton({
    super.key,
    required this.text,
    required this.profileType,
    this.onTap,
  });

  // 아이콘을 동적으로 찾는 함수
  String findIconData(ProfileType type) {
    switch (type) {
      case ProfileType.profile:
        return CustomIcons.myMy;
      case ProfileType.language:
        return CustomIcons.myEarth;
      case ProfileType.phone:
        return CustomIcons.myPhone;
      case ProfileType.ask:
        return CustomIcons.mySendDeactive;
      case ProfileType.etc:
        return CustomIcons.myEtc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350,
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
              style: WeveText.body2(color: WeveColor.gray.gray2),
            ),
          ],
        ),
      ),
    );
  }
}
