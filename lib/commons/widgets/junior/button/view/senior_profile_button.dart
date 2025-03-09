import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class SeniorProfileButton extends StatelessWidget {
  const SeniorProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 64,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: WeveColor.bg.bg3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIcons.getIcon(CustomIcons.juniorProfile),
          SizedBox(width: 10),
          Text("어르신의 프로필 확인하기",
              style: WeveText.semiHeader4(color: WeveColor.main.yellowText)),
        ],
      ),
    );
  }
}
