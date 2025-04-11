import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class ErrorText extends StatelessWidget {
  final String text;
  final double topPadding;

  const ErrorText({
    Key? key,
    required this.text,
    this.topPadding = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: WeveText.body2(color: WeveColor.error.error1),
        ),
      ),
    );
  }
}
