import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/commons/widgets/senior/input_profile/view/question_box.dart';
import 'package:weve_client/commons/widgets/senior/input_profile/view/stt_box.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/features/senior/presentation/views/input/senior_input_value_screen.dart';
import 'package:weve_client/features/senior/presentation/views/senior_main_screen.dart';

class SeniorInputStruggleScreen extends ConsumerWidget {
  const SeniorInputStruggleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerViewModel = ref.read(headerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(HeaderType.backOnly, title: "");
    });

    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      appBar: HeaderWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              QuestionBox(
                audioUrl: "",
                text: "어떤 고난이 있었고,\n어떻게 극복해 오셨나요?",
                gap: 100,
              ),
              SpeechToTextBox(),
              SizedBox(
                height: 64,
              ),
              SeniorButton(
                  // @todo : 유저가 텍스트 50자 입력하기 전에 disabled
                  text: "다음",
                  backgroundColor: WeveColor.main.yellow1_100,
                  textColor: WeveColor.main.yellowText,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeniorMainScreen(),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
