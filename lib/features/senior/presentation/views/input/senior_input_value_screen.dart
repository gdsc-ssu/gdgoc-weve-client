import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/commons/widgets/senior/input_profile/view/question_box.dart';
import 'package:weve_client/commons/widgets/senior/input_profile/view/stt_box.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/provider/speech_to_text_provider.dart';
import 'package:weve_client/features/senior/presentation/views/input/senior_input_struggle_screen.dart';

final valueSpeechProvider =
    StateNotifierProvider<SpeechToTextController, String>(
  (ref) => SpeechToTextController(),
);

class SeniorInputValueScreen extends ConsumerWidget {
  final String name;
  final String phoneNumber;
  final String birth;
  final String job;

  const SeniorInputValueScreen({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.birth,
    required this.job,
  });

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
                audioUrl: "audio/senior/senior_question_value.mp3",
                text: "어떤 가치관을 가지고\n살아오셨나요?",
                gap: 100,
              ),
              SpeechToTextBox(speechTextProvider: valueSpeechProvider),
              SizedBox(height: 64),
              SeniorButton(
                text: "다음",
                backgroundColor: WeveColor.main.yellow1_100,
                textColor: WeveColor.main.yellowText,
                onPressed: () async {
                  await ref.read(valueSpeechProvider.notifier).stopSpeech();
                  final value = ref.read(valueSpeechProvider);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeniorInputStruggleScreen(
                        name: name,
                        phoneNumber: phoneNumber,
                        birth: birth,
                        job: job,
                        value: value,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
