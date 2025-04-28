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
import 'package:weve_client/features/senior/presentation/views/input/senior_input_career_screen.dart';

final birthSpeechProvider =
    StateNotifierProvider<SpeechToTextController, String>(
  (ref) => SpeechToTextController(),
);

class SeniorInputBirthScreen extends ConsumerWidget {
  const SeniorInputBirthScreen({super.key});

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
                audioUrl: "audio/senior/senior_question_birth.mp3",
                text: "태어난 날을 말해주세요",
                gap: 100,
              ),
              SpeechToTextBox(speechTextProvider: birthSpeechProvider),
              SizedBox(height: 64),
              SeniorButton(
                text: "다음",
                backgroundColor: WeveColor.main.yellow1_100,
                textColor: WeveColor.main.yellowText,
                onPressed: () async {
                  await ref.read(birthSpeechProvider.notifier).stopSpeech();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeniorInputCareerScreen(),
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
