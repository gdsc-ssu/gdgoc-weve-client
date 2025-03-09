import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class CustomIcons {
  static const String navHomeOff = 'assets/icons/nav_home_off.svg';
  static const String navHomeOn = 'assets/icons/nav_home_on.svg';
  static const String navWriteOff = 'assets/icons/nav_write_off.svg';
  static const String navWriteOn = 'assets/icons/nav_write_on.svg';
  static const String navUserOff = 'assets/icons/nav_user_off.svg';
  static const String navUserOn = 'assets/icons/nav_user_on.svg';
  static const String navLetterOff = 'assets/icons/nav_letter_off.svg';
  static const String navLetterOn = 'assets/icons/nav_letter_on.svg';
  static const String headerCancel = 'assets/icons/header_cancel.svg';
  static const String headerLeftArrow = 'assets/icons/header_left_arrow.svg';
  static const String juniorChat = 'assets/icons/junior_chat.svg';
  static const String juniorCheck = 'assets/icons/junior_check.svg';
  static const String juniorHeart = 'assets/icons/junior_heart.svg';
  static const String logo = 'assets/icons/logo.svg';
  static const String myEarth = 'assets/icons/my_earth.svg';
  static const String myEtc = 'assets/icons/my_etc.svg';
  static const String myMy = 'assets/icons/my_my.svg';
  static const String myPhone = 'assets/icons/my_phone.svg';
  static const String mySendActive = 'assets/icons/my_send_active.svg';
  static const String mySendDeactive = 'assets/icons/my_send_deactive.svg';
  static const String radioOff = 'assets/icons/radio_off.svg';
  static const String radioOn = 'assets/icons/radio_on.svg';
  static const String seniorCamera = 'assets/icons/senior_camera.svg';
  static const String seniorChat = 'assets/icons/senior_chat.svg';
  static const String seniorHeart = 'assets/icons/senior_heart.svg';
  static const String seniorLetterOff = 'assets/icons/senior_letter_off.svg';
  static const String seniorLetterOn = 'assets/icons/senior_letter_on.svg';
  static const String seniorLoud = 'assets/icons/senior_loud.svg';
  static const String seniorRecording = 'assets/icons/senior_record.svg';
  static const String seniorPeople = 'assets/icons/senior_people.svg';
  static const String popupCancel = 'assets/icons/popup_cancel.svg';
  static const String juniorProfile = 'assets/icons/junior_profile.svg';
  static const String seniorAudio = 'assets/icons/senior_audio.svg';

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
      return Icon(Icons.error,
          size: size, color: Colors.red); // 디버깅을 위해 오류 아이콘 표시
    }
  }
}
