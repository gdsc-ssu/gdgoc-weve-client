import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/box/view/input_box_worry.dart';
import 'package:weve_client/commons/widgets/junior/button/view/junior_profile_button.dart';
import 'package:weve_client/commons/widgets/junior/button/view/select_language_button.dart';
import 'package:weve_client/commons/widgets/junior/button/viewmodel/select_language_provider.dart';

class JuniorHomeScreen extends ConsumerWidget {
  const JuniorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Column(
      children: [
        SelectLanguageButton(
          text: "English",
          language: LanguageOption.english,
        ),
        SizedBox(height: 10),
        SelectLanguageButton(
          text: "한국어",
          language: LanguageOption.korean,
        ),
        SizedBox(height: 10),
        SelectLanguageButton(
          text: "日本語",
          language: LanguageOption.japanese,
        ),
      ],
    ));
  }
}
