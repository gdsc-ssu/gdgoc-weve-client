import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBannerImages {
  static const String banner1En = 'assets/banner/banner1_en.svg';
  static const String banner1Jp = 'assets/banner/banner1_jp.svg';
  static const String banner1Kr = 'assets/banner/banner1_kr.svg';
  static const String banner2En = 'assets/banner/banner2_en.svg';
  static const String banner2Jp = 'assets/banner/banner2_jp.svg';
  static const String banner2Kr = 'assets/banner/banner2_kr.svg';

  static Widget getBannerImage(String assetName, {Color? color, Key? key}) {
    return SvgPicture.asset(
      key: key,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 100,
      assetName,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      placeholderBuilder: (context) => SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
