import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class CustomIcons {
  static const String navHomeOff = 'assets/icons/nav_home_off.svg';
  static const String navHomeOn = 'assets/icons/nav_home_on.svg';
  static const String navWriteOff = 'assets/icons/nav_write_off.svg';
  static const String navWriteOn = 'assets/icons/nav_write_on.svg';
  static const String navUserOff = 'assets/icons/nav_user_off.svg';
  static const String navUserOn = 'assets/icons/nav_user_on.svg';

  static Widget getIcon(String assetName, {double size = 24, Color? color}) {
    try {
      return SvgPicture.asset(
        assetName,
        width: size,
        height: size,
        colorFilter:
            color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );
    } catch (e) {
      print('🚨 SVG 로드 실패: $assetName, 오류: $e');
      return Icon(Icons.error,
          size: size, color: Colors.red); // 디버깅을 위해 오류 아이콘 표시
    }
  }
}
