import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weve_client/commons/widgets/button/view/select_button.dart';
import 'package:weve_client/commons/widgets/junior/button/view/letter_button_off.dart';
import 'package:weve_client/commons/widgets/junior/button/view/letter_button_on.dart';
import 'package:weve_client/commons/widgets/popup/view/popup.dart';
import 'package:weve_client/commons/widgets/popup/viewmodel/popup_viewmodel.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/commons/widgets/senior/button/view/sound_button.dart';
import 'package:weve_client/commons/widgets/senior/button/view/thick_button.dart';
import 'package:weve_client/commons/widgets/senior/header/view/profile_header.dart';
import 'package:weve_client/commons/widgets/senior/input/view/input_box.dart';
import 'package:weve_client/commons/widgets/senior/input_profile/view/question_box.dart';
import 'package:weve_client/commons/widgets/senior/input_profile/view/stt_box.dart';
import 'package:weve_client/commons/widgets/senior/list_item/view/list_item.dart';
import 'package:weve_client/commons/widgets/senior/login/view/input_field.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';

class JuniorHomeScreen extends ConsumerWidget {
  const JuniorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPressed() {
      return;
    }

    return Column(
      children: [
        LetterButtonOff(
            countryName: "대한민국", countryEmoji: "🇰🇷", onTap: () {}),
        LetterButtonOn(countryName: "대한민국", countryEmoji: "🇰🇷", onTap: () {})
      ],
    );
  }
}
