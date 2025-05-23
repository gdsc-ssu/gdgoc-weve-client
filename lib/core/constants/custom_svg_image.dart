import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgImages {
  static const String blankImage = 'assets/image/image_blank.svg';
  static const String middleLineLeft =
      'assets/image/image_middle_line_left.svg';
  static const String middleLineRight =
      'assets/image/image_middle_line_right.svg';
  static const String middleLine = 'assets/image/image_middle_line.svg';
  static const String writeBottom = 'assets/image/image_write_bottom.svg';
  static const String writeFull = 'assets/image/image_write_full.svg';
  static const String writeTop = 'assets/image/image_write_top.svg';
  static const String profileBlue = 'assets/icons/profile_blue.svg';
  static const String profileGreen = 'assets/icons/profile_green.svg';
  static const String profileOrange = 'assets/icons/profile_orange.svg';
  static const String profilePink = 'assets/icons/profile_pink.svg';
  static const String profileYellow = 'assets/icons/profile_yellow.svg';

  static Widget getSvgImage(String assetName, {Color? color}) {
    return SvgPicture.asset(
      fit: BoxFit.cover,
      width: double.infinity,
      assetName,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      placeholderBuilder: (context) => SizedBox(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
