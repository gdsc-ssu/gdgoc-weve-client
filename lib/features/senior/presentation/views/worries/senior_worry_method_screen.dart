import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/features/senior/presentation/views/worries/senior_worry_speech_screen.dart';
import 'package:weve_client/features/senior/presentation/views/worries/senior_worry_typing_screen.dart';
import 'package:weve_client/features/senior/presentation/views/worries/senior_worry_write_screen.dart';

enum WorryAnswerMethod {
  typing,
  speaking,
  writing,
}

class SeniorWorryMethodScreen extends ConsumerStatefulWidget {
  const SeniorWorryMethodScreen({super.key});

  @override
  ConsumerState<SeniorWorryMethodScreen> createState() =>
      _SeniorWorryMethodScreenState();
}

class _SeniorWorryMethodScreenState
    extends ConsumerState<SeniorWorryMethodScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final headerViewModel = ref.read(headerProvider.notifier);

      headerViewModel.setHeader(HeaderType.backLogo2, title: "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(),
      backgroundColor: WeveColor.bg.bg1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('어떻게 답하시겠어요?',
                  style: WeveText.header2(color: WeveColor.gray.gray1)),
              SizedBox(
                height: 80,
              ),
              Center(
                  child: _buildOptionButton(context, WorryAnswerMethod.typing)),
              const SizedBox(height: 20),
              Center(
                  child:
                      _buildOptionButton(context, WorryAnswerMethod.speaking)),
              const SizedBox(height: 20),
              Center(
                  child:
                      _buildOptionButton(context, WorryAnswerMethod.writing)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildOptionButton(BuildContext context, WorryAnswerMethod method) {
  String label;
  switch (method) {
    case WorryAnswerMethod.typing:
      label = '타자로 칠게요';
      break;
    case WorryAnswerMethod.speaking:
      label = '말로 할게요';
      break;
    case WorryAnswerMethod.writing:
      label = '글로 쓸게요';
      break;
  }

  return SizedBox(
    width: 350,
    height: 100,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: WeveColor.main.yellow1_100,
        foregroundColor: WeveColor.main.yellowText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: WeveText.header3(color: WeveColor.main.yellowText),
      ),
      onPressed: () {
        switch (method) {
          case WorryAnswerMethod.typing:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SeniorWorryTypingScreen()),
            );
          case WorryAnswerMethod.writing:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SeniorWorryWriteScreen()),
            );
            break;
          case WorryAnswerMethod.speaking:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SeniorWorrySpeechScreen()),
            );
            break;
        }
      },
      child: Text(label),
    ),
  );
}
