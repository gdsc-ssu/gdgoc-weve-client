import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

// 프로필 색상 열거형
enum ProfileColor { blue, green, pink, orange, yellow }

class CustomProfile {
  static const String profileBlue = 'assets/profiles/profile_blue.svg';
  static const String profileGreen = 'assets/profiles/profile_green.svg';
  static const String profilePink = 'assets/profiles/profile_pink.svg';
  static const String profileOrange = 'assets/profiles/profile_orange.svg';
  static const String profileYellow = 'assets/profiles/profile_yellow.svg';

  static String getProfileByColor(ProfileColor color) {
    switch (color) {
      case ProfileColor.blue:
        return profileBlue;
      case ProfileColor.green:
        return profileGreen;
      case ProfileColor.pink:
        return profilePink;
      case ProfileColor.orange:
        return profileOrange;
      case ProfileColor.yellow:
        return profileYellow;
    }
  }

  static Widget getProfileIcon(ProfileColor color, {double size = 80}) {
    return SvgPicture.asset(
      getProfileByColor(color),
      width: size,
      height: size,
    );
  }
}
