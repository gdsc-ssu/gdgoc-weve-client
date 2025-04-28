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
import 'package:weve_client/features/senior/presentation/viewmodels/senior_submit_viewmodel.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_submit_state.dart';
import 'package:weve_client/features/senior/presentation/views/input/senior_input_birth_screen.dart';
import 'package:weve_client/features/senior/presentation/views/input/senior_input_career_screen.dart';
import 'package:weve_client/features/senior/presentation/views/input/senior_input_value_screen.dart';
import 'package:weve_client/features/senior/presentation/views/senior_main_screen.dart';

final struggleSpeechProvider =
    StateNotifierProvider<SpeechToTextController, String>(
  (ref) => SpeechToTextController(),
);
final seniorSubmitProvider =
    StateNotifierProvider<SeniorSubmitViewModel, SeniorSubmitState>(
  (ref) => SeniorSubmitViewModel(),
);

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
                audioUrl: "audio/senior/senior_question_hardship.mp3",
                text: "어떤 고난이 있었고,\n어떻게 극복해 오셨나요?",
                gap: 100,
              ),
              SpeechToTextBox(speechTextProvider: struggleSpeechProvider),
              SizedBox(height: 64),
              SeniorButton(
                  text: "다음",
                  backgroundColor: WeveColor.main.yellow1_100,
                  textColor: WeveColor.main.yellowText,
                  onPressed: () async {
                    final birth = ref.read(birthSpeechProvider);
                    final job = ref.read(careerSpeechProvider);
                    final value = ref.read(valueSpeechProvider);
                    final hardship = ref.read(struggleSpeechProvider);

                    final submitViewModel =
                        ref.read(seniorSubmitProvider.notifier);

                    submitViewModel.updateBirth(birth);
                    submitViewModel.updateJob(job);
                    submitViewModel.updateValue(value);
                    submitViewModel.updateHardship(hardship);

                    await submitViewModel.submit(context);

                    final errorMessage =
                        ref.read(seniorSubmitProvider).errorMessage;
                    if (errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
