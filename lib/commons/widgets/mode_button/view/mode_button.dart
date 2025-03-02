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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Container(
        width: 165,
        height: 165,
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
