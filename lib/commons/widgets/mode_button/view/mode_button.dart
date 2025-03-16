import 'package:flutter/material.dart';
import 'package:weve_client/commons/widgets/mode_button/model/mode_type.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class ModeButton extends StatelessWidget {
  final ModeTypeModel modeTypeModel;
  final Widget targetScreen;
  const ModeButton(
      {super.key, required this.modeTypeModel, required this.targetScreen});

  @override
  Widget build(BuildContext context) {
    // 화면 너비를 가져옵니다.
    final screenWidth = MediaQuery.of(context).size.width;

    // 버튼 너비 계산: (화면 너비 - 좌우 패딩 40px - 버튼 사이 간격 20px) / 2
    final buttonWidth = (screenWidth - 60) / 2;

    // 버튼 높이는 너비와 동일하게 설정하여 정사각형 형태를 유지합니다.
    final buttonHeight = buttonWidth;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: modeTypeModel.color,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          modeTypeModel.text,
          style: WeveText.header1(color: WeveColor.gray.gray8),
        ),
      ),
    );
  }
}
