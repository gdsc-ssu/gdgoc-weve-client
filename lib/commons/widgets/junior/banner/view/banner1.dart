import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';

class Banner1 extends StatelessWidget {
  const Banner1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: CustomSvgImages.getSvgImage(CustomSvgImages.banner1),
    );
  }
}
