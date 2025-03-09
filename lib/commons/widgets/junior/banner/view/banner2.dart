import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';

class Banner2 extends StatelessWidget {
  const Banner2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: CustomSvgImages.getSvgImage(CustomSvgImages.banner2),
    );
  }
}
