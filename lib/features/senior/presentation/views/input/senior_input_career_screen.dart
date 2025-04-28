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
import 'package:weve_client/features/senior/presentation/views/input/senior_input_value_screen.dart';

final careerSpeechProvider =
    StateNotifierProvider<SpeechToTextController, String>(
  (ref) => SpeechToTextController(),
);

class SeniorInputCareerScreen extends ConsumerWidget {
  const SeniorInputCareerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerViewModel = ref.read(headerProvider.notifier);

    print(ref.watch(careerSpeechProvider));

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
                audioUrl: "audio/senior/senior_question_career.mp3",
                text: "어떤 직업을 가지셨나요?",
                gap: 100,
              ),
              SpeechToTextBox(speechTextProvider: careerSpeechProvider),
              SizedBox(height: 64),
              SeniorButton(
                text: "다음",
                backgroundColor: WeveColor.main.yellow1_100,
                textColor: WeveColor.main.yellowText,
                onPressed: () async {
                  await ref.read(careerSpeechProvider.notifier).stopSpeech();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeniorInputValueScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
