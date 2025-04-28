import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/commons/widgets/senior/input_profile/view/stt_box.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/provider/speech_to_text_provider.dart';
import 'package:weve_client/features/senior/presentation/views/worries/senior_worry_confirm.dart';

final worrySpeechProvider =
    StateNotifierProvider<SpeechToTextController, String>(
  (ref) => SpeechToTextController(),
);

class SeniorWorrySpeechScreen extends ConsumerStatefulWidget {
  const SeniorWorrySpeechScreen({super.key});

  @override
  ConsumerState<SeniorWorrySpeechScreen> createState() =>
      _SeniorWorrySpeechScreenState();
}

class _SeniorWorrySpeechScreenState
    extends ConsumerState<SeniorWorrySpeechScreen> {
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
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '청년의 고민을 해결해주세요',
              style: WeveText.header2(color: WeveColor.gray.gray1),
            ),
            const SizedBox(height: 30),
            SpeechToTextBox(speechTextProvider: worrySpeechProvider),
            SizedBox(
              height: 64,
            ),
            SeniorButton(
                // @todo : 유저가 말하기 전까진 disabled
                text: "다 말했어요",
                backgroundColor: WeveColor.main.yellow1_100,
                textColor: WeveColor.main.yellowText,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeniorWorryConfirmScreen(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
